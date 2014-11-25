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
    
    playButton = CGRectMake(1260, 0, 180, 100);
    exitButton = CGRectMake(0, 0, 180, 100);
}

- (void)startGame {
    gameStarted = YES;
    
    [startMenu removeFromParent];
    
    self.physicsWorld.gravity = CGVectorMake(0, -8);
    
    pFactory  = [[PlatformFactory alloc] init];
    cFactory  = [[CharacterFactory alloc] init];
    plControl = [[PlayerControl alloc] init];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"CyanBackground"];
    background.zPosition = -1;
    background.position  = screenCenter;
    [world addChild:background];
    
    level = [[Level alloc] initWithLevel:selectedLevel];
    [level buildOn:world];
    
    plControl.character = [cFactory createCharacter:PLAYER atPosition:CGPointMake(800, 600)];
    [world addChild:plControl.character];
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
    
    SKAction *wait   = [SKAction waitForDuration:5.0f];
    SKAction *fadeIn = [SKAction fadeOutWithDuration:1.0f];
    
    startMenu = [SKSpriteNode spriteNodeWithImageNamed:@"MenuScreen"];
    startMenu.zPosition = 1;
    startMenu.position  = screenCenter;
    startMenu.size      = screenSize;
    
    pauseMenu = [SKSpriteNode spriteNodeWithImageNamed:@"PauseScreen"];
    pauseMenu.zPosition = 1;
    pauseMenu.position  = screenCenter;
    pauseMenu.size      = screenSize;
    
    [world addChild:welcomeScreen];
    [world addChild:startMenu];
    
    [welcomeScreen runAction:wait completion:^{
        [welcomeScreen runAction:fadeIn];
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
    if (gameStarted) {
        world.position = CGPointMake(-(plControl.character.position.x - self.size.width / 2), -(plControl.character.position.y - self.size.height / 2));
        NSArray *ns = [world children];
        for (int i = 0; i < ns.count; ++i) {
            SKNode *node = [ns objectAtIndex:i];
            if ([node.name isEqualToString:@"DynamicPlatform"]) {
                DynamicPlatform *platform = (DynamicPlatform *)node;
                [platform update];
            }
            else if ([node.name isEqualToString:@"Character"]) {
                Character *character = (Character*)node;
                if((character.type == SZOMBIE || character.type == FZOMBIE) && !(rand()%77)) {

                }
                [character update];
            }
        }
    }
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (gameStarted) {
        NSArray *ns = [world children];
        for (int i = 0; i < ns.count; ++i) {
            SKNode *node = [ns objectAtIndex:i];
            if ([node.name isEqualToString:@"DynamicPlatform"]) {
                //DynamicPlatform *platform = (DynamicPlatform *)node;
            }
            else if ([node.name isEqualToString:@"Character"]) {
                Character *character = (Character*)node;
                if ((character.type == SZOMBIE || character.type == FZOMBIE)) {
                    NSInteger direction = plControl.character.position.x-character.position.x;
                    if(direction) {
                        direction = direction/abs((int)direction);
                    }
                    [character setDirection:direction];
                    [character run];
                }
            }
        }
    }
}

- (void)keyUp:(NSEvent *)theEvent {
    NSString * const character = [theEvent charactersIgnoringModifiers];
    unichar    const code      = [character characterAtIndex:0];
    [plControl keyUp:code];
}

- (void)keyDown:(NSEvent *)theEvent {
    unichar const code = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    [plControl keyDown:code];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody = contact.bodyA;
    SKPhysicsBody *secondBody = contact.bodyB;
    
#ifdef SHOW_DEBUG_INFO
    NSLog(@"Begin contact: %@ %@", firstBody.node.className, secondBody.node.className);
#endif
    
    if(firstBody.categoryBitMask == PLATFORM && [secondBody.node.name isEqualToString:@"Character"])
        [(Character*)secondBody.node setPlatform:(Platform *)firstBody.node];
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody = contact.bodyA;
    SKPhysicsBody *secondBody = contact.bodyB;
    
#ifdef SHOW_DEBUG_INFO
    NSLog(@"End contact: %@ %@", firstBody.node.className, secondBody.node.className);
#endif
    
    if(firstBody.categoryBitMask == PLATFORM && [secondBody.node.name isEqualToString:@"Character"])
        [(Character*)secondBody.node setPlatform:nil];
}
@end
