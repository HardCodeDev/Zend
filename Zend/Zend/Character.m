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

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position {
    return nil;
}

- (void)initPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
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
    }
    return self;
}

- (void)update {
    if(platform != nil) {
        self.physicsBody.velocity = CGVectorMake(self.speedX+platform.physicsBody.velocity.dx,
                                                 platform.physicsBody.velocity.dy + self.speedY);
    }
    else {
        self.physicsBody.velocity = CGVectorMake(self.speedX, self.physicsBody.velocity.dy + self.speedY);
    }
    
}

- (void)run {
    isRunning = YES;
    speedX = runSpeed * direction;
}

- (void)stop {
    isRunning = NO;
    speedX = 0;
    self.physicsBody.velocity = CGVectorMake(0, self.physicsBody.velocity.dy);
}

- (void)jump {
    if(groundContacts > 0) {
        self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, self.jumpSpeed);
    }
}

- (NSInteger)getDirection {
    return direction;
}

- (void)setDirection:(NSInteger)dir {
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
}

- (void)decGroundContacts {
    --groundContacts;
    if(groundContacts == 0) {
        onGround = NO;
    }
}

@end
