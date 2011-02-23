//
//  BookController.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "BookController.h"


@implementation BookController

@synthesize books = books_;

static BookController* gBookController = nil;

+(BookController*)sharedController {
	@synchronized(gBookController){
		if(!gBookController){
			gBookController = [[BookController alloc] init];
		}
	}
	return gBookController;
}

-(id)init {
	if( (self = [super init]) ) {
		
	}
	return self;
}

@end
