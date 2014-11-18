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

- (void)setPosition:(CGPoint)position
{
    self.character.position = position;
}

@end
