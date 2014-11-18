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
    newSkinnyZombie.type = cType;
    [newSkinnyZombie initPhysicsBody];
    return newSkinnyZombie;
}

- (void)initPhysicsBody{
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask = ZOMBIE;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN;
}

@end
