//
//  Book.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject {
	NSString* type_;	
	NSMutableDictionary* levels_;
}

@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSMutableDictionary* levels;

@end