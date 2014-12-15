//
//  Bullet.m
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

@synthesize damage;

- (id)initWithImageNamed:(NSString *)imageName {
    self = [super initWithImageNamed:imageName];
    if (self) {
        self.name   = @"Bullet";
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.height / 2];
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = BULLET;
        self.physicsBody.contactTestBitMask = ZOMBIE | PLATFORM | DYNAMIC_PLATFORM;
        self.physicsBody.collisionBitMask = 0;
        self.zPosition = 30;
    }
    return self;
}

- (CGFloat)getDamage {
    return damage;
}

@end
