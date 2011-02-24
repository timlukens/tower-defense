//
//  GamePersistenceController.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/24/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GamePersistenceController : NSObject {
	NSInteger money_;
}

@property (nonatomic, readwrite) NSInteger money;

+(GamePersistenceController*)sharedController;
-(void)addMoney:(NSInteger)amount;

@end
