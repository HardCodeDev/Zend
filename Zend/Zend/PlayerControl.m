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

- (id)init {
    self = [super init];
    if (self) {
        leftKeyPressed = 0;
        rightKeyPressed = 0;
        readyToJump = YES;
    }
    return self;
}

- (void)setPosition:(CGPoint)position {
    self.character.position = position;
}

- (void)setDirection:(NSInteger)direction {
    character.direction = direction;
}

- (void)keyUp:(unichar const)code {
    
    switch (code)
    {
        case NSUpArrowFunctionKey:
        {
            readyToJump = YES;
            break;
        }
        case NSLeftArrowFunctionKey:
        {
            leftKeyPressed = 0;
            if (rightKeyPressed) {
                [self setDirection: 1];
                [character run];
            }
            else {
                [self setDirection: 0];
                [character stop];
            }
            break;
        }
        case NSRightArrowFunctionKey:
        {
            rightKeyPressed = 0;
            if (leftKeyPressed) {
                [self setDirection: -1];
                [character run];
            }
            else {
                [self setDirection: 0];
                [character stop];
            }
            break;
        }
    }
}
- (void)keyDown:(unichar const)code {
    switch (code)
    {
        case NSLeftArrowFunctionKey:
        {
            leftKeyPressed = 1;
            [self setDirection: -1];
            [character run];
            break;
        }
        case NSRightArrowFunctionKey:
        {
            rightKeyPressed = 1;
            [self setDirection:1];
            [character run];
            break;
        }
        case NSUpArrowFunctionKey:
        {
            if(readyToJump)
                [character jump];
            readyToJump = NO;
            break;
        }
    }
}

@end
