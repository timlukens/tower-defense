//
//  Book.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "Book.h"


@implementation Book

@synthesize type = type_;
@synthesize levels = levels_;
@synthesize resistences = resistences_;
@synthesize attackSound = attackSound_;
@synthesize deathSound = deathSound_;
@synthesize hp = hp_;
@synthesize name = name_;
@synthesize damage = damage_;
@synthesize speed = speed_;
@synthesize spriteFileName = spriteFileName_;

-(id)init {
	if( (self = [super init]) ) {
		
	}
	return self;
}

-(void) dealloc {
	[type_ release];
	[super dealloc];
}

@end

