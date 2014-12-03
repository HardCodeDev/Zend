//
//  PlayerControl.m
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "PlayerControl.h"

@implementation PlayerControl

@synthesize playerChar;

- (id)init {
    
    self = [super init];
    if (self) {
        leftKeyPressed = 0;
        rightKeyPressed = 0;
        readyToJump = YES;
        keySet = 0;
    }
    return self;
    
}

- (void)setKeySet:(NSUInteger)keyS {
    
    keySet = keyS;
    if(keyS == 0) {
        keys[up]    = 'w';
        keys[left]  = 'a';
        keys[down]  = 's';
        keys[right] = 'd';
        keys[fire]  = 'x';
    }
    else if(keyS == 1) {
        keys[up]    = NSUpArrowFunctionKey;
        keys[left]  = NSLeftArrowFunctionKey;
        keys[down]  = NSDownArrowFunctionKey;
        keys[right] = NSRightArrowFunctionKey;
        keys[fire]  = '.';
    }
    
}

- (void)setPosition:(CGPoint)position {
    self.playerChar.position = position;
}

- (void)setDirection:(NSInteger)direction {
    playerChar.direction = direction;
}

- (void)keyUp:(NSString * const)characters {
    
    for (int s = 0; s < [characters length]; s++) {
        unichar character = [characters characterAtIndex:s];
        if (character == keys[up]) {
            readyToJump = YES;
        }
        else if (character == keys[left]) {
            leftKeyPressed = 0;
            if (rightKeyPressed) {
                [self setDirection: 1];
                [playerChar run];
            }
            else {
                [self setDirection: 0];
                [playerChar stop];
            }
        }
        else if (character == keys[right]) {
            rightKeyPressed = 0;
            if (leftKeyPressed) {
                [self setDirection: -1];
                [playerChar run];
            }
            else {
                [self setDirection: 0];
                [playerChar stop];
            }
        }
        else if (character == keys[fire]) {
            [playerChar setOnAttack:NO];
        }
    }
    
}
            
- (void)keyDown:(NSString * const)characters {
    
    for (int s = 0; s < [characters length]; s++) {
        unichar character = [characters characterAtIndex:s];
        if (character == keys[left]) {
            leftKeyPressed = 1;
            [self setDirection: -1];
            [playerChar run];
        }
        else if (character == keys[right]) {
            rightKeyPressed = 1;
            [self setDirection:1];
            [playerChar run];
        }
        else if (character == keys[up]) {
            if(readyToJump) {
                [playerChar jump];
            }
            readyToJump = NO;
        }
        else if (character == keys[fire]) {
            [playerChar setOnAttack:YES];
        }
    }
    
}

@end
