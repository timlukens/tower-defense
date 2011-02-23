//
//  BookController.h
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BookController : NSObject {
	NSMutableDictionary* books_;
}

@property (nonatomic, retain) NSMutableDictionary* books;

+(BookController*)sharedController;

@end
