//
//  Character.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Platform.h"

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
    NSUInteger health;
    CGFloat runSpeed, jumpSpeed;
    CGFloat speedX, speedY;
    NSInteger direction;
    BOOL isRunning, isJumping, onGround;
    Platform *platform;
}

@property CharacterType type;
@property CGFloat speedX, speedY;
@property CGFloat runSpeed, jumpSpeed;
@property Platform * platform;
@property BOOL onGround;

- (Character *)cloneWithType:(CharacterType)cType;
- (id)initWithImageNamed:(NSString *) imageName;
- (void)initPhysicsBody;
- (void)update;
- (void)run;
- (void)stop;
- (void)jump;
- (void)setDirection:(NSInteger) dir;

@end
