//
//  GameLayer.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright Curious Brain 2011. All rights reserved.
//


#import "cocos2d.h"
#import "Level.h"

@interface Game : CCLayer {	
	Level* level_;
}

@property (readwrite, retain) Level* level;

+(id) scene;
+(Game*)gameController;

@end