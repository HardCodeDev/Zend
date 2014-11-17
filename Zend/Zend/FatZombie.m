//
//  FatZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "FatZombie.h"

@implementation FatZombie

- (Character *)cloneWithType:(NSString *)characterType {
    Character *newFatZombie = [[FatZombie alloc] initWithImageNamed:@"FatZombieTexture"];
    [newFatZombie assignType:characterType];
    return newFatZombie;
}

@end
