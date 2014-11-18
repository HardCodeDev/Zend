//
//  PlayerControl.h
//  Zend
//
//  Created by Anton Yakimenko on 18.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface PlayerControl : NSObject
{
    Character *character;
    
}
@property Character * character;

- (void)setPosition:(CGPoint)position;

@end
