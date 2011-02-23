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

@class Book;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Book* aBook;
	
	NSString* type_;
	NSInteger currentLevel_;
	NSString* name_;
}

-(XMLParser*)initXMLParser:(NSString*)type;

@end
