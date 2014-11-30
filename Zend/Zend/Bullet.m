//
//  Bullet.m
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

@synthesize damage;

- (id)initWithImageNamed:(NSString *)imageName {
    self = [super initWithImageNamed:imageName];
    if (self) {
        self.name   = @"Bullet";
    }
    return self;
}

- (CGFloat)getDamage {
    return damage;
}

@end
