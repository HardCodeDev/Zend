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
    DEATH_LINE = 8,
    HUMAN    = 16,
    ZOMBIE   = 32,
    CHARACTER = HUMAN | ZOMBIE,
    BULLET   = 64,
    CORPSE   = 128
} BitMask;

typedef enum {
    PISTOL,
    MELEE
} WeaponType;

#endif