//
//  SkinnyZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "SkinnyZombie.h"

@implementation SkinnyZombie

@synthesize isAwakening;

- (id)init {
    self = [super init];
    if (self) {
        self.beginWalk = [self getAnimationFromAtlas:@"WorkerBeginWalk" timePerFrame:0.04f];
        self.walk      = [self getAnimationFromAtlas:@"WorkerWalk" timePerFrame:0.04f];
        self.handsUp   = [self getAnimationFromAtlas:@"WorkerHandsUP" timePerFrame:0.04f];
        //self.fight = nil;
    }
    return self;
}

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    SkinnyZombie *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"Worker.png"];
    //newSkinnyZombie.scale = 0.2;
    [newSkinnyZombie initPhysicsBody];
    newSkinnyZombie.type      = cType;
    newSkinnyZombie.jumpSpeed = 500;
    newSkinnyZombie.runSpeed  = 300;
    newSkinnyZombie.position  = position;
    newSkinnyZombie.health    = 2;
    newSkinnyZombie.zPosition = 10;
    [newSkinnyZombie.weapon setFirstSlotWeaponType:MELEE];
    newSkinnyZombie.handsUp = handsUp;
    newSkinnyZombie.beginWalk = beginWalk;
    newSkinnyZombie.walk = walk;
    newSkinnyZombie.fight = fight;
    newSkinnyZombie.isReady = NO;
    newSkinnyZombie.isAwakening = NO;
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

- (void)update {
    [super update];
    if (!isReady && !isAwakening) {
        [self awakening];
    }
}

- (void)awakening {
    isAwakening = YES;
    if (handsUp) {
        [self runAction:[SKAction sequence:@[
                                            handsUp,
                                            [SKAction runBlock:^{[self ready];} ]
                                            ]]];
    }
}


- (void)startWalking {
    if (beginWalk && walk) {
    [self runAction:[SKAction sequence:@[
                                         beginWalk,
                                         [SKAction repeatActionForever:walk]
                                         ]] withKey:@"walking"];
    }
}

@end
