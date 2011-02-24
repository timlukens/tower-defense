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
	NSMutableArray* resistences_;
	NSString* attackSound_;
	NSString* deathSound_;
	NSString* hp_;
	NSString* name_;
	NSString* damage_;
	NSString* speed_;
	NSString* spriteFileName_;
	NSString* worth_;
}

@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSMutableDictionary* levels;
@property (nonatomic, retain) NSMutableArray* resistences;
@property (nonatomic, retain) NSString* attackSound;
@property (nonatomic, retain) NSString* deathSound;
@property (nonatomic, retain) NSString* hp;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* damage;
@property (nonatomic, retain) NSString* speed;
@property (nonatomic, retain) NSString* spriteFileName;
@property (nonatomic, retain) NSString* worth;

@end