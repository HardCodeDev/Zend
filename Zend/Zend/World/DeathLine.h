//
//  DeathLine.h
//  Zend
//
//  Created by Anton Yakimenko on 01.12.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enums.h"

@interface DeathLine : SKNode

+ (instancetype)lineWithFirstPoint:(CGPoint)firstPoint secondPoint:(CGPoint)secondPoint;

@end
