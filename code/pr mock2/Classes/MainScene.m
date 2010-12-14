//
//  MainLayer.m
//  pr mock2
//
//  Created by Tim Lukens on 12/10/10.
//  Copyright Curious Brain 2010. All rights reserved.
//

// Import the interfaces
#import "MainScene.h"

// Main implementation
@implementation Main

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Main *layer = [Main node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)addTarget {
	
	CCSprite *target = [CCSprite spriteWithFile:@"Target.png" 
										   rect:CGRectMake(0, 0, 27, 40)]; 
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.height/2;
	int maxY = winSize.height - target.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	actualY = winSize.height / 2;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
	[self addChild:target];
	
	// Determine speed of the target
	int minDuration = 1.0;
	int maxDuration = 4.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration 
										position:ccp(-target.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	target.tag = 1;
	[targets_ addObject:target];
}

-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	
	if (sprite.tag == 1) { // target
		[targets_ removeObject:sprite];
	}
}

-(void)gameLogic:(ccTime)dt {
	if(gameStarted_)
		[self addTarget];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[player_ jump];
}


- (void)update:(ccTime)dt {
	[player_ update];
	
	CGRect playerRect = CGRectMake(player_.x - (player_.width/2),
								   player_.y - (player_.height/8),
								   player_.width - (player_.width/2),
								   player_.height - (player_.height/2));
	
	for(CCSprite* target in targets_) {
		CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2),
									   target.position.y - (target.contentSize.height/8),
									   target.contentSize.width - (target.contentSize.width/2),
									   target.contentSize.height - (target.contentSize.height/2));
		if(CGRectIntersectsRect(playerRect, targetRect))
		{
			[self setUpMenus];
		}
	}
}


-(void)newGame:(id)sender {
	[self removeChild:menu_ cleanup:YES];
	for(CCSprite* target in targets_) {
		[self removeChild:target cleanup:YES];
	}
	[targets_ removeAllObjects];
	gameStarted_ = YES;
	[[CCDirector sharedDirector] resume];
}

-(void)quit:(id)sender {
	exit(0);
}

-(void)setUpMenus {
	gameStarted_ = NO;
	ccColor3B labelColor;
	labelColor.r = 255;
	labelColor.g = 0;
	labelColor.b = 0;
	
	CCLabel* ngLabel = [[CCLabel alloc] initWithString:@"New Game" fontName:@"Marker Felt" fontSize:64];
	CCLabel* qLabel = [[CCLabel alloc] initWithString:@"Quit" fontName:@"Marker Felt" fontSize:64];
	
	ngLabel.color = labelColor;
	qLabel.color = labelColor;
	
	CCMenuItemLabel *newGame = [CCMenuItemLabel itemWithLabel:ngLabel target:self selector:@selector(newGame:)];
	CCMenuItemLabel *quit = [CCMenuItemLabel itemWithLabel:qLabel target:self selector:@selector(quit:)];
	
	menu_ = [CCMenu menuWithItems:newGame, quit, nil];
	[menu_ alignItemsVertically];
	[self addChild:menu_];
	[[CCDirector sharedDirector] pause];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)] )) {
		self.isTouchEnabled = YES;
		
		targets_ = [[NSMutableArray alloc] init];
		player_ = [[MyPlayer alloc] init];
		
		[self setUpMenus];

		[self addChild:player_.sprite];
		[self schedule:@selector(gameLogic:) interval:1.0];
		[self schedule:@selector(update:)];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	[targets_ release];
	targets_ = nil;
	[player_ release];
	player_ = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
