//
//  PlayerControl.h
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface PlayerControl : NSObject {
    Character *character;
    BOOL leftKeyPressed, rightKeyPressed, readyToJump;
}

@property Character * character;

- (id)init;
- (void)setPosition:(CGPoint)position;
- (void)setDirection:(NSInteger)direction;
- (void)keyUp:(unichar const)code;
- (void)keyDown:(unichar const)code;

@end
