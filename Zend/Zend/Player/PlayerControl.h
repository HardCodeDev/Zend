//
//  PlayerControl.h
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

typedef enum {
    up, left, down, right, fire
} KeySet;

@interface PlayerControl : NSObject {
    
    BOOL leftKeyPressed, rightKeyPressed, readyToJump;
    NSUInteger keySet;
    int keys[10];
    
}

@property Character *playerChar;

- (id)init;
- (void)setPosition:(CGPoint)position;
- (void)setDirection:(NSInteger)direction;
- (void)keyUp:(NSString * const)characters;
- (void)keyDown:(NSString * const)characters;
- (void)setKeySet:(NSUInteger)keyS;

@end
