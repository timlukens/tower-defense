//
//  GameLayer.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/21/11.
//  Copyright Curious Brain 2011. All rights reserved.
//


#import "cocos2d.h"
#import "Level.h"

#define kTileSize 32.

@interface Game : CCLayer {	
	Level* level_;
	CCLabel* moneyLabel_;
}

@property (readwrite, retain) Level* level;
@property (nonatomic, retain) CCLabel* moneyLabel;

+(id) scene;
+(Game*)gameController;
-(void)loadXml;

@end