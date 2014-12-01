//
//  Human.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Human.h"

@implementation Human

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    Character *newHuman;
    
    if (cType == PLAYER) {
        newHuman = [[Human alloc] initWithImageNamed:@"Dude"];
    }
    else if (cType == FRIEND) {
        newHuman = [[Human alloc] initWithImageNamed:@"GreenPlayer"];
    }
    else {
        newHuman = [[Human alloc] init];
    }
    
    [newHuman initPhysicsBody];
    newHuman.type      = cType;
    newHuman.runSpeed  = 350;
    newHuman.jumpSpeed = 750;
    newHuman.position  = position;
    newHuman.zPosition = 20;
    newHuman.health = 5;
    
    // init atlas
   
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *dudeAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Dude"];
    NSArray *textureNames = [dudeAnimatedAtlas textureNames];
    textureNames = [textureNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    for (NSString *name in textureNames) {
        SKTexture *temp = [dudeAnimatedAtlas textureNamed:name];
        [walkFrames addObject:temp];
    }
    
    NSArray *walkingDude = [[NSArray alloc] initWithArray:walkFrames];
    
    SKAction *walkAnimation = [SKAction animateWithTextures:walkingDude
                                               timePerFrame:0.05f
                                                     resize:NO
                                                    restore:YES];
    
    SKAction *walkAction = [SKAction repeatActionForever:walkAnimation];
    
    newHuman.walk = walkAction;
    
    return newHuman;
}


- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask    = HUMAN;
    self.physicsBody.collisionBitMask   = PLATFORM | DYNAMIC_PLATFORM;
    self.physicsBody.contactTestBitMask = GROUND | PLATFORM | DYNAMIC_PLATFORM | ZOMBIE;
}
- (void) update {
    [super update];
}

- (void)startWalking {
    [self runAction:walk withKey:@"walking"];
}

- (void)stopWalking {
    [self removeActionForKey:@"walking"];
}

- (void)run {
    if (!isAlive) {
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

@end
