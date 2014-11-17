//
//  Platform.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Platform.h"

@implementation Platform

+ (instancetype)platformWithImageNamed:(NSString *)imageName
{
    Platform *platform = [[Platform alloc] initWithImageNamed:imageName];
    return platform;
}

- (void)setSpriteSize:(CGFloat) size
{
    self.scale = size;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
}

- (void)initPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 1000.0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = 1;
    self.physicsBody.collisionBitMask = 0;
}

- (void)update
{

}

@end
