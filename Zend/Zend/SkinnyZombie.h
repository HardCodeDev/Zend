//
//  SkinnyZombie.h
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Zombie.h"

@interface SkinnyZombie : Zombie

- (Character *)cloneWithType:(CharacterType)cType atPosition:(CGPoint)position;
- (void)initPhysicsBody;

@end
