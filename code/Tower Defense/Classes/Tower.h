//
//  Tower.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface Tower : CCNode {
	CCSprite* sprite_;
	Float32 range_;
	NSString* towerType_;
	
	NSInteger level_;
	NSString* name_;
	Float32 damage_;
	Float32 speed_;
	Float32 cost_;
	NSString* spriteImageName_;
}

@property (nonatomic, readonly) Float32 damage;

-(id)initWithPosition:(CGPoint)position;
-(Float32)distanceFromEnemy:(Enemy*)enemy;
-(void)loadProperties;

@end
