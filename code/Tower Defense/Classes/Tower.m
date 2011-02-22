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

#define kSpriteOffset 32./2.
#define kTowerFireTime 2.f


@implementation Tower

-(id)initWithPosition:(CGPoint)position {
	if( (self = [super init]) ) {
		sprite_ = [CCSprite spriteWithFile:@"towersketch.jpg"];
		sprite_.scale = (1./5.25);
		[self addChild:sprite_];
		
		self.position = CGPointMake(position.x + kSpriteOffset, position.y + kSpriteOffset);
		
		[self loadProperties];
		
		[self schedule:@selector(fire:) interval:kTowerFireTime];
	}
	return self;
}

-(void)loadProperties {
	range_ = 90;
}

-(void)fire:(id)sender {
	NSMutableArray* possibleTargets = [[NSMutableArray alloc] init];
	
	for(Enemy* enemy in [[[Game gameController] level] enemies]) {
		if([self distanceFromEnemy:enemy] < range_) {
			ReallyBigKaBoomer* boomer = [[ReallyBigKaBoomer alloc] initWithTarget:enemy atPosition:self.position];
		}
	}
}

-(Float32)distanceFromEnemy:(Enemy*)enemy {
	CGPoint point = ccpSub(enemy.position, self.position);
	return (Float32)sqrt(point.x * point.x + point.y * point.y);
}

@end
