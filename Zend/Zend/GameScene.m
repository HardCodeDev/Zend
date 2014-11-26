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

@synthesize screenCenter;
@synthesize screenSize;

@synthesize selectedLevel;
@synthesize gameStarted;

@synthesize playButton;
@synthesize exitButton;

- (void)initProperties {
    gameStarted   = NO;
    selectedLevel = 0;
    
    screenSize   = self.frame.size;
    screenCenter = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    
    playButton = CGRectMake(1260, 0, 0, 0);
    exitButton = CGRectMake(0, 0, 0, 0);
}

- (void)startGame {
    gameStarted = YES;
    
    [startMenu removeFromParent];
    
    self.physicsWorld.gravity = CGVectorMake(0, -8);
    
    pFactory  = [[PlatformFactory alloc] init];
    cFactory  = [[CharacterFactory alloc] init];
    pl1Control = [[PlayerControl alloc] init];
    pl2Control = [[PlayerControl alloc] init];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"CyanBackground"];
    background.zPosition = -1;
    background.position  = screenCenter;
    [world addChild:background];
    
    level = [[Level alloc] initWithLevel:selectedLevel];
    [level buildOn:world];
    
    [pl1Control setKeySet:0];
    [pl2Control setKeySet:1];
    pl1Control.playerChar = [cFactory createCharacter:FRIEND atPosition:CGPointMake(800, 300)];
    pl2Control.playerChar = [cFactory createCharacter:PLAYER atPosition:CGPointMake(900, 350)];
    [world addChild:pl1Control.playerChar];
    [world addChild:pl2Control.playerChar];
}

- (void)exitGame {
    [[NSApplication sharedApplication] terminate:self];
}

-(void)didMoveToView:(SKView *)view {
    /* Setup menu screen */
    [self initProperties];
    
    world = [[SKNode alloc] init];
    [self addChild:world];
    
    SKSpriteNode *welcomeScreen = [SKSpriteNode spriteNodeWithImageNamed:@"WelcomeScreenLight"];
    welcomeScreen.zPosition = 2;
    welcomeScreen.position = screenCenter;
    welcomeScreen.size = screenSize;
    
    SKAction *wait   = [SKAction waitForDuration:0.0f]; // 5 or more for presentation
    SKAction *fadeIn = [SKAction fadeOutWithDuration:1.0f];
    
    startMenu = [SKSpriteNode spriteNodeWithImageNamed:@"MenuScreen"];
    startMenu.zPosition = 1;
    startMenu.position  = screenCenter;
    startMenu.size      = screenSize;
    
    pauseMenu = [SKSpriteNode spriteNodeWithImageNamed:@"PauseScreen"];
    pauseMenu.zPosition = 1;
    pauseMenu.position  = screenCenter;
    pauseMenu.size      = screenSize;
    welcomeScreen.zPosition = 101;
    [self addChild:welcomeScreen];
    [self addChild:startMenu];
    
    [welcomeScreen runAction:wait completion:^{
        [welcomeScreen runAction:fadeIn];
        playButton = CGRectMake(1260, 0, 180, 100);
        exitButton = CGRectMake(0, 0, 180, 100);
    }];
}

- (void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    CGPoint clickPosition = [theEvent locationInNode:world];
    if (gameStarted) {
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
        if (CGRectContainsPoint(playButton, clickPosition)) {
            [self startGame];
        }
        else if (CGRectContainsPoint(exitButton, clickPosition)) {
            [self exitGame];
        }
    }
}

- (void)didSimulatePhysics {
    if (!gameStarted) {
        return;
    }
    NSArray *ns = [world children];
    for (int i = 0; i < ns.count; ++i) {
        SKNode *node = [ns objectAtIndex:i];
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
    CGPoint pl1Pos = [self convertPoint:pl1Control.playerChar.position fromNode:world];
    CGPoint pl2Pos = [self convertPoint:pl2Control.playerChar.position fromNode:world];
    CGFloat player1X = pl1Control.playerChar.position.x;
    CGFloat player2X = pl2Control.playerChar.position.x;
    NSInteger player1Dir = [pl1Control.playerChar getDirection];
    NSInteger player2Dir = [pl2Control.playerChar getDirection];
    /*if(abs(pl1Pos.x - pl2Pos.x) < self.frame.size.width/2)
     {
     if(pl1Pos.x > (3 * self.frame.size.width) / 4)
     {
     world.position = CGPointMake(-(pl1Control.playerChar.position.x - (3 * self.size.width) / 4), 0);
     }
     else if(pl1Pos.x < self.frame.size.width / 4)
     {
     world.position = CGPointMake(-(pl1Control.playerChar.position.x - self.size.width / 4), 0);
     }
     if(pl2Pos.x > (3 * self.frame.size.width) / 4)
     {
     world.position = CGPointMake(-(pl2Control.playerChar.position.x - (3 * self.size.width) / 4), 0);
     }
     else if(pl2Pos.x < self.frame.size.width / 4)
     {
     world.position = CGPointMake(-(pl2Control.playerChar.position.x - self.size.width / 4), 0);
     }
     }*/
    if(abs(player1X - player2X) > self.frame.size.width * 7 / 8) {
        if((player1X > player2X && player1Dir != -1) || (player1X < player2X && player1Dir != 1)) {
            [pl1Control.playerChar stop];
        }
        if((player2X > player1X && player2Dir != -1) || (player2X < player1X && player2Dir != 1)) {
            [pl2Control.playerChar stop];
        }
    }
    world.position = CGPointMake(-((pl1Control.playerChar.position.x + pl2Control.playerChar.position.x) / 2 - self.size.width / 2), -(pl1Control.playerChar.position.y + pl2Control.playerChar.position.y) / 2 + self.size.height / 2);// -(plControl.character.position.y - self.size.height / 2));
}

- (void)keyUp:(NSEvent *)theEvent {
    NSString * const character = [theEvent charactersIgnoringModifiers];
    unichar    const code      = [character characterAtIndex:0];
    [pl1Control keyUp:character];
    [pl2Control keyUp:character];
}
- (void)keyDown:(NSEvent *)theEvent {
    NSString * const character = [theEvent charactersIgnoringModifiers];
    unichar    const code      = [character characterAtIndex:0];
    [pl1Control keyDown:character];
    [pl2Control keyDown:character];
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    NSArray *ns = [world children];
    for(int i = 0; i < ns.count; ++i) {
        SKNode *node = [ns objectAtIndex:i];
        if ([node.name isEqualToString:@"DynamicPlatform"]) {
            //DynamicPlatform *platform = (DynamicPlatform *)node;
        }
        else if ([node.name isEqualToString:@"Character"]) {
            Character *character = (Character*)node;
            if ((character.type == SZOMBIE || character.type == FZOMBIE)) {
                NSInteger direction = pl1Control.playerChar.position.x-character.position.x;
                if (direction) {
                    direction = direction/abs((int)direction);
                }
                [character setDirection:direction];
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
    if((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & CHARACTER) {
    /*    Character *character = (Character*)secondBody.node;
        Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:platform];*/
    }
    else if (contactBitMask  == (HUMAN | ZOMBIE)) {
        Character *zombie = (Character *)secondBody.node;
        [zombie stop];
    }
    else if ((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & CHARACTER) {
        Platform *platform = (Platform *)firstBody.node.parent;
        Character *character = (Character*)secondBody.node;
        if (platform.physicsBody.categoryBitMask == DYNAMIC_PLATFORM) {
            [character setPlatform:platform];
        }
        [character incGroundContacts];
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
    if ((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & CHARACTER) {
        Character *character = (Character*)secondBody.node;
        //Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:nil];
    }
    else if (contactBitMask  == (HUMAN | ZOMBIE)) {
        Character *zombie = (Character *)secondBody.node;
        [zombie run];
    }
    else if ((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & CHARACTER) {
        Character *character = (Character*)secondBody.node;
        [character decGroundContacts];
    }
}
@end
