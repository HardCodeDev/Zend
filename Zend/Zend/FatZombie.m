//
//  FatZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "FatZombie.h"

@implementation FatZombie

- (Character *)cloneWithType:(CharacterType)cType {
    Character *newFatZombie = [[FatZombie alloc] initWithImageNamed:@"FatZombieTexture"];
    newFatZombie.type = cType;
    [newFatZombie initPhysicsBody];
    return newFatZombie;
}

- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask = ZOMBIE;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN;
}

@end
