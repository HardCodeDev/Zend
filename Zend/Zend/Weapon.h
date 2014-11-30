//
//  Weapon.h
//  Zend
//
//  Created by Anton Yakimenko on 26.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WeaponUnit.h"
#import "Enums.h"

@interface Weapon : SKNode {
    NSUInteger count;
    WeaponUnit *firstGun;
    WeaponUnit *secondGun;
    SKNode *world;
}


- (id)init;
- (void)fire;
- (void)setFirstSlotWeaponType:(WeaponType)wType;

@end
