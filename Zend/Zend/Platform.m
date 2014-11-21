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
    return platform;
}

- (void)setSpriteSize:(CGFloat)size {
    self.scale = size;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
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
    SKNode *ground = [[SKNode alloc] init]; // TODO сделать отдельный класс Ground
    CGPoint groundPoint1 = CGPointMake(-(self.frame.size.width / 2) + 5, self.frame.size.height / 2);
    CGPoint groundPoint2 = CGPointMake((self.frame.size.width / 2) - 5, self.frame.size.height / 2);
    ground.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:groundPoint1 toPoint:groundPoint2];
    ground.physicsBody.restitution = 0;
    ground.physicsBody.friction = 0.0;
    ground.physicsBody.allowsRotation = NO;
    ground.physicsBody.affectedByGravity = NO;
    ground.physicsBody.dynamic = YES;
    ground.physicsBody.categoryBitMask = GROUND;
    ground.physicsBody.collisionBitMask = 0;
    ground.physicsBody.contactTestBitMask = HUMAN | ZOMBIE;
    [self addChild:ground];
}

- (void)update {

}

@end
