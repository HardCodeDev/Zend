//
//  FatZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "FatZombie.h"

@implementation FatZombie

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    Character *newFatZombie = [[FatZombie alloc] initWithImageNamed:@"FatZombie.png"];
    [newFatZombie initPhysicsBody];
    newFatZombie.type      = cType;
    newFatZombie.jumpSpeed = 700;
    newFatZombie.runSpeed  = 100;
    newFatZombie.position  = position;
    return newFatZombie;
}

- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask    = ZOMBIE;
    self.physicsBody.collisionBitMask   = PLATFORM;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN | ZOMBIE;
    self.physicsBody.friction = 0;
    self.physicsBody.mass     = 1;
}

@end
