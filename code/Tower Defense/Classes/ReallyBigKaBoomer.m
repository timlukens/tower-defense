//
//  ReallyBigKaBoomer.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/22/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "ReallyBigKaBoomer.h"
#import "GameScene.h"
#import "GamePersistenceController.h"
#import "Tower.h"

#define kBoomerTime 0.1f

@implementation ReallyBigKaBoomer

-(id)initWithTarget:(Enemy*)enemy atPosition:(CGPoint)position withTower:(Tower*)tower {
	if( (self=[super init]) ) {
		enemy_ = enemy;
		
		self.position = position;
		
		sprite_ = [CCSprite spriteWithFile:@"Icon.png"];
		sprite_.scale = .25f;
		
		[self addChild:sprite_];
		[[[Game gameController] level] addChild:self];
		
		[self loadProperties:tower];
		
		id actionMove = [CCMoveTo actionWithDuration:kBoomerTime 
											position:enemy.position];
		id actionMoveDone = [CCCallFuncN actionWithTarget:self 
												 selector:@selector(spriteMoveFinished:)];
		[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	}
	return self;
}

-(void)loadProperties:(Tower*)tower {
	damage_ = tower.damage;
}

-(void)spriteMoveFinished:(id)sender {
	for(Enemy* enemy in [[[Game gameController] level].enemies allObjects]) {
		if(enemy == enemy_)
			enemy.hp -= damage_;
			
		if(enemy.hp <= 0) {
			[[[Game gameController] level].enemies removeObject:enemy];
			[[[Game gameController] level] removeChild:enemy cleanup:NO];
			[[GamePersistenceController sharedController] addMoney:enemy.worth];
		}
	}
	
	[[[Game gameController] level] removeChild:self cleanup:YES];
}

@end
