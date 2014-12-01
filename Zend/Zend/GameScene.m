//
//  GameScene.m
//  Zend
//
//  Created by Anton Yakimenko on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "GameScene.h"

//#define SHOW_DEBUG_INFO 1

@implementation GameScene

@synthesize world;
@synthesize level;

@synthesize cFactory;
@synthesize pFactory;

@synthesize controller1;
@synthesize controller2;

@synthesize welcomeScreen;
@synthesize startScreen;
@synthesize pauseScreen;

@synthesize selectedLevel;
@synthesize gameStarted;

@synthesize playersCount;
@synthesize screenCenter;
@synthesize screenSize;

@synthesize playButton;
@synthesize continueButton;
@synthesize restartButton;
@synthesize exitButton;

- (void)initProperties {

    gameStarted = NO;
    selectedLevel = 0;
    
    screenSize   = self.frame.size;
    screenCenter = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    
    playButton     = CGRectMake(1275, 30, 0, 0);
    continueButton = CGRectMake(1115, 30, 275, 50);
    restartButton  = CGRectMake(690, 20, 60, 70);
    exitButton     = CGRectMake(50, 30, 0, 0);
    
    welcomeScreen = [SKSpriteNode spriteNodeWithImageNamed:@"WelcomeScreen"];
    welcomeScreen.zPosition = 3;
    welcomeScreen.position  = screenCenter;
    welcomeScreen.size      = screenSize;
    
    startScreen = [SKSpriteNode spriteNodeWithImageNamed:@"StartScreen"];
    startScreen.zPosition = 2;
    startScreen.position  = screenCenter;
    startScreen.size      = screenSize;
    
    pauseScreen = [SKSpriteNode spriteNodeWithImageNamed:@"PauseScreen"];
    pauseScreen.zPosition = 100;
    pauseScreen.position  = screenCenter;
    pauseScreen.size      = screenSize;
    
    world = [[SKNode alloc] init];
    
    cFactory  = [[CharacterFactory alloc] init];
    controller1 = [[PlayerControl alloc] init];
    controller2 = [[PlayerControl alloc] init];
    
    self.physicsWorld.gravity = CGVectorMake(0, -8);
}

- (void)didMoveToView:(SKView *)view {
    /* Setup menu screen */
    [self initProperties];
    [self showWelcomeScreen];
}

- (void)showWelcomeScreen {
    SKAction *wait   = [SKAction waitForDuration:0.0f]; // 7
    SKAction *fadeIn = [SKAction fadeOutWithDuration:0.0f]; // 1
    
    [self addChild:welcomeScreen];
    [self addChild:startScreen];
    
    [welcomeScreen runAction:wait completion:^{
        [welcomeScreen runAction:fadeIn];
        playButton = CGRectMake(1275, 30, 140, 50);
        exitButton = CGRectMake(50, 30, 100, 50);
    }];
}

- (void)startGame {
    [self setGameStarted:YES];
    
    [self addChild:world];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"CyanBackground"];
    background.zPosition = -1;
    background.position  = screenCenter;
    [world addChild:background];
    
    level = [[Level alloc] initWithLevel:selectedLevel];
    [level buildOn:world];
    
    [controller1 setKeySet:0];
    [controller2 setKeySet:1];
    
    controller1.playerChar = [cFactory createCharacter:FRIEND atPosition:CGPointMake(800, 300)];
    controller2.playerChar = [cFactory createCharacter:PLAYER atPosition:CGPointMake(900, 350)];
    
    [world addChild:controller1.playerChar];
    [world addChild:controller2.playerChar];

    playersCount = 2;
    
    [controller1.playerChar.weapon setFirstSlotWeaponType:PISTOL];
    [controller2.playerChar.weapon setFirstSlotWeaponType:PISTOL];
}

- (void)pauseGame {
    SKAction *pauseAddChildAction = [SKAction runBlock:^{[self addChild:pauseScreen];}];
    SKAction *pauseSceneAction = [SKAction runBlock:^{self.scene.view.paused = YES;}];
    SKAction *pauseSequence = [SKAction sequence:@[pauseAddChildAction, pauseSceneAction]];
    
    [self runAction:[SKAction scaleTo:1 duration:0.0f]];
    [self runAction:pauseSequence];
}

- (void)continueGame {
    [pauseScreen removeFromParent];
    self.scene.view.paused = NO;
}

- (void)restartGame {
    [world removeAllChildren];
    [self removeAllChildren];
    [self startGame];
    
    self.scene.view.paused = NO;
}

- (void)exitGame {
    [[NSApplication sharedApplication] terminate:self];
}

- (void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    CGPoint clickPosition = [theEvent locationInNode:world];
    CGPoint menuClick     = [theEvent locationInNode:self];
    
    if (self.scene.view.paused) {
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
    
    else if (gameStarted) {
        Character *zombie;
        if(clickPosition.x > self.frame.size.width / 2) {
            zombie = [cFactory createCharacter:SZOMBIE atPosition:clickPosition];
        }
        else {
            zombie = [cFactory createCharacter:FZOMBIE atPosition:clickPosition];
        }
        [world addChild:zombie];
    }
    
    else {
        if (CGRectContainsPoint(playButton, menuClick)) {
            [startScreen removeFromParent];
            [welcomeScreen removeFromParent];
            [self startGame];
        }
        else if (CGRectContainsPoint(exitButton, menuClick)) {
            [self exitGame];
        }
    }
}

- (void)didSimulatePhysics {
    if (!gameStarted) {
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
    unichar    const code      = [character characterAtIndex:0];
    
    [controller1 keyUp:character];
    [controller2 keyUp:character];
}

- (void)keyDown:(NSEvent *)theEvent {
    NSString * const character = [theEvent charactersIgnoringModifiers];
    unichar    const code      = [character characterAtIndex:0];
    
    if (gameStarted == YES && self.scene.view.paused == NO && code == 27) { // ESC button
        [self pauseGame];
        return;
    }
    
    [controller1 keyDown:character];
    [controller2 keyDown:character];
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    NSArray *worldChilds = [world children];
    
    for (SKNode *node in worldChilds) {
        if ([node.name isEqualToString:@"DynamicPlatform"]) {
            //DynamicPlatform *platform = (DynamicPlatform *)node;
        }
        else if ([node.name isEqualToString:@"Character"]) {
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
            zombie.collidingWithTarget = YES;
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
        }
    }
    else if ((firstBody.categoryBitMask & (PLATFORM | DYNAMIC_PLATFORM)) && (secondBody.categoryBitMask & BULLET)) {
        Bullet *bullet = (Bullet *)secondBody.node;
        [bullet removeFromParent];
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
            zombie.collidingWithTarget = NO;
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

@end
