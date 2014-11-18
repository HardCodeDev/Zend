//
//  SkinnyZombie.h
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Character.h"

@interface SkinnyZombie : Character

- (Character *)cloneWithType:(CharacterType)cType;
- (void)initPhysicsBody;

@end
