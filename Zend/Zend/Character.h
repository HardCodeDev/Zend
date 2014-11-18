//
//  Character.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    PLAYER,
    FRIEND,
    SZOMBIE,
    FZOMBIE
} CharacterType;

typedef enum {
    PLATFORM = 1,
    HUMAN = 2,
    ZOMBIE = 4
} BitMask;

@interface Character : SKSpriteNode {
    CharacterType type;
    NSUInteger level;
    NSUInteger damage;
}

- (Character *)cloneWithType:(CharacterType)cType;
- (void)initDefaultPhysicsProperties;
- (void)initPhysicsBody;

@end
