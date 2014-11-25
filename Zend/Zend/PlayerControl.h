//
//  PlayerControl.h
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

<<<<<<< HEAD
typedef enum {
    up, left, down, right
} KeySet;

@interface PlayerControl : NSObject {
    Character *playerChar;
    BOOL leftKeyPressed, rightKeyPressed, readyToJump;
    NSUInteger keySet;
    int keys[4];
}

@property Character *playerChar;
=======
@interface PlayerControl : NSObject {
    Character *character;
    BOOL leftKeyPressed, rightKeyPressed;
}

@property Character *character;
@property BOOL leftKeyPressed, rightKeyPressed;
>>>>>>> quiz

- (id)init;
- (void)setPosition:(CGPoint)position;
- (void)setDirection:(NSInteger)direction;
<<<<<<< HEAD
- (void)keyUp:(NSString * const)characters;
- (void)keyDown:(NSString * const)characters;
- (void)setKeySet:(NSUInteger)keyS;
=======
- (void)keyUp:(unichar const)code;
- (void)keyDown:(unichar const)code;
>>>>>>> quiz

@end
