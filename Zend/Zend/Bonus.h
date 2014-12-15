//
//  Bonus.h
//  Zend
//
//  Created by Nikita Makarov on 07/12/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Character.h"
#import "Enums.h"

@interface Bonus : SKSpriteNode

@property NSInteger type;
@property CGFloat   duration;

- (id)initAtPosition:(CGPoint)position;
- (void)applyTo:(SKSpriteNode *)player;
- (void)initPhysicsBody;

@end
