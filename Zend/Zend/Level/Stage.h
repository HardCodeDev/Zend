//
//  Stage.h
//  Zend
//
//  Created by Nikita Makarov on 01/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enums.h"

@interface Stage : NSObject;

@property CGFloat   position;
@property NSInteger amountOfZombies;

- (id)initAtPosition:(CGFloat)position withAmount:(NSInteger)amount;

@end
