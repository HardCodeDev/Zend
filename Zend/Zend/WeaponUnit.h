//
//  WeaponUnit.h
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bullet.h"

@interface WeaponUnit : SKNode {
    NSInteger damage;
}

- (id)init;
- (void)fire;

@end
