//
//  Human.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Human.h"

@implementation Human

- (Character *)cloneWithType:(CharacterType)cType {
    Character *newHuman;
    
    if (cType == PLAYER) {
        newHuman = [[Human alloc] initWithImageNamed:@"PlayerTexture"];
        newHuman.name = @"Player";
    }
    else if (cType == FRIEND) {
        newHuman = [[Human alloc] initWithImageNamed:@"FriendTexture"];
        newHuman.name = @"Friend";
    }
    else {
        newHuman = [[Human alloc] init];
    }
    
    type = cType;
    [newHuman initDefaultPhysicsProperties];
    [newHuman initPhysicsBody];
    
    return newHuman;
}

- (void)initPhysicsBody {
    self.physicsBody.categoryBitMask = HUMAN;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = PLATFORM | ZOMBIE;
}

@end
