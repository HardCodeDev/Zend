//
//  Character.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Platform.h"
#import "Weapon.h"
#import "Enums.h"

@interface Character : SKSpriteNode {
    CharacterType type;
    CGFloat runSpeed, jumpSpeed;
    CGFloat speedX, speedY;
    NSInteger direction;
    BOOL isRunning, isJumping, onGround;
    Platform *platform;
    NSUInteger groundContacts;
    Weapon *weapon;
    BOOL isAlive;
    CGFloat health;
}

@property CharacterType type;
@property CGFloat speedX, speedY;
@property CGFloat runSpeed, jumpSpeed;
@property Platform *platform;
@property BOOL onGround;
@property Weapon *weapon;
@property CGFloat health;
@property BOOL isAlive;

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position;
- (id)initWithImageNamed:(NSString *)imageName;
- (void)initPhysicsBody;
- (void)update;
- (void)run;
- (void)stop;
- (void)jump;
- (NSInteger)getDirection;
- (void)setDirection:(NSInteger)dir;
- (void)incGroundContacts;
- (void)decGroundContacts;
- (void)fire;
- (void)die;
- (void)applyDamage:(CGFloat)damage;

@end
