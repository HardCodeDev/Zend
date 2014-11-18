//
//  Character.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Character.h"

@implementation Character

- (Character *)cloneWithType:(CharacterType)cType {
    return nil;
}

- (void)initDefaultPhysicsProperties {
    self.physicsBody.restitution = 0;
    self.physicsBody.friction = 1000;
    self.physicsBody.allowsRotation = NO;
}

- (void)initPhysicsBody {
    
}

@end
