//
//  GamePersistenceController.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/24/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "GamePersistenceController.h"
#import "GameScene.h"

#define kStartingMoney 10

@implementation GamePersistenceController

static GamePersistenceController* gController = nil;

@synthesize money = money_;

+(GamePersistenceController*)sharedController {
	@synchronized(gController){
		if(!gController){
			gController = [[GamePersistenceController alloc] init];
		}
	}
	return gController;
}

-(id)init {
	if( (self = [super init]) ) {
		money_ = kStartingMoney;
	}
	return self;
}

-(void)addMoney:(NSInteger)amount {
	money_ += amount;
	[[Game gameController].moneyLabel setString:[NSString stringWithFormat:@"Money: %d", money_]];
}

@end
