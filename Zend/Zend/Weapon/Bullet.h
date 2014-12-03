//
//  Bullet.h
//  Zend
//
//  Created by Anton Yakimenko on 28.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enums.h"

@interface Bullet : SKSpriteNode {
    
    CGFloat speed;
    
}

@property CGFloat damage;

- (id)initWithImageNamed:(NSString *)imageName;

@end
