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

<<<<<<< HEAD
@interface GameScene : SKScene <SKPhysicsContactDelegate> {
=======
@interface GameScene : SKScene {
>>>>>>> quiz
    SKNode *world;
    Level  *level;
    
    SKSpriteNode *startMenu;
    SKSpriteNode *pauseMenu;
    
    CharacterFactory *cFactory;
<<<<<<< HEAD
    PlatformFactory *pFactory;
    PlayerControl *pl1Control, *pl2Control;
    Level *level;
=======
    PlatformFactory  *pFactory;
    PlayerControl    *plControl;
>>>>>>> quiz
}

@property CGPoint   screenCenter;
@property CGSize    screenSize;

@property NSInteger selectedLevel;
@property BOOL      gameStarted;

@property CGRect    playButton;
@property CGRect    exitButton;

@end
