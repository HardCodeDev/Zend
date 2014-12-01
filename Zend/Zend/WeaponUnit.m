//
//  WeaponUnit.m
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "WeaponUnit.h"

@implementation WeaponUnit

- (id)init {
    self = [super init];
    if (self) {
        isReady = YES;
        damage = 1;
    }
    return self;
}

- (CGFloat)fire {
    return 0;
}

@end
