//
//  Stage.m
//  Zend
//
//  Created by Nikita Makarov on 01/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Stage.h"

@implementation Stage

@synthesize amountOfZombies;

- (id)initAndCreateAtPosition:(CGFloat)position withZombiesAmount:(NSInteger)amount {
    self = [super initWithImageNamed:@"Cat"];
    if (self) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 2048)];
        
        self.physicsBody.categoryBitMask    = STAGE;
        self.physicsBody.collisionBitMask   = 0;
        self.physicsBody.contactTestBitMask = HUMAN;
        
        self.physicsBody.affectedByGravity = NO;

        self.position = CGPointMake(position, 0);
        self.zPosition = 21;
        self.amountOfZombies = amount;
    }
    return self;
}

@end
