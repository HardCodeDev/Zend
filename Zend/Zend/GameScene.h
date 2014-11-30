//
//  GameScene.h
//  Zend
//

//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlatformFactory.h"
#import "CharacterFactory.h"
#import "PlayerControl.h"
#import "Level.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    SKNode *world;
    Level  *level;
    
    SKSpriteNode *startMenu;
    SKSpriteNode *pauseMenu;
    
    CharacterFactory *cFactory;
    PlatformFactory  *pFactory;
    PlayerControl    *pl1Control;
    PlayerControl    *pl2Control;
    
    NSUInteger playersCount;
}

@property CGPoint   screenCenter;
@property CGSize    screenSize;

@property NSInteger selectedLevel;
@property BOOL      gameStarted;

@property CGRect    playButton;
@property CGRect    exitButton;

@end
