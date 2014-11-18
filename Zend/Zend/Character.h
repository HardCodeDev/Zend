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
    CGFloat speedX, speedY;
    NSInteger direction;
    BOOL isRunning, isJumping;
}

@property CharacterType type;
@property CGFloat speedX, speedY;

- (Character *)cloneWithType:(CharacterType)cType;
- (id)initWithImageNamed:(NSString *) imageName;
- (void)initPhysicsBody;
- (void)update;
- (void)run;
- (void)stop;
- (void)jump;
- (void)setDirection:(NSInteger) dir;

@end
