//
//  Character.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Character.h"

@implementation Character

- (Character *)cloneWithType:(NSString *)characterType {
    return nil;
}

- (void)assignType:(NSString *)characterType {
    if ([characterType isEqualToString:@"Player"]) {
        type = PLAYER;
    }
    else if ([characterType isEqualToString:@"Friend"]) {
        type = FRIEND;
    }
    else if ([characterType isEqualToString:@"Zombie"]) {
        type = ZOMBIE;
    }
}

@end
