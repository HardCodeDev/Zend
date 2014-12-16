//
//  Human.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Human.h"

@implementation Human

@synthesize grandmaWalk, malvinaWalk;
@synthesize grandmaTex, malvinaTex;

- (id)init {
    
    self = [super init];
    if (self) {
        self.grandmaWalk = [self getAnimationFromAtlas:@"GrandmaWalk" timePerFrame:0.04f];
        self.grandmaTex  = [SKTexture textureWithImageNamed:@"Grandma"];
        self.malvinaWalk = [self getAnimationFromAtlas:@"MalvinaWalk" timePerFrame:0.06f];
        self.malvinaTex  = [SKTexture textureWithImageNamed:@"Malvina"];
    }
    return self;
    
}

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    
    Character *newHuman;
    
    if (cType == PLAYER) {
        newHuman = [[Human alloc] initWithImageNamed:@"Grandma.png"];
        newHuman.walk = self.grandmaWalk;
        newHuman.standTexture = self.grandmaTex;
    }
    else if (cType == FRIEND) {
        newHuman = [[Human alloc] initWithImageNamed:@"Malvina.png"];
        newHuman.scale = 0.13;
        newHuman.walk = self.malvinaWalk;
        newHuman.standTexture = self.malvinaTex;
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

/*- (void)startWalking {
    if (walk) {
        [self runAction:walk withKey:@"walking"];
    }
}
*/
- (void)stopWalking {
    if (walk) {
        [self removeActionForKey:@"walking"];
        //self.texture = self.standTexture;
    }
}

/*- (void)run {
    if (!isAlive) {
        return;
    }
    if (!isRunning) {
        [self startWalking];
    }
    isRunning = YES;
    speedX = runSpeed * direction;
}*/

/*- (void)stop {
    if (!isAlive) {
        return;
    }
    if (isRunning) {
        [self stopWalking];
    }
    isRunning = NO;
    speedX = 0;
    self.physicsBody.velocity = CGVectorMake(0, self.physicsBody.velocity.dy);
}*/

@end
