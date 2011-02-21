//
//  Tower.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Tower : CCNode {
	CCSprite* sprite_;
}

-(id)initWithPosition:(CGPoint)position;

@end
