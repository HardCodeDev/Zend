//
//  Weapon.h
//  Zend
//
//  Created by Anton Yakimenko on 26.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WeaponUnit.h"
#import "RangeWeapon.h"
#import "MeleeWeapon.h"
#import "Enums.h"

@interface Weapon : SKNode {
    
    NSUInteger count;
    WeaponUnit *secondGun;
    SKNode *world;
    
}

@property WeaponUnit *firstGun;

- (id)init;
- (CGFloat)fire;
- (void)setFirstSlotWeaponType:(WeaponType)wType;

@end
