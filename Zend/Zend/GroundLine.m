//
//  GroundLine.m
//  Zend
//
//  Created by Anton Yakimenko on 22.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "GroundLine.h"

@implementation GroundLine

- (id)initFromRectWithWidth:(CGFloat)width height:(CGFloat)height {
    self = [super init];
    if(self) {
        CGPoint groundPoint1 = CGPointMake(-(width / 2) + 5, height / 2);
        CGPoint groundPoint2 = CGPointMake((width / 2) - 5, height / 2);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:groundPoint1 toPoint:groundPoint2];
        self.physicsBody.restitution = 0;
        self.physicsBody.friction = 0.0;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = GROUND;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = HUMAN | ZOMBIE;
    }
    return self;
}

@end
