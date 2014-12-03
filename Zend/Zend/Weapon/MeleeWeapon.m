//
//  MeleeWeapon.m
//  Zend
//
//  Created by Anton Yakimenko on 30.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "MeleeWeapon.h"

@implementation MeleeWeapon

@synthesize shotInterval;
@synthesize damage;
@synthesize isReady;

- (id)init {
    
    self = [super init];
    if (self) {
        shotInterval = 1;
        damage = 1;
    }
    return self;
    
}

- (CGFloat)fire {
    
    if (!isReady) {
        return 0;
    }
    [self runAction: [SKAction sequence:@[
                                          [SKAction runBlock:^{isReady = NO;}],
                                          [SKAction waitForDuration:shotInterval],
                                          [SKAction runBlock:^{isReady = YES;}]
                                          ]]];
    return damage;
    
}

@end
