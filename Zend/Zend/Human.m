//
//  Human.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Human.h"

@implementation Human

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    Character *newHuman;
    
    if (cType == PLAYER) {
        newHuman = [[Human alloc] initWithImageNamed:@"BoyCharacter.png"];
    }
    else if (cType == FRIEND) {
        newHuman = [[Human alloc] initWithImageNamed:@"GreenPlayer.png"];
    }
    else {
        newHuman = [[Human alloc] init];
    }
    
    [newHuman initPhysicsBody];
    newHuman.type      = cType;
    newHuman.runSpeed  = 350;
    newHuman.jumpSpeed = 750;
    newHuman.position  = position;
    newHuman.zPosition = 100;
    
    [newHuman.weapon setFirstSlotWeaponType:PISTOL];
    
    return newHuman;
}

- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask    = HUMAN;
    self.physicsBody.collisionBitMask   = PLATFORM | DYNAMIC_PLATFORM;
    self.physicsBody.contactTestBitMask = GROUND | PLATFORM | DYNAMIC_PLATFORM | ZOMBIE;
}
- (void) update {
    [super update];
}

@end
