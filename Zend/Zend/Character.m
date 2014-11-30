//
//  Character.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Character.h"

@implementation Character

@synthesize type;
@synthesize speedX, speedY;
@synthesize runSpeed, jumpSpeed;
@synthesize platform;
@synthesize onGround;
@synthesize weapon;
@synthesize health;
@synthesize isAlive;
@synthesize onAttack;
@synthesize target;
@synthesize collidingWithTarget;

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    return nil;
}

- (void)initPhysicsBody {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, -40, 80);
    CGPathAddLineToPoint(path, NULL, 40, 80);
    CGPathAddLineToPoint(path, NULL, 40, -75);
    CGPathAddLineToPoint(path, NULL, 30, -80);
    CGPathAddLineToPoint(path, NULL, -30, -80);
    CGPathAddLineToPoint(path, NULL, -40, -75);
    
    CGPathCloseSubpath(path);
    self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 0.0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.dynamic = YES;
}

-(id)initWithImageNamed:(NSString *)imageName {
    self = [super initWithImageNamed:imageName];
    if (self) {
        self.name   = @"Character";
        self.speedX = 0;
        self.speedY = 0;
        [self setDirection:0];
        onGround = YES;
        groundContacts = 0;
        isAlive = YES;
        onAttack = NO;
        weapon = [[Weapon alloc] init];
        [self addChild:weapon];
        health = 100;
        target = nil;
        collidingWithTarget = NO;
    }
    return self;
}

- (void)update {
    if (onAttack) {
        [self fire];
    }
    if(platform) {
        self.physicsBody.velocity = CGVectorMake(self.speedX+platform.physicsBody.velocity.dx,
                                                 platform.physicsBody.velocity.dy + self.speedY);
    }
    else {
        self.physicsBody.velocity = CGVectorMake(self.speedX, self.physicsBody.velocity.dy + self.speedY);
    }
    
    if (target) {
        if (!target.isAlive) {
            target = nil;
            [self stop];
            onAttack = NO;
        }
        else {
            CGFloat dir = target.position.x-self.position.x;
            if (dir > 0) {
                [self setDirection:1];
            }
            else {
                [self setDirection:-1];
            }
        }
    }
    
}

- (void)run {
    if (!isAlive) {
        return;
    }
    isRunning = YES;
    speedX = runSpeed * direction;
}

- (void)stop {
    if (!isAlive) {
        return;
    }
    isRunning = NO;
    speedX = 0;
    self.physicsBody.velocity = CGVectorMake(0, self.physicsBody.velocity.dy);
}

- (void)jump {
    if (!isAlive) {
        return;
    }
    if(groundContacts > 0) {
        self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, self.jumpSpeed);
    }
}

- (NSInteger)getDirection {
    return direction;
}

- (void)setDirection:(NSInteger)dir {
    if (!isAlive) {
        return;
    }
    direction = dir;
    if(isRunning) {
        speedX = runSpeed * direction;
    }
    if ((dir > 0 && self.xScale < 0) || (dir < 0 && self.xScale > 0)) {
            self.xScale *= -1;
    }
}

- (void)incGroundContacts {
    ++groundContacts;
    onGround = YES;
    self.physicsBody.affectedByGravity = NO;
}

- (void)decGroundContacts {
    --groundContacts;
    if(groundContacts == 0) {
        onGround = NO;
        self.physicsBody.affectedByGravity = YES;
    }
}

- (void)fire {
    if (!isAlive) {
        return;
    }
    CGFloat damage = [weapon fire];
    if (collidingWithTarget) {
        [target applyDamage:damage];
    }
}

- (void)die {
    [self stop];
    isAlive = NO;
    self.physicsBody.categoryBitMask = CORPSE;
    CGFloat angle;
    if (self.xScale >= 0) {
        angle = M_PI_2;
    }
    else {
        angle = -M_PI_2;
    }
    SKAction *dying = [SKAction sequence:@[
                                           [SKAction rotateByAngle:angle duration:0.5],
                                           [SKAction waitForDuration:0.5],
                                           [SKAction runBlock:^{[self removeFromParent];}]
                                           ]];
    [self runAction:dying];
}

- (void)applyDamage:(CGFloat)damage {
    if (!isAlive) {
        return;
    }
    health -= damage;
    if (health <= 0) {
        health = 0;
        [self die];
    }
}

- (void)attackTarget:(Character *)character {
    target = character;
    onAttack = YES;
    [self run];
}

@end
