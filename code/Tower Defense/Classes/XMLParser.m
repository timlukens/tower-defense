//
//  XMLParser.m
//  Tower Defense
//
//  Created by Tim Lukens on 2/23/11.
//  Copyright 2011 Curious Brain. All rights reserved.
//

#import "XMLParser.h"
#import "BookController.h"
#import "Book.h"


@implementation XMLParser

-(XMLParser*)initXMLParser:(NSString*)type {
	if( (self = [super init]) ) {
		type_ = type;
	}
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	
	//top
	if([elementName isEqualToString:[NSString stringWithFormat:@"%@s", type_]]) {
		if([BookController sharedController].books)
			[[BookController sharedController].books release];
		[BookController sharedController].books = [[NSMutableDictionary alloc] init];
	}
	
	//type
	else if([elementName isEqualToString:type_]) {
		aBook = [[Book alloc] init];
		
		if([attributeDict objectForKey:@"type"])
			aBook.type = [attributeDict objectForKey:@"type"];
	}
	
	//level
	else if([elementName isEqualToString:@"level"]) {
		if(!aBook.levels)
			aBook.levels = [[NSMutableDictionary alloc] init];
		
		if([attributeDict objectForKey:@"number"]) {
			NSMutableArray* level = [[NSMutableArray alloc] init];
			currentLevel_ = [[attributeDict objectForKey:@"number"] integerValue];
			[level insertObject:[NSString stringWithFormat:@"%d",currentLevel_] atIndex:kLevelNumberIndex];
			[aBook.levels setObject:level forKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		}
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:[NSString stringWithFormat:@"%@s", type_]])
		return;
	
	if([elementName isEqualToString:type_]) {
		[[BookController sharedController].books setObject:aBook forKey:[NSString stringWithFormat:@"%@%@", type_, aBook.type]];
		
		[aBook release];
		aBook = nil;
	}
	
	else if([elementName isEqualToString:@"level"]) { }
	
	if([elementName isEqualToString:@"name"]) {
		name_ = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kNameIndex];
	}
	else if([elementName isEqualToString:@"damage"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kDamageIndex];
	}
	else if([elementName isEqualToString:@"speed"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kSpeedIndex];
	}
	else if([elementName isEqualToString:@"cost"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kCostIndex];
	}
	else if([elementName isEqualToString:@"spriteImageName"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kSpriteImageNameIndex];
	}
	
	[currentElementValue release];
	currentElementValue = nil;
}

@end
