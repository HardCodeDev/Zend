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
    Bullet *bullet = [[Bullet alloc] initWithImageNamed:@"Bullet.png"];
    bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.frame.size];
    bullet.physicsBody.allowsRotation = NO;
    bullet.physicsBody.affectedByGravity = NO;
    bullet.physicsBody.dynamic = YES;
    bullet.physicsBody.categoryBitMask = BULLET;
    bullet.physicsBody.contactTestBitMask = 0;
    //bullet.physicsBody.categoryBitMask = ZOMBIE;
    NSLog(@"pew");
    [self addChild:bullet];
    //bullet.physicsBody.
}

@end
