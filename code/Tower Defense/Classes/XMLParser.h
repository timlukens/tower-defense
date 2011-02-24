//
//  XMLParser.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

enum kLevelPlacements {
	kLevelNumberIndex = 0,
	kNameIndex,
	kDamageIndex,
	kSpeedIndex,
	kCostIndex,
	kSpriteImageNameIndex
};

enum kResistencesPlacement {
	kResistenceStone = 0,
	kResistenceFire,
	kResistenceLightening,
	kResistenceIce
};

@class Book;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Book* aBook;
	
	NSString* type_;
	NSInteger currentLevel_;
	NSString* name_;
	NSString* currentResistenceType_;
}

-(XMLParser*)initXMLParser:(NSString*)type;

@end
