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
=======
@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property SKNode *world;
@property Level  *level;

@property CharacterFactory *cFactory;
@property PlatformFactory  *pFactory;

@property PlayerControl *controller1;
@property PlayerControl *controller2;

@property SKSpriteNode *welcomeScreen;
@property SKSpriteNode *startScreen;
@property SKSpriteNode *pauseScreen;

@property NSUInteger playersCount;
@property NSInteger  selectedLevel;
@property BOOL       gameStarted;

@property CGPoint screenCenter;
@property CGSize  screenSize;

@property CGRect playButton;
@property CGRect continueButton;
@property CGRect restartButton;
@property CGRect exitButton;

- (void)showWelcomeScreen;

- (void)startGame;
- (void)pauseGame;
- (void)continueGame;
- (void)restartGame;
- (void)exitGame;
>>>>>>> quiz

@end
