//
//  Tower.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "Tower.h"

#define kSpriteOffset 32./2.


@implementation Tower

-(id)initWithPosition:(CGPoint)position {
	if( (self = [super init]) ) {
		sprite_ = [CCSprite spriteWithFile:@"towersketch.jpg"];
		sprite_.scale = (1./5.25);
		[self addChild:sprite_];
		
		self.position = CGPointMake(position.x + kSpriteOffset, position.y + kSpriteOffset);
		
		[self schedule:@selector(fire:) interval:.5f];
	}
	return self;
}

-(void)fire:(id)sender {
	NSLog(@"pew pew");
}

@end
