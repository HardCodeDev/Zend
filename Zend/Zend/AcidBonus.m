//
//  AcidBonus.m
//  Zend
//
//  Created by Nikita Makarov on 07/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "AcidBonus.h"

@implementation AcidBonus

- (id)initAtPosition:(CGPoint)position {
    self = [super initWithImageNamed:@"AcidBonus"];
    if (self) {
        self.position = position;
        self.zPosition = 60;
        [self initPhysicsBody];
    }
    return self;
}

- (void)applyTo:(Character *)player {
    
    player.health = 5;
    player.runSpeed *= 2;
    player.jumpSpeed *= 2;
    [player runAction:[SKAction playSoundFileNamed:@"AcidBoost.mp3" waitForCompletion:NO]];
    [player runAction:[SKAction waitForDuration:13.0f] completion:^{
        player.runSpeed /= 2;
        player.jumpSpeed /= 2;
    }];
    [self removeFromParent];
}

@end
