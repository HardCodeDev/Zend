//
//  Weapon.m
//  Zend
//
//  Created by Anton Yakimenko on 26.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

@synthesize firstGun;

- (id)init {
    
    self = [super init];
    if (self) {
        firstGun = nil;
        secondGun = nil;
        count = 0;
    }
    return self;
    
}

- (CGFloat)fire {
    
    CGFloat damage = 0;
    if (firstGun) {
        damage += [firstGun fire];
    }
    if(secondGun) {
        damage += [secondGun fire];
    }
    return damage;
    
}

- (void)setFirstSlotWeaponType:(WeaponType)wType {
    
    if (wType == PISTOL) {
        firstGun = [[RangeWeapon alloc] init];
    }
    else if (wType == MELEE) {
        firstGun = [[MeleeWeapon alloc] init];
    }
    [self addChild:firstGun];
    
}

@end
