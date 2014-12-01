//
//  DeathLine.m
//  Zend
//
//  Created by Anton Yakimenko on 01.12.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "DeathLine.h"

@implementation DeathLine

+ (instancetype)lineWithFirstPoint:(CGPoint)firstPoint secondPoint:(CGPoint)secondPoint {
    DeathLine *deathLine = [[DeathLine alloc] init];
        deathLine.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:firstPoint toPoint:secondPoint];
        deathLine.physicsBody.restitution = 0;
        deathLine.physicsBody.friction = 0.0;
        deathLine.physicsBody.allowsRotation = NO;
        deathLine.physicsBody.affectedByGravity = NO;
        deathLine.physicsBody.dynamic = YES;
        deathLine.physicsBody.categoryBitMask = DEATH_LINE;
        deathLine.physicsBody.collisionBitMask = 0;
        deathLine.physicsBody.contactTestBitMask = HUMAN | ZOMBIE;
    return deathLine;
}

@end
