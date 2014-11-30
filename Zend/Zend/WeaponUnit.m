//
//  WeaponUnit.m
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "WeaponUnit.h"

@implementation WeaponUnit

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)fire {
    SKNode *node = self.parent;
    for (int i = 0; node && i < 2; ++i) {
        node = node.parent;
    }
    if (!node) {
        return;
    }
    Bullet *bullet = [[Bullet alloc] initWithImageNamed:@"Bullet.png"];
    bullet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bullet.frame.size.height/2];
    bullet.physicsBody.allowsRotation = NO;
    bullet.physicsBody.affectedByGravity = NO;
    bullet.physicsBody.dynamic = YES;
    bullet.physicsBody.categoryBitMask = BULLET;
    bullet.physicsBody.contactTestBitMask = ZOMBIE | PLATFORM | DYNAMIC_PLATFORM;
    bullet.physicsBody.collisionBitMask = ZOMBIE | PLATFORM | DYNAMIC_PLATFORM;
    NSLog(@"pew");
    bullet.position = [node convertPoint:self.position fromNode:self];
    bullet.zPosition = 100500;
    bullet.damage = 1;
    NSInteger dir;
    if (self.parent.parent.xScale < 0) {
        dir = -1;
    }
    else {
        dir = 1;
    }
    bullet.physicsBody.velocity = CGVectorMake(1000*dir, 0);
    [node addChild:bullet];
    //bullet.physicsBody.
}

@end
