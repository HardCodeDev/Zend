//
//  Stage.h
//  Zend
//
//  Created by Nikita Makarov on 01/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enums.h"

@interface Stage : SKSpriteNode

@property NSInteger amountOfZombies;

- (id)initAndCreateAtPosition:(CGFloat)position withZombiesAmount:(NSInteger)amount;

@end
