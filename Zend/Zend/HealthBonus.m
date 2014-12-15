//
//  HealthBonus.m
//  Zend
//
//  Created by Nikita Makarov on 07/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "HealthBonus.h"

@implementation HealthBonus

- (id)initAtPosition:(CGPoint)position {
    
    self = [super initWithImageNamed:@"HealthBonus"];
    if (self) {
        self.position = position;
        self.zPosition = 60;
        [self initPhysicsBody];
    }
    return self;
    
}

- (void)applyTo:(Character *)player {
    player.health = 5;
    [self removeFromParent];
}

@end
