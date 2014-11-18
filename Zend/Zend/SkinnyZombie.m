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
    Character *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombie.png"];
    newSkinnyZombie.type = cType;
    [newSkinnyZombie initPhysicsBody];
    return newSkinnyZombie;
}

- (void)initPhysicsBody{
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask = ZOMBIE;
    self.physicsBody.collisionBitMask = PLATFORM | HUMAN;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN;
    self.physicsBody.friction = 1;
    self.physicsBody.mass = 1;
}

@end
