//
//  Bonus.m
//  Zend
//
//  Created by Nikita Makarov on 07/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Bonus.h"

@implementation Bonus

@synthesize type;
@synthesize duration;

- (id)initAtPosition:(CGPoint)position {
    return [super init];
}

- (void)applyTo:(Character *)player {
    return;
}

- (void)initPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 0.0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = BONUS;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = HUMAN;
    
}

@end
