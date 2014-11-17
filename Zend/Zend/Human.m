//
//  Human.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Human.h"

@implementation Human

- (Character *)cloneWithType:(NSString *)characterType {
    Character *newHuman;
    
    if ([characterType isEqualToString:@"Player"]) {
        newHuman = [[Human alloc] initWithImageNamed:@"PlayerTexture"];
    }
    else if ([characterType isEqualToString:@"Friend"]) {
        newHuman = [[Human alloc] initWithImageNamed:@"FriendTexture"];
    }
    else {
        newHuman = [[Human alloc] init];
    }
    
    [newHuman assignType:characterType];
    
    return newHuman;
}

@end
