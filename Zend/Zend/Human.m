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
        newHuman = [[Human alloc] initWithImageNamed:@"boyCharacter.png"];
    }
    else if (cType == FRIEND) {
        newHuman = [[Human alloc] initWithImageNamed:@"FriendTexture"];
    }
    else {
        newHuman = [[Human alloc] init];
    }
    
    newHuman.type = cType;
    newHuman.speedX = 500;
    newHuman.speedY = 750;
    [newHuman initPhysicsBody];
    
    return newHuman;
}

- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask = HUMAN;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.contactTestBitMask = PLATFORM | ZOMBIE;
}
- (void) update
{
    [super update];
}

@end
