//
//  GameLayer.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright Curious Brain 2011. All rights reserved.
//

#import "GameScene.h"

static Game* gGameScene = nil;

@implementation Game

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
		level_ = [[Level node] initWithLevel:1];
		[self addChild:level_ z:-1];
		self.isTouchEnabled = YES;
	}
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

@end
