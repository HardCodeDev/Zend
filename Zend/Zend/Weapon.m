//
//  Weapon.m
//  Zend
//
//  Created by Anton Yakimenko on 26.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

- (id)init {
    self = [super init];
    if (self) {
        firstGun = nil;
        secondGun = nil;
        count = 0;
    }
    return self;
}

- (void)fire {
    if (firstGun) {
        [firstGun fire];
    }
    if(secondGun) {
        [secondGun fire];
    }
}

- (void)setFirstSlotWeaponType:(WeaponType)wType {
    firstGun = [[WeaponUnit alloc] init];
    [self addChild:firstGun];
}

@end
