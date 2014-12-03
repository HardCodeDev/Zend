//
//  Platform.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Platform.h"

@implementation Platform

+ (instancetype)platformWithImageNamed:(NSString *)imageName {
    Platform *platform = [[Platform alloc] initWithImageNamed:imageName];
    platform.name = @"Platform";
    platform.zPosition = 0;
    [platform initGroundLine];
    return platform;
}

- (void)setSpriteSize:(CGFloat)size {
    self.scale = size;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
}

- (void)initGroundLine {
    ground = [[GroundLine alloc] initFromRectWithWidth:self.frame.size.width height:self.frame.size.height];
    [self addChild:ground];
}

- (void)initPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 0.0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = PLATFORM;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = HUMAN | ZOMBIE;
}

- (void)update {

}

@end
