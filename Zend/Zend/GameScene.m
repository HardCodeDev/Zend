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
    world = [[SKNode alloc] init];
    self.physicsWorld.gravity = CGVectorMake(0, -8);
    [self addChild:world];
    
    Platform *platform = [pFactory createPlatformWithImageNamed:@"Spaceship" atPosition:CGPointMake(200, 200)];
    NSLog(@"%f", platform.position.x);
    [world addChild:platform];
    
    SKSpriteNode *spriteA = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    SKSpriteNode *spriteB = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    spriteA.scale = 0.5;
    spriteB.scale = 0.5;
    spriteA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteA.frame.size];
    spriteB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteB.frame.size];
    int x0 = 500;
    spriteA.position = CGPointMake(x0-300, 600);
    spriteB.position = CGPointMake(x0+100, 600);
   // spriteA.physicsBody.dynamic = NO;
    //spriteB.physicsBody.dynamic = NO;
    [world addChild:spriteA];
    [world addChild:spriteB];
    float x = spriteA.position.x;
    SKAction *a = [SKAction moveToY:(x+400) duration:1];
    SKAction *b = [SKAction moveToY:x duration:1];
    SKAction *sequence = [SKAction sequence:@[a,b]];
    [spriteA runAction:[SKAction repeatActionForever:sequence]];
    
    SKAction *c = [SKAction moveToX:(x+400) duration:1];
    SKAction *d = [SKAction moveToX:x duration:1];
    SKAction *sequence2 = [SKAction sequence:@[c,d]];
    [spriteB runAction:[SKAction repeatActionForever:sequence2]];
    
    spriteA.physicsBody.categoryBitMask = 1;
    spriteA.physicsBody.collisionBitMask = 3;
    spriteA.physicsBody.contactTestBitMask = 1;
    
    spriteB.physicsBody.categoryBitMask = 1;
    spriteB.physicsBody.collisionBitMask = 3;
    spriteB.physicsBody.contactTestBitMask = 1;
    
    platform.physicsBody.categoryBitMask = 2;
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    NSArray *ns = [world children];
    for(int i=0; i<ns.count; ++i)
    {
        SKNode *node = [ns objectAtIndex:i];
        if(node.position.y<0)
        {
            node.position = CGPointMake(node.position.x, 500);
        }
    }
}

@end
