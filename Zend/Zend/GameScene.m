//
//  GameScene.m
//  Zend
//
//  Created by Anton Yakimenko on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "GameScene.h"
#define GREEN [NSColor colorWithCalibratedRed:0 green:1.0f blue:0 alpha:1.0f]
@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    pFactory = [[PlatformFactory alloc] init];
    cFactory = [[CharacterFactory alloc] init];
    plControl = [[PlayerControl alloc] init];
    world = [[SKNode alloc] init];
    self.physicsWorld.gravity = CGVectorMake(0, -8);
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Background.png"];
    background.zPosition = -1;
    background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    background.size = self.size;
    [self addChild:world];
    [world addChild:background];
    
    
    Platform *platform = [pFactory createPlatformWithImageNamed:@"ground.png" atPosition:CGPointMake(700, 500) zRotation:1];
    
    Platform *dynPlatform = [pFactory createDynamicPlatformWithImageNamed:@"ground.png"
                                                            beginPosition:CGPointMake(800, 1000)
                                                              endPosition:CGPointMake(800, 1000)
                                                                    speed:0.5
                                                                zRotation:0];
    [world addChild:[pFactory createDynamicPlatformWithImageNamed:@"ground.png"
                                                    beginPosition:CGPointMake(0, 0)
                                                      endPosition:CGPointMake(0, 500)
                                                            speed:0.5
                                                        zRotation:0] ];
    [world addChild:[pFactory createDynamicPlatformWithImageNamed:@"ground.png"
                                                    beginPosition:CGPointMake(1200, 500)
                                                      endPosition:CGPointMake(2000, 1000)
                                                            speed:0.5
                                                        zRotation:0] ];
    [world addChild:platform];
    [world addChild:dynPlatform];
    
    plControl.character = [cFactory createCharacter:PLAYER];
    [plControl.character setPosition:CGPointMake(800, 600)];
    [world addChild:plControl.character];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    CGPoint clickPosition = [theEvent locationInNode:world];
    Character *zombie;
    if(clickPosition.x > self.frame.size.width / 2) {
        zombie = [cFactory createCharacter:SZOMBIE];
    }
    else {
        zombie = [cFactory createCharacter:FZOMBIE];
    }
    zombie.position = clickPosition;
    [world addChild:zombie];
}

- (void)didSimulatePhysics {
    world.position = CGPointMake(-(plControl.character.position.x - self.size.width / 2), -(plControl.character.position.y - self.size.height / 2));
    NSArray *ns = [world children];
    for(int i=0; i<ns.count; ++i)
    {
        SKNode *node = [ns objectAtIndex:i];
        if([node.name isEqualToString:@"DynamicPlatform"])
        {
            DynamicPlatform *platform = (DynamicPlatform *)node;
            [platform update];
        }
        else if([node.name isEqualToString:@"Character"])
        {
            Character *character = (Character*)node;
            if((character.type == SZOMBIE || character.type == FZOMBIE) && !(rand()%77))
            {

            }
            [character update];
        }
    }
}

- (void) keyUp:(NSEvent *)theEvent
{
    NSString*   const   character   =   [theEvent charactersIgnoringModifiers];
    unichar     const   code        =   [character characterAtIndex:0];
    [plControl keyUp:code];
}
- (void) keyDown:(NSEvent *)theEvent
{
    unichar const code = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    [plControl keyDown:code];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    NSArray *ns = [world children];
    for(int i=0; i<ns.count; ++i)
    {
        SKNode *node = [ns objectAtIndex:i];
        if([node.name isEqualToString:@"DynamicPlatform"])
        {
            //DynamicPlatform *platform = (DynamicPlatform *)node;

        }
        else if([node.name isEqualToString:@"Character"])
        {
            Character *character = (Character*)node;
            if((character.type == SZOMBIE || character.type == FZOMBIE))
            {
                NSInteger direction = plControl.character.position.x-character.position.x;
                if(direction)
                    direction = direction/abs((int)direction);
                [character setDirection:direction];
                [character run];
            }
        }
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody = contact.bodyA;
    SKPhysicsBody *secondBody = contact.bodyB;
    NSLog(@"Begin contact: %@ %@", firstBody.node.className, secondBody.node.className);
    if(firstBody.categoryBitMask == PLATFORM && [secondBody.node.name isEqualToString:@"Character"])
        [(Character*)secondBody.node setPlatform:(Platform *)firstBody.node];
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody = contact.bodyA;
    SKPhysicsBody *secondBody = contact.bodyB;
    NSLog(@"End contact: %@ %@", firstBody.node.className, secondBody.node.className);
    if(firstBody.categoryBitMask == PLATFORM && [secondBody.node.name isEqualToString:@"Character"])
        [(Character*)secondBody.node setPlatform:nil];
}
@end
