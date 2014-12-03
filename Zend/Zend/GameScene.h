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

#define FULL_HEALTH     5.0f

#define HEALTH_BAR_SIZE 200.0f

#define HUD_DEFAULT_FONT @"Futura-CondensedMedium"

#define HEALTH_BAR_1_DEFAULT_POSITION_X 140
#define HEALTH_BAR_2_DEFAULT_POSITION_X 1300
#define HEALTH_BAR_DEFAULT_POSITION_Y   screenSize.height - hud.size.height + hud.size.height / 2

#define SCORE_LABEL_DEFAULT_POSITION_X  screenSize.width / 2
#define SCORE_LABEL_DEFAULT_POSITION_Y  screenSize.height - hud.size.height / 2 - 11

#define HUD_LABEL_1_DEFAULT_POSITION_X   65
#define HUD_LABEL_2_DEFAULT_POSITION_X   1375
#define HUD_LABEL_DEFAULT_POSITION_Y     screenSize.height - hud.size.height + 15

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property SKNode *world;
@property Level  *level;

@property NSInteger score;

@property CharacterFactory *cFactory;
@property PlatformFactory  *pFactory;

@property PlayerControl *controller1;
@property PlayerControl *controller2;

@property NSUInteger playersCount;
@property NSInteger  selectedLevel;
//@property BOOL       gameStarted;

@property CGPoint screenCenter;
@property CGSize  screenSize;

/* MENU ELEMENTS */

@property NSUInteger gameState;

@property SKSpriteNode *welcomeScreen;
@property SKSpriteNode *startScreen;
@property SKSpriteNode *pauseScreen;
@property SKSpriteNode *gameOverScreen;

@property CGRect playButton;
@property CGRect continueButton;
@property CGRect restartButton;
@property CGRect exitButton;

/* HUD ELEMENTS */

@property SKSpriteNode *hud;
@property SKSpriteNode *healthBarPlayer1;
@property SKSpriteNode *healthBarPlayer2;
@property SKLabelNode  *scoreLabel;


- (void)showWelcomeScreen;

- (void)startGame;
- (void)pauseGame;
- (void)continueGame;
- (void)restartGame;
- (void)gameOver;
- (void)exitGame;

- (void)updateHud;

@end
