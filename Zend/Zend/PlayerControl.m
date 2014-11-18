//
//  PlayerControl.m
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "PlayerControl.h"

@implementation PlayerControl

@synthesize character;
@synthesize leftKeyPressed, rightKeyPressed;

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        self.leftKeyPressed = 0;
        self.rightKeyPressed = 0;
    }
    return self;
}

- (void)setPosition:(CGPoint)position
{
    self.character.position = position;
}

- (void)setDirection:(NSInteger)direction
{
    character.direction = direction;
}

@end
