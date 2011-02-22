//
//  ReallyBigKaBoomer.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/22/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface ReallyBigKaBoomer : CCNode {
	CCSprite* sprite_;
	Enemy* enemy_;
}

-(id)initWithTarget:(Enemy*)enemy atPosition:(CGPoint)position;

@end
