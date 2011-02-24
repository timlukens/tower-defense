//
//  Enemy.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "Enemy.h"
#import "GameScene.h"
#import "XMLParser.h"
#import "BookController.h"
#import "Book.h"

#define kEnemyMoveTime 0.2f
#define kSpriteSize 32.f

@implementation Enemy

@synthesize hp = hp_;

-(id)initWithEnemyType:(NSString*)enemyType {
	if( (self = [super init]) ) {
		enemyType_ = enemyType;
		
		moving_ = NO;
		
		[self loadProperties];
	}
	return self;
}

-(void)loadProperties {
	NSString* path = [[NSBundle mainBundle] pathForResource:@"enemies" ofType:@"xml"];
	NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	XMLParser *parser = [[XMLParser alloc] initXMLParser:@"enemy"];
	[xmlParser setDelegate:parser];
	[xmlParser parse];
	
	NSMutableDictionary* theDict = [BookController sharedController].books;
	Book* aBook = [theDict objectForKey:[NSString stringWithFormat:@"enemy%@", enemyType_]];
	
	name_ = aBook.name;
	damage_ = [aBook.damage floatValue];
	speed_ = 1. / [aBook.speed floatValue];
	hp_ = [aBook.hp floatValue];
	
	sprite_ = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", aBook.spriteFileName]];
	[self addChild:sprite_];
}

-(void)move {
	if(!moving_) {
		moving_ = YES;
		Game* scene = [Game gameController];
		
		CGPoint tileCoord = [self tileCoordForPosition:self.position];
		int tileGidUp = [scene.level.meta tileGIDAt:CGPointMake(tileCoord.x, tileCoord.y - 1)];
		int tileGidDown = [scene.level.meta tileGIDAt:CGPointMake(tileCoord.x, tileCoord.y + 1)];
		int tileGidRight = [scene.level.meta tileGIDAt:CGPointMake(tileCoord.x + 1, tileCoord.y)];
		
		if (tileGidUp)
			if([self checkMove:tileGidUp])
				[self moveTo:CGPointMake(tileCoord.x, tileCoord.y - 1)];
		if (tileGidDown)
			if([self checkMove:tileGidDown])
				[self moveTo:CGPointMake(tileCoord.x, tileCoord.y + 1)];
		if (tileGidRight)
			if([self checkMove:tileGidRight])
				[self moveTo:CGPointMake(tileCoord.x + 1, tileCoord.y)];		
	}
}

-(BOOL)checkMove:(int)gid {
	Game* scene = [Game gameController];
	
	NSDictionary *properties = [scene.level.tileMap propertiesForGID:gid];
	if (properties) {
		//if movable
		NSString *movable = [properties valueForKey:@"Movable"];
		if (movable && [movable compare:@"true"] == NSOrderedSame) {
			return YES;
		}
		
		//if end
		NSString *end = [properties valueForKey:@"EndPoint"];
		if (end && [end compare:@"true"] == NSOrderedSame) {
			kill_ = YES;
			return YES;
		}
	}
	return NO;
}

-(void)moveTo:(CGPoint)position {
	Game* scene = [Game gameController];
	position.y -= .1;
	position = [scene.level.meta positionAt:position];
	
	id actionMove = [CCMoveTo actionWithDuration:kEnemyMoveTime 
										position:position];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(spriteMoveFinished:)];
	[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)spriteMoveFinished:(id)sender {
	Game* scene = [Game gameController];

	if(kill_) {
		[self removeChild:sprite_ cleanup:NO];
		[scene.level removeChild:self cleanup:YES];
		[scene.level.enemies removeObject:self];
	}
	moving_ = NO;
}

-(CGPoint)tileCoordForPosition:(CGPoint)position {
	Game* scene = [Game gameController];
	
    int x = position.x / scene.level.tileMap.tileSize.width;
    int y = ((scene.level.tileMap.mapSize.height * scene.level.tileMap.tileSize.height) - position.y) / scene.level.tileMap.tileSize.height;
    return ccp(x, y);
}

@end
