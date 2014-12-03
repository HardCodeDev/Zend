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
@synthesize groundContacts;
@synthesize walk;
@synthesize isReady;

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    return nil;
}

- (void)initPhysicsBody {
    
    CGFloat height = self.frame.size.height;
    CGFloat width  = height / 3;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, -width / 2, height / 2);
    CGPathAddLineToPoint(path, NULL, width / 2, height / 2);
    CGPathAddLineToPoint(path, NULL, width / 2, -height / 2 + 5);
    CGPathAddLineToPoint(path, NULL, width / 2 - 10, -height / 2);
    CGPathAddLineToPoint(path, NULL, -width / 2 + 10, -height / 2);
    CGPathAddLineToPoint(path, NULL, -width / 2, -height / 2 + 5);
    
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
        walk = nil;
        isReady = YES;
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
            [self stopAttack];
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
    
    if (!isAlive || !isReady) {
        return;
    }
    if (!isRunning) {
        [self startWalking];
    }
    isRunning = YES;
    speedX = runSpeed * direction;
    
}

- (void)stop {
    
    if (!isAlive) {
        return;
    }
    if (isRunning) {
        [self stopWalking];
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
        groundContacts = 1;
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
    //self.physicsBody.affectedByGravity = NO;
    
}

- (void)decGroundContacts {
    
    --groundContacts;
    if(groundContacts <= 0) {
        onGround = NO;
        //self.physicsBody.affectedByGravity = YES;
    }
    
}

- (void)fire {
    
    if (!isAlive) {
        return;
    }
    CGFloat damage = [weapon fire];
    if (collidingWithTarget) {
        [target applyDamage:damage];
        if (!target.isAlive) {
            [self stopAttack];
        }
    }
    
}

- (void)die {
    
    health = 0;
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
    if (damage > 0) {
        SKAction *pulseRed = [SKAction sequence:@[
                                  [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.15],
                                  [SKAction waitForDuration:0.1],
                                  [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
        [self runAction: pulseRed];

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

- (void)stopAttack {
    
    target = nil;
    onAttack = NO;
    [self endCollidingWithTarget];
    [self stop];
    
}

- (void)setCollidingWithTarget:(BOOL)isColliding {
    return;
}

- (void)beginCollidingWithTarget {
    collidingWithTarget = YES;
    [self stop];
}

- (void)endCollidingWithTarget {
    collidingWithTarget = NO;
    if (target) {
        [self run];
    }
}

- (SKAction *)getAnimationFromAtlas:(NSString *)atlasName timePerFrame:(CGFloat)time {
    
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *animatedAtlas = [SKTextureAtlas atlasNamed:atlasName];
    NSArray *textureNames = [animatedAtlas textureNames];
    textureNames = [textureNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    for (NSString *name in textureNames) {
        SKTexture *temp = [animatedAtlas textureNamed:name];
        [walkFrames addObject:temp];
    }
    
    NSArray *walkingDude = [[NSArray alloc] initWithArray:walkFrames];
    
    SKAction *walkAnimation = [SKAction animateWithTextures:walkingDude
                                               timePerFrame:time
                                                     resize:NO
                                                    restore:NO];
    
    return walkAnimation;
}



- (void)startWalking {
    if (walk) {
        [self runAction:[SKAction repeatActionForever:walk] withKey:@"walking"];
    }
}

- (void)stopWalking {
    if (walk) {
        [self removeActionForKey:@"walking"];
    }
}

- (void)ready {
    isReady = YES;
    if (target) {
        [self run];
    }
}

@end
