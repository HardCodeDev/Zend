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
    }
    return self;
}

- (void)update {
    if(platform != nil && self.position.y - self.frame.size.height / 2 + 1 >= platform.position.y + platform.frame.size.height / 2) {
        self.physicsBody.velocity = CGVectorMake(self.speedX+platform.physicsBody.velocity.dx,
                                                 platform.physicsBody.velocity.dy);
        onGround = YES;
    }
    else {
        self.physicsBody.velocity = CGVectorMake(self.speedX, self.physicsBody.velocity.dy);
        onGround = NO;
    }
    
}

- (void)run {
    isRunning = YES;
}

- (void)stop {
    isRunning = NO;
    speedX = 0;
    self.physicsBody.velocity = CGVectorMake(0, self.physicsBody.velocity.dy);
}

- (void)jump {
    if(onGround)
    {
        self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, self.jumpSpeed);
    }
}

- (void)setDirection:(NSInteger)dir {
    direction = dir;
    speedX = runSpeed * direction;
    if ((dir > 0 && self.xScale < 0) || (dir < 0 && self.xScale > 0)) {
            self.xScale *= -1;
    }
}

@end
