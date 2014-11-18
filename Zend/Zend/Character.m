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

- (Character *)cloneWithType:(CharacterType)cType {
    return nil;
}

- (void)initPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 10.0;
    self.physicsBody.allowsRotation = NO;
}

-(id)initWithImageNamed:(NSString *) imageName
{
    self = [super initWithImageNamed:imageName];
    if(self != nil)
    {
        self.name = @"Character";
    }
    return self;
}

- (void)update
{
    if(isRunning)
        self.physicsBody.velocity = CGVectorMake(self.speedX*direction, self.physicsBody.velocity.dy);
}

- (void)run
{
    isRunning = YES;
}

- (void)stop
{
    isRunning = NO;
}

- (void)jump
{
    //if(self.phy)
    self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, self.speedY);
}

- (void)setDirection:(NSInteger) dir
{
    direction = dir;
    if(dir>0)
    {
        if(self.xScale<0)
            self.xScale *= -1;
    }
    else if(dir<0)
    {
        if(self.xScale>0)
            self.xScale *= -1;
    }
}

@end
