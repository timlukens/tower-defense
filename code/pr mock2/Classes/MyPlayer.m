//
//  MyPlayer.m
//  pr mock2
//
//  Created by Tim Lukens on 12/14/10.
//  Copyright 2010 Curious Brain. All rights reserved.
//

#import "MyPlayer.h"


@implementation MyPlayer

@synthesize sprite = sprite_;
@synthesize x = x_;
@synthesize y = y_;
@synthesize height = height_;
@synthesize width = width_;

-(id) init {
	if((self=[super init])) {
		sprite_ = [CCSprite spriteWithFile:@"Player.png"
										   rect:CGRectMake(0, 0, 27, 40)];
		x_ = sprite_.contentSize.width / 2;
		y_ = [[CCDirector sharedDirector] winSize].height / 2;
		height_ = sprite_.contentSize.height;
		width_ = sprite_.contentSize.width;
		sprite_.position = ccp(x_, y_);
		
		isJumping_ = NO;
	}
	return self;
}

-(void)update {
	x_ = sprite_.position.x;
	y_ = sprite_.position.y;
}

-(void)jump {
	if(!isJumping_) {
		float jumpSpeed = .3;
		float jumpCurve = 15;
		[sprite_ runAction:[CCSequence actions:[CCJumpTo actionWithDuration:jumpSpeed 
																		  position:CGPointMake(x_,
																							   y_ + 50)
																			height:jumpCurve 
																			 jumps:1],
								   [CCJumpTo actionWithDuration:jumpSpeed 
													   position:CGPointMake(x_, 
																			y_) 
														 height:jumpCurve 
														  jumps:1],
								   [CCCallFuncN actionWithTarget:self selector:@selector(doneJumping:)],
								   nil]]; //runAction
		
		isJumping_ = YES;
	}
}

-(void)doneJumping:(id)sender {
	isJumping_ = NO;
}

@end
