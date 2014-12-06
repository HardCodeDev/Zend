//
//  Zombie.h
//  Zend
//
//  Created by Anton Yakimenko on 01.12.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Character.h"

@interface Zombie : Character {
    SKAction *fight, *handsUp, *beginWalk;
}

@property SKAction *fight, *handsUp, *beginWalk;

@end
