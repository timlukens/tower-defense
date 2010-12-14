//
//  MyPlayer.h
//  pr mock2
//
//  Created by Tim Lukens on 12/14/10.
//  Copyright 2010 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MyPlayer : CCNode {
	CCSprite* sprite_;
	int x_;
	int y_;
	int height_;
	int width_;
	
	bool isJumping_;
}

@property (nonatomic, readwrite, retain) CCSprite* sprite;
@property (readwrite) int x;
@property (readwrite) int y;
@property (readwrite) int height;
@property (readwrite) int width;

-(void)update;
-(void)jump;
-(void)doneJumping:(id)sender;

@end
