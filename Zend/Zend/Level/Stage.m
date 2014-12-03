//
//  Stage.m
//  Zend
//
//  Created by Nikita Makarov on 01/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Stage.h"

@implementation Stage

@synthesize position;
@synthesize amountOfZombies;

- (id)initAtPosition:(CGFloat)pos withAmount:(NSInteger)amount {
    self = [super init];
    if (self) {
        position = pos;
        amountOfZombies = amount;
    }
    return self;
}

@end
