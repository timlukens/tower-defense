//
//  ReallyBigKaBoomer.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/22/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "ReallyBigKaBoomer.h"
#import "GameScene.h"

#define kBoomerTime 0.1f

@implementation ReallyBigKaBoomer

-(id)initWithTarget:(Enemy*)enemy atPosition:(CGPoint)position {
	if( (self=[super init]) ) {
		enemy_ = enemy;
		
		self.position = position;
		
		sprite_ = [CCSprite spriteWithFile:@"Icon.png"];
		sprite_.scale = .25f;
		
		[self addChild:sprite_];
		[[[Game gameController] level] addChild:self];
		
		id actionMove = [CCMoveTo actionWithDuration:kBoomerTime 
											position:enemy.position];
		id actionMoveDone = [CCCallFuncN actionWithTarget:self 
												 selector:@selector(spriteMoveFinished:)];
		[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	}
	return self;
}

-(void)spriteMoveFinished:(id)sender {
	[[[Game gameController] level].enemies removeObject:enemy_];
	[[[Game gameController] level] removeChild:enemy_ cleanup:NO];
	[[[Game gameController] level] removeChild:self cleanup:YES];
}

@end
