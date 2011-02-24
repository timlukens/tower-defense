//
//  Tower.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "Tower.h"
#import "GameScene.h"
#import "ReallyBigKaBoomer.h"
#import "XMLParser.h"
#import "BookController.h"
#import "Book.h"

#define kSpriteOffset 32./2.
#define kTowerFireTime 0.2f


@implementation Tower

@synthesize damage = damage_;

-(id)initWithPosition:(CGPoint)position withTower:(NSString*)towerType {
	if( (self = [super init]) ) {
		towerType_ = towerType;
		
		[self loadProperties];
		[self setup:position];
	}
	return self;
}

-(void)loadProperties {
	range_ = 90;
	level_ = 1;

	NSMutableDictionary* theDict = [BookController sharedController].books;
	Book* aBook = [theDict objectForKey:[NSString stringWithFormat:@"tower%@", towerType_]];
	NSMutableArray* theTower = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d", level_]];
	
	name_ = [theTower objectAtIndex:kNameIndex];
	damage_ = [[theTower objectAtIndex:kDamageIndex] floatValue];
	speed_ = 1. / [[theTower objectAtIndex:kSpeedIndex] floatValue];
	cost_ = [[theTower objectAtIndex:kCostIndex] floatValue];
}

-(void)setup:(CGPoint)position {
	[self schedule:@selector(fire:) interval:speed_];
	
	sprite_ = [CCSprite spriteWithFile:@"towersketch.jpg"];
	sprite_.scale = (1./5.25);
	[self addChild:sprite_];
	
	self.position = CGPointMake(position.x + kSpriteOffset, position.y + kSpriteOffset);
}

-(void)fire:(id)sender {
	NSMutableArray* possibleTargets = [[NSMutableArray alloc] init];
	
	for(Enemy* enemy in [[[Game gameController] level] enemies]) {
		if([self distanceFromEnemy:enemy] < range_) {
			[[ReallyBigKaBoomer alloc] initWithTarget:enemy atPosition:self.position withTower:self];
			break;
		}
	}
}

-(Float32)distanceFromEnemy:(Enemy*)enemy {
	CGPoint point = ccpSub(enemy.position, self.position);
	return (Float32)sqrt(point.x * point.x + point.y * point.y);
}

@end
