//
//  SkinnyZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "SkinnyZombie.h"

@implementation SkinnyZombie

- (id)init {
    self = [super init];
    if (self) {
        self.walk  = [self getAnimationFromAtlas:@"Dude" timePerFrame:0.04f];
        self.fight = [self getAnimationFromAtlas:@"Dude"   timePerFrame:0.04f];
    }
    return self;
}

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    Zombie *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombie.png"];
    newSkinnyZombie.scale = 1;
    [newSkinnyZombie initPhysicsBody];
    newSkinnyZombie.type      = cType;
    newSkinnyZombie.jumpSpeed = 500;
    newSkinnyZombie.runSpeed  = 300;
    newSkinnyZombie.position  = position;
    newSkinnyZombie.health    = 2;
    newSkinnyZombie.zPosition = 10;
    [newSkinnyZombie.weapon setFirstSlotWeaponType:MELEE];
    //newSkinnyZombie.walk = walk;
    newSkinnyZombie.fight = fight;
    return newSkinnyZombie;
}

- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask    = ZOMBIE;
    self.physicsBody.collisionBitMask   = PLATFORM | DYNAMIC_PLATFORM;
    self.physicsBody.contactTestBitMask = GROUND | PLATFORM | DYNAMIC_PLATFORM | HUMAN | ZOMBIE;
    self.physicsBody.friction = 0;
    self.physicsBody.mass     = 1;
}

@end
