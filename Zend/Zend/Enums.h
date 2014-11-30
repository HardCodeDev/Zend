//
//  Enums.h
//  Zend
//
//  Created by Anton Yakimenko on 21.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#ifndef Zend_Enums_h
#define Zend_Enums_h

typedef enum {
    PLAYER,
    FRIEND,
    SZOMBIE,
    FZOMBIE
} CharacterType;

typedef enum {
    PLATFORM = 1,
    DYNAMIC_PLATFORM = 2,
    GROUND   = 4,
    HUMAN    = 8,
    ZOMBIE   = 16,
    CHARACTER = HUMAN | ZOMBIE,
    BULLET   = 32,
    CORPSE   = 64
} BitMask;

typedef enum {
    PISTOL,
    MELEE
} WeaponType;

#endif