//
//  SkinnyZombie.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "SkinnyZombie.h"

@implementation SkinnyZombie

- (Character *)cloneWithType:(NSString *)characterType {
    Character *newSkinnyZombie = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombieTexture"];
    [newSkinnyZombie assignType:characterType];
    return newSkinnyZombie;
}

@end
