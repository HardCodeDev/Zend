//
//  GameScene.m
//  Zend
//
//  Created by Anton Yakimenko on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "GameScene.h"

//#define SHOW_DEBUG_INFO YES

@implementation GameScene

@synthesize world;
@synthesize level;

@synthesize score;

@synthesize cFactory;
@synthesize pFactory;

@synthesize controller1;
@synthesize controller2;

@synthesize selectedLevel;

@synthesize playersCount;
@synthesize screenCenter;
@synthesize screenSize;

@synthesize musicPlayer;

@synthesize gameState;

@synthesize welcomeScreen;
@synthesize startScreen;
@synthesize pauseScreen;
@synthesize gameOverScreen;

@synthesize playButton;
@synthesize continueButton;
@synthesize restartButton;
@synthesize exitButton;

@synthesize hud;
@synthesize healthBarPlayer1;
@synthesize healthBarPlayer2;
@synthesize scoreLabel;

- (void)initProperties {
    
    /* INIT BASIC PROPERTIES */
    
    selectedLevel = 0;
    score = 0;
    
    screenSize   = self.frame.size;
    screenCenter = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    
    /* CREATE MENU ELEMENTS */
    
    playButton     = CGRectMake(1275, 30, 0, 0);
    continueButton = CGRectMake(1115, 30, 275, 50);
    restartButton  = CGRectMake(690, 20, 60, 70);
    exitButton     = CGRectMake(50, 30, 0, 0);
    
    welcomeScreen = [SKSpriteNode spriteNodeWithImageNamed:@"WelcomeScreen"];
    welcomeScreen.zPosition = 51;
    welcomeScreen.position  = screenCenter;
    welcomeScreen.size      = screenSize;
    
    startScreen = [SKSpriteNode spriteNodeWithImageNamed:@"StartScreen"];
    startScreen.zPosition = 50;
    startScreen.position  = screenCenter;
    startScreen.size      = screenSize;
    
    pauseScreen = [SKSpriteNode spriteNodeWithImageNamed:@"PauseScreen"];
    pauseScreen.zPosition = 50;
    pauseScreen.position  = screenCenter;
    pauseScreen.size      = screenSize;
    
    gameOverScreen = [SKSpriteNode spriteNodeWithImageNamed:@"GameOverScreen"];
    gameOverScreen.zPosition = 50;
    gameOverScreen.position  = screenCenter;
    gameOverScreen.size      = screenSize;
    
    /* INIT PHYSICS WORLD */
    
    world = [[SKNode alloc] init];
    
    self.physicsWorld.gravity = CGVectorMake(0, -8);
    
    /* PREPARE PLAYERS AND ZOMBIES */
    
    cFactory  = [[CharacterFactory alloc] init];
    controller1 = [[PlayerControl alloc] init];
    controller2 = [[PlayerControl alloc] init];

}

- (void)didMoveToView:(SKView *)view {
    
    /* SETUP WELCOME SCREEN */
    
    [self initProperties];
/*
    SKSpriteNode *logoBackground = [SKSpriteNode spriteNodeWithImageNamed:@"LogoBackground"];
    [logoBackground setPosition:screenCenter];
    [logoBackground setSize:screenSize];
    [logoBackground setZPosition:90];
    
    SKSpriteNode *HardCodeLogo   = [SKSpriteNode spriteNodeWithImageNamed:@"HardCodeLogo"];
    [HardCodeLogo setPosition:screenCenter];
    [HardCodeLogo setZPosition:100];
    [HardCodeLogo setScale:0.8f];
    
    SKSpriteNode *SpriteKitLogo  = [SKSpriteNode spriteNodeWithImageNamed:@"SpriteKitLogo"];
    [SpriteKitLogo setPosition:screenCenter];
    [SpriteKitLogo setZPosition:100];
    [SpriteKitLogo setScale:0.8f];
    
    SKAction *runHardCode   = [SKAction runBlock:^{
        [self addChild:HardCodeLogo];
        [HardCodeLogo runAction:[SKAction scaleTo:1.0f duration:2.0f] completion:^{
            [HardCodeLogo runAction:[SKAction fadeOutWithDuration:0.2f] completion:^{
                [HardCodeLogo removeFromParent];
            }];
        }];
    }];
    
    SKAction *runSpriteKit = [SKAction runBlock:^{
        [self addChild:SpriteKitLogo];
        [SpriteKitLogo runAction:[SKAction scaleTo:1.0f duration:2.0f] completion:^{
            [SpriteKitLogo runAction:[SKAction fadeOutWithDuration:0.2f] completion:^{
                [SpriteKitLogo removeFromParent];
                [logoBackground removeFromParent];
            }];
        }];
    }];
    
    [self addChild:logoBackground];
    [self runAction:runHardCode];
    [self runAction:[SKAction waitForDuration:2.2f] completion:^{
        [self runAction:runSpriteKit];
    }];
    
    
    [self runAction:[SKAction waitForDuration:2.2f] completion:^{
        [self showWelcomeScreen];
    }];
*/
    [self showWelcomeScreen];
}
            
- (void)showWelcomeScreen {
    
    SKAction *wait    = [SKAction waitForDuration:0.5f];     // 5 seconds looks good for presentation
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0f]; // and 1 second for this line
    
    [self addChild:welcomeScreen];
    [self addChild:startScreen];
    
    [welcomeScreen runAction:wait completion:^{
        [welcomeScreen runAction:fadeOut];
        playButton = CGRectMake(1275, 30, 140, 50);
        exitButton = CGRectMake(50, 30, 100, 50);
    }];
    
    gameState = LAUNCHED;
    
}

- (void)startGame {
    
    [self debugConsole:@"startGame" at:@"begin" withState:gameState];
    
    NSError *error;
    NSURL   *soundURL = [[NSBundle mainBundle] URLForResource:@"EvilOnTheBeach" withExtension:@"mp3"];
    
    musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    [musicPlayer setVolume:1.0f];
    [musicPlayer prepareToPlay];
    [musicPlayer play];

    /* INIT CURRENT GAME GENERAL PROPERTIES */
    
    if (gameState == LAUNCHED) {
        [startScreen runAction:[SKAction fadeOutWithDuration:0.8f] completion:^{
            [startScreen removeFromParent];
        }];
    }
    
    else if (gameState == OVER) {
        [self addChild:gameOverScreen];
        [gameOverScreen runAction:[SKAction fadeOutWithDuration:0.8f] completion:^{
            [gameOverScreen removeFromParent];
        }];
    }
    
    else if (gameState == PAUSED) {
        [self addChild:pauseScreen];
        [pauseScreen runAction:[SKAction fadeOutWithDuration:0.8f] completion:^{
            [pauseScreen removeFromParent];
        }];
    }
   
    gameState = RUNNING;
    
    [self addChild:world];
    [self setScore:0];
    
    /* INIT CURRENT LEVEL PROPERTIES */
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"CyanBackground"];
    background.zPosition = -10;
    background.position  = screenCenter;
    [world addChild:background];
    
    level = [[Level alloc] initWithLevel:selectedLevel];
    [level buildOn:world];
    
    [world addChild:[DeathLine lineWithFirstPoint:CGPointMake(-100500, 0) secondPoint:CGPointMake(100500, 0)]];
    
    /* INIT PLAYERS */
    
    [controller1 setKeySet:0];
    [controller2 setKeySet:1];
    
    controller1.playerChar = [cFactory createCharacter:FRIEND atPosition:CGPointMake(800, 300)];
    controller2.playerChar = [cFactory createCharacter:PLAYER atPosition:CGPointMake(900, 350)];
    
    [world addChild:controller1.playerChar];
    [world addChild:controller2.playerChar];

    playersCount = 2;
    
    [controller1.playerChar.weapon setFirstSlotWeaponType:PISTOL];
    [controller2.playerChar.weapon setFirstSlotWeaponType:PISTOL];
    
    /* CREATE HUD */
    
    hud = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor]
                                         size:CGSizeMake(screenSize.width, screenSize.height * 0.05)];
    hud.alpha       = 0.2;
    hud.anchorPoint = CGPointMake(0, 0);
    hud.position    = CGPointMake(0, screenSize.height - hud.size.height);
    hud.zPosition   = 40;
    [self addChild:hud];
    
    /* CREATE PLAYERS LABELS */
    
    SKLabelNode *hudLabelPlayer1 = [SKLabelNode labelNodeWithFontNamed:HUD_DEFAULT_FONT];
    hudLabelPlayer1.text = @"Player 1";
    hudLabelPlayer1.fontSize = 25;
    hudLabelPlayer1.zPosition = 41;
    hudLabelPlayer1.fontColor = [SKColor whiteColor];
    hudLabelPlayer1.position = CGPointMake(HUD_LABEL_1_DEFAULT_POSITION_X,
                                           HUD_LABEL_DEFAULT_POSITION_Y);
    
    SKLabelNode *hudLabelPlayer2 = [SKLabelNode labelNodeWithFontNamed:HUD_DEFAULT_FONT];
    hudLabelPlayer2.text = @"Player 2";
    hudLabelPlayer2.fontSize = 25;
    hudLabelPlayer2.zPosition = 41;
    hudLabelPlayer2.fontColor = [SKColor whiteColor];
    hudLabelPlayer2.position = CGPointMake(HUD_LABEL_2_DEFAULT_POSITION_X,
                                           HUD_LABEL_DEFAULT_POSITION_Y);
    
    [self addChild:hudLabelPlayer1];
    [self addChild:hudLabelPlayer2];
    
    /* CREATE HEALTH BARS */
    
    healthBarPlayer1 = [SKSpriteNode spriteNodeWithImageNamed:@"HealthBar"];
    healthBarPlayer1.position = CGPointMake(HEALTH_BAR_1_DEFAULT_POSITION_X,
                                            HEALTH_BAR_DEFAULT_POSITION_Y);
    healthBarPlayer1.zPosition = 41;
    
    healthBarPlayer2 = [SKSpriteNode spriteNodeWithImageNamed:@"HealthBar"];
    healthBarPlayer2.position = CGPointMake(HEALTH_BAR_2_DEFAULT_POSITION_X,
                                            HEALTH_BAR_DEFAULT_POSITION_Y);
    healthBarPlayer2.zPosition = 41;
    
    [self addChild:healthBarPlayer1];
    [self addChild:healthBarPlayer2];
    
    /* CREATE SCORE COUNTER */
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:HUD_DEFAULT_FONT];
    scoreLabel.text = [NSString stringWithFormat:@"%zd", score];
    scoreLabel.fontSize  = 30;
    scoreLabel.fontColor = [SKColor greenColor];
    scoreLabel.zPosition = 41;
    scoreLabel.position  = CGPointMake(SCORE_LABEL_DEFAULT_POSITION_X,
                                       SCORE_LABEL_DEFAULT_POSITION_Y);
    
    [self addChild:scoreLabel];
    
    [self debugConsole:@"startGame" at:@"end" withState:gameState];
    
}

- (void)pauseGame {
    
    [self debugConsole:@"pauseGame" at:@"begin" withState:gameState];
    
    pauseScreen.alpha = 0.0f;
    [self addChild:pauseScreen];
    
    SKAction *fadeIn     = [SKAction fadeInWithDuration:0.1f];
    SKAction *pauseScene = [SKAction runBlock:^{self.scene.view.paused = YES;}];
    SKAction *switchState = [SKAction runBlock:^{gameState = PAUSED;}];
    
    SKAction *pauseSequence = [SKAction sequence:@[switchState, pauseScene]];
 
    [pauseScreen runAction:fadeIn completion:^{
        [pauseScreen runAction:pauseSequence];
    }];
    
    //gameState = PAUSED;
    
    [self debugConsole:@"pauseGame" at:@"end" withState:gameState];
    
}

- (void)continueGame {
    
    [self debugConsole:@"continueGame" at:@"begin" withState:gameState];
    
    self.scene.view.paused = NO;
    
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.1f];
    SKAction *switchState = [SKAction runBlock:^{gameState = RUNNING;}];
    SKAction *switchSequence = [SKAction sequence:@[switchState]];
    
    [pauseScreen runAction:fadeOut completion:^{
        [pauseScreen removeFromParent];
        [pauseScreen runAction:switchSequence];
    }];
    
    //gameState = RUNNING;
    
    [self debugConsole:@"continueGame" at:@"end" withState:gameState];
    
}

- (void)restartGame {
    
    [self debugConsole:@"restartGame" at:@"begin" withState:gameState];
    
    [world removeAllChildren];
    [self removeAllChildren];
    [self startGame];
    
    self.scene.view.paused = NO;
    
    [self debugConsole:@"restartGame" at:@"end" withState:gameState];
    
}

- (void)gameOver {
    
    [self debugConsole:@"gameOver" at:@"begin" withState:gameState];
    
    NSError *error;
    NSURL   *soundURL = [[NSBundle mainBundle] URLForResource:@"GameOver" withExtension:@"mp3"];
    
    [musicPlayer stop];
    musicPlayer = [musicPlayer initWithContentsOfURL:soundURL error:&error];
    [musicPlayer setVolume:0.3f];
    [musicPlayer prepareToPlay];
    [musicPlayer play];
    
    gameOverScreen.alpha = 0.0f;
    [self addChild:gameOverScreen];
    
    SKAction *wait   = [SKAction waitForDuration:1.0f];
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.0f];
    
    SKAction *pauseScene       = [SKAction runBlock:^{self.scene.view.paused = YES;}];
    SKAction *gameOverSequence = [SKAction sequence:@[fadeIn, pauseScene]];
    
    [gameOverScreen runAction:wait completion:^{
        [gameOverScreen runAction:gameOverSequence];
    }];
    
    gameState = OVER;
    
    [self debugConsole:@"gameOver" at:@"end" withState:gameState];
    
}

- (void)exitGame {
    
    [[NSApplication sharedApplication] terminate:self];
    
}

- (void)updateHud {
    
    CGFloat player1HealthRatio = controller1.playerChar.health / FULL_HEALTH;
    CGFloat player2HealthRatio = controller2.playerChar.health / FULL_HEALTH;
    
    [healthBarPlayer1 setSize:CGSizeMake(HEALTH_BAR_SIZE * player1HealthRatio, healthBarPlayer1.size.height)];
    [healthBarPlayer2 setSize:CGSizeMake(HEALTH_BAR_SIZE * player2HealthRatio, healthBarPlayer2.size.height)];
    
    healthBarPlayer1.position = CGPointMake(HEALTH_BAR_1_DEFAULT_POSITION_X + healthBarPlayer1.size.width / 2,
                                            HEALTH_BAR_DEFAULT_POSITION_Y);
    healthBarPlayer2.position = CGPointMake(HEALTH_BAR_2_DEFAULT_POSITION_X - healthBarPlayer2.size.width / 2,
                                            HEALTH_BAR_DEFAULT_POSITION_Y);
    
    scoreLabel.text = [NSString stringWithFormat:@"%zd", score];
    
}

- (void)mouseDown:(NSEvent *)theEvent {

    CGPoint clickPosition = [theEvent locationInNode:world];
    CGPoint menuClick     = [theEvent locationInNode:self];
    
    /* CHECK CLICKS ON START SCREEN */
    
    if (gameState == LAUNCHED) {
        if (CGRectContainsPoint(playButton, menuClick)) {
            [welcomeScreen removeFromParent];
            [self startGame];
        }
        else if (CGRectContainsPoint(exitButton, menuClick)) {
            [self exitGame];
        }
    }
    
    /* CHECK CLICKS DURING GAME PROCESS */
    
    else if (gameState == RUNNING) {
        Character *zombie;
        if(clickPosition.x > self.frame.size.width / 2) {
            zombie = [cFactory createCharacter:SZOMBIE atPosition:clickPosition];
        }
        else {
            zombie = [cFactory createCharacter:FZOMBIE atPosition:clickPosition];
        }
        [world addChild:zombie];
    }
    
    /* CHECK CLICKS ON PAUSE SCREEN */
    
    else if (gameState == PAUSED) {
        if (CGRectContainsPoint(continueButton, menuClick)) {
            [self continueGame];
        }
        else if (CGRectContainsPoint(exitButton, menuClick)) {
            [self exitGame];
        }
        else if (CGRectContainsPoint(restartButton, menuClick)) {
            [self restartGame];
        }
    }
    
    else if (gameState == OVER) {
        if (CGRectContainsPoint(restartButton, menuClick)) {
            [self restartGame];
        }
        else if (CGRectContainsPoint(exitButton, menuClick)) {
            [self exitGame];
        }
    }
    
}

- (void)didSimulatePhysics {
    
    if (gameState != RUNNING) {
        return;
    }
    
    NSArray *worldChilds = [world children];
    
    for (SKNode *node in worldChilds) {
        if ([node.name isEqualToString:@"DynamicPlatform"]) {
            DynamicPlatform *platform = (DynamicPlatform *)node;
            [platform update];
        }
        else if ([node.name isEqualToString:@"Character"]) {
            Character *character = (Character*)node;
            [character update];
            if ((character.type == SZOMBIE || character.type == FZOMBIE)) {
                //[character jump];
            }
        }
    }
    if (playersCount == 2) {
        Character *player1 = controller1.playerChar;
        Character *player2 = controller2.playerChar;
        
        if (player1.isAlive && player2.isAlive) {
            CGFloat player1X = player1.position.x;
            CGFloat player2X = player2.position.x;
            
            CGFloat player1XSpeed = player1.physicsBody.velocity.dx;
            CGFloat player2XSpeed = player2.physicsBody.velocity.dx;

            if(abs(player1X - player2X) > self.frame.size.width * 15 / 16) {
                if((player1X > player2X && player1XSpeed > 0) || (player1X < player2X && player1XSpeed < 0)) {
                    [controller1.playerChar stop];
                }
                if((player2X > player1X && player2XSpeed > 0) || (player2X < player1X && player2XSpeed < 0)) {
                    [controller2.playerChar stop];
                }
            }
            
            world.position = CGPointMake(-((player1.position.x + player2.position.x) / 2 - self.size.width / 2),
                                          -(player1.position.y + player2.position.y) / 2 + self.size.height / 2);
        }
        else if(player1.isAlive) {
            world.position = CGPointMake(-(player1.position.x - self.size.width / 2),
                                         -player1.position.y + self.size.height / 2);
        }
        else if(player2.isAlive) {
            world.position = CGPointMake(-(player2.position.x - self.size.width / 2),
                                         -player2.position.y + self.size.height / 2);
        }
    }
    else if (playersCount == 1) {
        if (controller1.playerChar.isAlive) {
            world.position = CGPointMake(-(controller1.playerChar.position.x - self.size.width / 2),
                                         -controller1.playerChar.position.y + self.size.height / 2);
        }
    }
    
}

- (void)keyUp:(NSEvent *)theEvent {
    
    NSString * const character = [theEvent charactersIgnoringModifiers];
    //unichar    const code      = [character characterAtIndex:0]; // for what?
    
    [controller1 keyUp:character];
    [controller2 keyUp:character];
    
}

- (void)keyDown:(NSEvent *)theEvent {
    
    NSString * const character = [theEvent charactersIgnoringModifiers];
    unichar    const code      = [character characterAtIndex:0];
    
    /* CHECK ESC BUTTON PRESSED */
    
    if (gameState == RUNNING && code == 27) {
        [self pauseGame];
        return;
    }
    else if (gameState == PAUSED && code == 27) {
        [self continueGame];
        return;
    }
    
    [controller1 keyDown:character];
    [controller2 keyDown:character];
    
}

- (void)update:(CFTimeInterval)currentTime {
    
    [self updateHud];
    
    /* CHECK STAGES CONTACT */
    
    if (level.stagesExist) {
        Stage *nextStage = [level.stages objectAtIndex:level.currentStage];
        if ((controller1.playerChar.position.x >= nextStage.position)
         || (controller2.playerChar.position.x >= nextStage.position)) {
            [level createNextPackOfZombiesOn:world];
        };
    }
    
    /* CHECK GAME IS OVER */
    
    if (gameState == RUNNING && !controller1.playerChar.isAlive && !controller2.playerChar.isAlive) {
        [self gameOver];
    }
    
    /* ?????????????????????? */
    
    NSArray *worldChilds = [world children];
    
    for (SKNode *node in worldChilds) {
        if ([node.name isEqualToString:@"Character"]) {
            Character *character = (Character*)node;
            if (character.physicsBody.categoryBitMask == ZOMBIE) {
                if (!character.target) {
                    if (playersCount == 1) {
                        if (controller1.playerChar.isAlive) {
                            [character attackTarget:controller1.playerChar];
                        }
                    }
                    else if (playersCount == 2){
                        CGFloat distance1 = abs(character.position.x - controller1.playerChar.position.x);
                        CGFloat distance2 = abs(character.position.x - controller2.playerChar.position.x);
                        if ((!controller2.playerChar.isAlive || distance1 < distance2) && controller1.playerChar.isAlive) {
                            [character attackTarget:controller1.playerChar];
                        }
                        else if (controller2.playerChar.isAlive){
                            [character attackTarget:controller2.playerChar];
                        }
                    }
                }
                CGFloat zombieX, zombieY, targetX, targetY, zombieWidth3;
                zombieX = character.position.x;
                zombieY = character.position.y;
                targetX = character.target.position.x;
                targetY = character.target.position.y;
                zombieWidth3 = character.frame.size.width / 3;
                CGFloat dx = zombieX - targetX;
                CGFloat dy = zombieY - targetY;
                if (character.target && dx * dx + dy * dy < zombieWidth3 * zombieWidth3) {
                    [character beginCollidingWithTarget];
                }
            }
        }
        else if ([node.name isEqualToString:@"Bullet"]) {
            Bullet *bullet = (Bullet *)node;
            CGPoint bulletPos = [self convertPoint:bullet.position fromNode:world];
            if (bulletPos.x < 0 || bulletPos.x > self.frame.size.width
                || bulletPos.y < 0 || bulletPos.y > self.frame.size.height) {
                [bullet removeFromParent];
            }
        }
    }
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    /* MAKE CONTACTING OBJECTS ORDERED */
    
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    else {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    
#ifdef SHOW_DEBUG_INFO
    NSLog(@"Begin contact: %@ %@", firstBody.node.className, secondBody.node.className);
#endif
    
    /* ANALYSE CONTACTING OBJECTS */
    
    uint32_t contactBitMask = firstBody.categoryBitMask | secondBody.categoryBitMask;
    
    if((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & (CHARACTER | CORPSE)) {
    /*    Character *character = (Character*)secondBody.node;
        Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:platform];*/
    }
    else if (contactBitMask  == (HUMAN | ZOMBIE)) {
        Character *human  = (Character *)firstBody.node;
        Character *zombie = (Character *)secondBody.node;
        if (human == zombie.target) {
            [zombie beginCollidingWithTarget];
        }
        else {
            [zombie attackTarget:human];
            [zombie beginCollidingWithTarget];
        }
    }
    else if ((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & (CHARACTER | CORPSE)) {
        Platform *platform = (Platform *)firstBody.node.parent;
        Character *character = (Character*)secondBody.node;
        if (platform.physicsBody.categoryBitMask == DYNAMIC_PLATFORM) {
            [character setPlatform:platform];
        }
        [character incGroundContacts];
    }
    else if ((firstBody.categoryBitMask | secondBody.categoryBitMask) == (ZOMBIE | BULLET)) {
        Character *zombie = (Character *)firstBody.node;
        if (zombie.isAlive) {
            Bullet *bullet = (Bullet *)secondBody.node;
            [bullet removeFromParent];
            [zombie applyDamage:bullet.damage];
            if (!zombie.isAlive) {
                score += 10;
            }
        }
    }
    else if ((firstBody.categoryBitMask & (PLATFORM | DYNAMIC_PLATFORM)) && (secondBody.categoryBitMask & BULLET)) {
        Bullet *bullet = (Bullet *)secondBody.node;
        [bullet removeFromParent];
    }
    else if ((firstBody.categoryBitMask & DEATH_LINE) && (secondBody.categoryBitMask & CHARACTER)) {
        Character *character = (Character *)secondBody.node;
        if (character.physicsBody.categoryBitMask == HUMAN) {
            [character runAction:[SKAction playSoundFileNamed:@"HumanFall.wav" waitForCompletion:NO]];
        }
        [character die];
    }
    
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    else {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    
#ifdef SHOW_DEBUG_INFO
    NSLog(@"End contact: %@ %@", firstBody.node.className, secondBody.node.className);
#endif
    
    uint32_t contactBitMask = firstBody.categoryBitMask | secondBody.categoryBitMask;
    if ((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & (CHARACTER | CORPSE)) {
        Character *character = (Character*)secondBody.node;
        //Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:nil];
    }
    else if (contactBitMask  == (HUMAN | ZOMBIE)) {
        Character *human  = (Character *)firstBody.node;
        Character *zombie = (Character *)secondBody.node;
        if (human == zombie.target) {
            [zombie endCollidingWithTarget];
        }
    }
    else if ((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & (CHARACTER | CORPSE)) {
        Platform *platform = (Platform *)firstBody.node.parent;
        Character *character = (Character*)secondBody.node;
        if (platform.physicsBody.categoryBitMask == DYNAMIC_PLATFORM) {
            [character setPlatform:nil];
        }
        [character decGroundContacts];
    }
    
}

- (void)debugConsole:(NSString *)method at:(NSString *)place withState:(NSInteger)state {
    NSString *currState = [NSString string];
    if (state == 0) {
        currState = @"LAUNCHED";
    }
    else if (state == 1) {
        currState = @"RUNNING";
    }
    else if (state == 2) {
        currState = @"PAUSED";
    }
    else if (state == 3) {
        currState = @"OVER";
    }
    else {
        currState = @"WRONG STATE";
    }
    NSLog(@"running [%@] at [%@] with state = %@ (%zd)", method, place, currState, state);
    NSLog(@" ----------------------------------------------------- ");
}

@end
