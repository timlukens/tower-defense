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
		if(![BookController sharedController].books)
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
	
	//resistence
	else if([elementName isEqualToString:@"resistence"]) {
		if(!aBook.resistences)
			aBook.resistences = [[NSMutableArray alloc] init];
		
		if([attributeDict objectForKey:@"type"])
			currentResistenceType_ = [attributeDict objectForKey:@"type"];
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
		if([type_ isEqualToString:@"tower"])
			[[BookController sharedController].books setObject:aBook forKey:[NSString stringWithFormat:@"%@%@", type_, aBook.type]];
		else
			[[BookController sharedController].books setObject:aBook forKey:[NSString stringWithFormat:@"%@%@", type_, aBook.name]];
		
		[aBook release];
		aBook = nil;
	}
	
	else if([elementName isEqualToString:@"level"]) { }
	
	if([elementName isEqualToString:@"name"]) {
		name_ = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if([type_ isEqualToString:@"tower"]) {
			NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
			[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kNameIndex];
		}
		else
			aBook.name = name_;
	}
	else if([elementName isEqualToString:@"damage"]) {
		if([type_ isEqualToString:@"tower"]) {
			NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
			[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kDamageIndex];
		}
		else
			aBook.damage = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	else if([elementName isEqualToString:@"speed"]) {
		if([type_ isEqualToString:@"tower"]) {
			NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
			[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kSpeedIndex];
		}
		else
			aBook.speed = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	else if([elementName isEqualToString:@"cost"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kCostIndex];
	}
	else if([elementName isEqualToString:@"range"]) {
		NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
		[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kRangeIndex];
	}
	else if([elementName isEqualToString:@"spriteImageName"]) {
		if([type_ isEqualToString:@"tower"]) {
			NSMutableArray* level = [aBook.levels objectForKey:[NSString stringWithFormat:@"%d",currentLevel_]];
			[level insertObject:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] atIndex:kSpriteImageNameIndex];
		}
		else
			aBook.spriteFileName = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	else if([elementName isEqualToString:@"resistence"]) {
		NSString* amount = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if([currentResistenceType_ isEqualToString:@"stone"])
		   [aBook.resistences insertObject:amount atIndex:kResistenceStone];
		else if([currentResistenceType_ isEqualToString:@"fire"])
			[aBook.resistences insertObject:amount atIndex:kResistenceFire];
		else if([currentResistenceType_ isEqualToString:@"lightening"])
			[aBook.resistences insertObject:amount atIndex:kResistenceLightening];
		else if([currentResistenceType_ isEqualToString:@"ice"])
			[aBook.resistences insertObject:amount atIndex:kResistenceIce];
	}
	else if([elementName isEqualToString:@"attackSound"])
		aBook.attackSound = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	else if([elementName isEqualToString:@"deathSound"])
		aBook.deathSound = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	else if([elementName isEqualToString:@"hp"])
		aBook.hp = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	else if([elementName isEqualToString:@"worth"])
		aBook.worth = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	[currentElementValue release];
	currentElementValue = nil;
}

@end
