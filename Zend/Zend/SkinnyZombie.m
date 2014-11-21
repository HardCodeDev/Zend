//
//  SkinnyZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "SkinnyZombie.h"

@implementation SkinnyZombie

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    Character *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombie.png"];
    [newSkinnyZombie initPhysicsBody];
    newSkinnyZombie.type      = cType;
    newSkinnyZombie.jumpSpeed = 500;
    newSkinnyZombie.runSpeed  = 100;
    newSkinnyZombie.position  = position;
    [newSkinnyZombie run];
    return newSkinnyZombie;
}

- (void)initPhysicsBody{
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask    = ZOMBIE;
    self.physicsBody.collisionBitMask   = PLATFORM;
    self.physicsBody.contactTestBitMask = PLATFORM | HUMAN | ZOMBIE;
    self.physicsBody.friction = 0;
    self.physicsBody.mass     = 1;
}

@end
