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
    
    SKAction *walk;
    
    Character *target;
    Weapon    *weapon;
    Platform  *platform;
    
    CGFloat health;
    CGFloat speedX, speedY;
    CGFloat runSpeed, jumpSpeed;
    
    NSInteger direction;
    NSInteger groundContacts;
    
    BOOL isRunning, isJumping, onGround;
    BOOL isAlive;
    BOOL onAttack;
    BOOL collidingWithTarget;
    
    BOOL isReady;
    
}

@property CharacterType type;

@property Character *target;
@property Weapon    *weapon;
@property Platform  *platform;

@property CGFloat health;
@property CGFloat speedX, speedY;
@property CGFloat runSpeed, jumpSpeed;

@property BOOL onGround;
@property BOOL isAlive;
@property BOOL onAttack;
@property NSInteger groundContacts;

@property SKAction *walk;

@property BOOL isReady;

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position;
- (SKAction *)getAnimationFromAtlas:(NSString *)atlasName timePerFrame:(CGFloat)time;
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
- (void)attackTarget:(Character *)character;

- (void)setCollidingWithTarget:(BOOL)isColliding;
- (void)beginCollidingWithTarget;
- (void)endCollidingWithTarget;

- (void)stopAttack;

- (void)startWalking;
- (void)stopWalking;
- (void)ready;

@end
