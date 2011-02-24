//
//  Enemy.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCNode {
	CCSprite* sprite_;
	BOOL moving_;
	BOOL kill_;
	
	NSString* enemyType_;
	NSString* name_;
	Float32 damage_;
	Float32 speed_;
	
	Float32 hp_;
}

@property (nonatomic, readwrite) Float32 hp;

-(id)initWithEnemyType:(NSString*)enemyType atPosition:(CGPoint)position;
-(void)move;
-(CGPoint)tileCoordForPosition:(CGPoint)position;
-(void)moveTo:(CGPoint)gid;
-(BOOL)checkMove:(int)gid;
-(void)loadProperties;

@end
