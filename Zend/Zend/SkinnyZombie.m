//
//  SkinnyZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "SkinnyZombie.h"

@implementation SkinnyZombie

- (Character *)cloneWithType:(CharacterType)cType {
    Character *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombieTexture"];
    newSkinnyZombie.name = @"SkinnyZombie";
    type = cType;
    [newSkinnyZombie initDefaultPhysicsProperties];
    [newSkinnyZombie initPhysicsBody];
    return newSkinnyZombie;
}

- (void)initPhysicsBody {
    self.physicsBody.categoryBitMask = ZOMBIE;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN;
}

@end
