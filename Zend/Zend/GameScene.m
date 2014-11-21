//
//  GameScene.m
//  Zend
//
//  Created by Anton Yakimenko on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "GameScene.h"

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
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    background.size = self.size;
    [self addChild:world];
    [world addChild:background];
    
    level = [[Level alloc] initWithLevel:0];
    [level buildOn:world];
    
    plControl.character = [cFactory createCharacter:PLAYER atPosition:CGPointMake(800, 250)];
    [world addChild:plControl.character];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    CGPoint clickPosition = [theEvent locationInNode:world];
    Character *zombie;
    if(clickPosition.x > self.frame.size.width / 2) {
        zombie = [cFactory createCharacter:SZOMBIE atPosition:clickPosition];
    }
    else {
        zombie = [cFactory createCharacter:FZOMBIE atPosition:clickPosition];
    }
    [world addChild:zombie];
}

- (void)didSimulatePhysics {
    world.position = CGPointMake(-(plControl.character.position.x - self.size.width / 2), 0);// -(plControl.character.position.y - self.size.height / 2));
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
            [character update];
            if((character.type == SZOMBIE || character.type == FZOMBIE))
            {
                //[character jump];
            }
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
            }
        }
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    if(contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    else
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    NSLog(@"Begin contact: %@ %@", firstBody.node.className, secondBody.node.className);
    uint32_t contactBitMask = firstBody.categoryBitMask | secondBody.categoryBitMask;
    if((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & CHARACTER)
    {
    /*    Character *character = (Character*)secondBody.node;
        Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:platform];*/
    }
    else if(contactBitMask  == (HUMAN | ZOMBIE))
    {
        Character *zombie = (Character *)secondBody.node;
        [zombie stop];
    }
    else if((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & CHARACTER)
    {
        Platform *platform = (Platform *)firstBody.node.parent;
        Character *character = (Character*)secondBody.node;
        if(platform.physicsBody.categoryBitMask == DYNAMIC_PLATFORM)
        {
            [character setPlatform:platform];
            NSLog(@"lalka");
        }
        [character incGroundContacts];
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    if(contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    else
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    NSLog(@"End contact: %@ %@", firstBody.node.className, secondBody.node.className);
    uint32_t contactBitMask = firstBody.categoryBitMask | secondBody.categoryBitMask;
    if((firstBody.categoryBitMask & DYNAMIC_PLATFORM) && secondBody.categoryBitMask & CHARACTER)
    {
        Character *character = (Character*)secondBody.node;
        //Platform *platform = (Platform *)firstBody.node;
        [character setPlatform:nil];
    }
    else if(contactBitMask  == (HUMAN | ZOMBIE))
    {
        Character *zombie = (Character *)secondBody.node;
        [zombie run];
    }
    else if((firstBody.categoryBitMask & GROUND) && secondBody.categoryBitMask & CHARACTER)
    {
        Character *character = (Character*)secondBody.node;
        [character decGroundContacts];
    }
}
@end
