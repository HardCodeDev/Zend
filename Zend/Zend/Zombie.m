//
//  Zombie.m
//  Zend
//
//  Created by Anton Yakimenko on 01.12.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Zombie.h"

@implementation Zombie

@synthesize fight, handsUp, beginWalk;

- (id)init {
    self = [super init];
    if (self) {
        fight = nil;
        handsUp = nil;
        beginWalk = nil;
        walk = nil;
    }
    return self;
}

/*- (void)setCollidingWithTarget:(BOOL)isColliding {
    [super setCollidingWithTarget:isColliding];
    if (isColliding) {
        //[self startFighting];
    }
    else if (!isColliding) {
        //[self stopFighting];
    }
    
}*/

- (void)startFighting {
    if (fight) {
        [self runAction:fight withKey:@"fighting"];
    }
}

- (void)stopFighting {
    if (fight) {
        [self removeActionForKey:@"fighting"];
    }
}

@end
