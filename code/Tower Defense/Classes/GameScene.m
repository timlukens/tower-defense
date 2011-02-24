//
//  GameLayer.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright Curious Brain 2011. All rights reserved.
//

#import "GameScene.h"
#import "XMLParser.h"

@implementation Game

static Game* gGameScene = nil;

@synthesize level = level_;

+(id) scene
{
	CCScene *scene = [CCScene node];
	Game *layer = [Game node];
	[scene addChild: layer];
	return scene;
}

+(Game*)gameController {
	@synchronized(gGameScene){
		if(!gGameScene){
			gGameScene = [[Game alloc] init];
		}
	}
	return gGameScene;
}

-(id) init
{
	if( (self=[super init] )) {
		self.level = [[[Level node] initWithLevel:1] retain];
		[self addChild:level_ z:-1];
		self.isTouchEnabled = YES;
		
		NSString* path = [[NSBundle mainBundle] pathForResource:@"towers" ofType:@"xml"];
		NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
		NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
		
		XMLParser *parser = [[XMLParser alloc] initXMLParser:@"tower"];
		[xmlParser setDelegate:parser];
		[xmlParser parse];
		
		path = [[NSBundle mainBundle] pathForResource:@"enemies" ofType:@"xml"];
		url = [[NSURL alloc] initFileURLWithPath:path];
		xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
		
		parser = [[XMLParser alloc] initXMLParser:@"enemy"];
		[xmlParser setDelegate:parser];
		[xmlParser parse];
	}
	gGameScene = self;
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
													 priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[level_ ccTouchEnded:touch withEvent:event];
}

- (void) dealloc
{
	[super dealloc];
}

-(Level*)level {
	return level_;
}

@end
