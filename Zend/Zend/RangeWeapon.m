//
//  RangeWeapon.m
//  Zend
//
//  Created by Anton Yakimenko on 30.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "RangeWeapon.h"

@implementation RangeWeapon

- (id)init {
    self = [super init];
    if (self) {
        shotInterval = 0.4;
        damage = 1;
    }
    return self;
}

- (CGFloat)fire {
    if (!isReady) {
        return 0;
    }
    SKNode *node = self.parent;
    for (int i = 0; node && i < 2; ++i) {
        node = node.parent;
    }
    if (!node) {
        return 0;
    }
    Bullet *bullet = [[Bullet alloc] initWithImageNamed:@"Cat"];
    
    bullet.position = [node convertPoint:self.position fromNode:self];
    bullet.damage = damage;
    NSInteger dir;
    if (self.parent.parent.xScale < 0) {
        dir = -1;
    }
    else {
        dir = 1;
    }
    bullet.physicsBody.velocity = CGVectorMake(1000*dir, 0);
    [node addChild:bullet];
    [self runAction: [SKAction sequence:@[
                                          [SKAction runBlock:^{isReady = NO;}],
                                          [SKAction waitForDuration:shotInterval],
                                          [SKAction runBlock:^{isReady = YES;}]
                                          ]]];
    return 0;
}

@end
