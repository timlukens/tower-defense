//
//  MainLayer.h
//  pr mock2
//
//  Created by Tim Lukens on 12/10/10.
//  Copyright Curious Brain 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "MyPlayer.h"

// Main Layer
@interface Main : CCColorLayer
{
	NSMutableArray *targets_;
	MyPlayer* player_;
	bool gameStarted_;
	CCMenu* menu_;
}

// returns a Scene that contains the Main as the only child
+(id) scene;

-(void)spriteMoveFinished:(id)sender;
-(void)addTarget;
-(void)gameLogic:(ccTime)dt;
-(void)update:(ccTime)dt;
-(void)setUpMenus;
-(void)quit:(id)sender;
-(void)newGame:(id)sender;

@end
