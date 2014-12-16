//
//  Shotgun.m
//  Zend
//
//  Created by Anton Yakimenko on 16.12.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Shotgun.h"

@implementation Shotgun

- (id)init {
    self = [super init];
    if (self) {
        shotInterval = 0.4;
        damage = 2;
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
    Bullet *bullet = [[Bullet alloc] initWithImageNamed:@"Bullet"];
    
    bullet.position = [node convertPoint:self.position fromNode:self];
    bullet.damage = damage;
    SKNode *owner = self.parent.parent;
    NSInteger dir;
    CGFloat xShift = 1;
    CGFloat yShift = -4;
    if (owner.xScale < 0) {
        dir = -1;
        bullet.position = CGPointMake(bullet.position.x - owner.frame.size.width / 2 - xShift,
                                      bullet.position.y + yShift);
    }
    else {
        dir = 1;
        bullet.position = CGPointMake(bullet.position.x + owner.frame.size.width / 2 + xShift,
                                      bullet.position.y + yShift);
    }
    bullet.physicsBody.velocity = CGVectorMake(1000 * dir, 0);
    [bullet runAction:[SKAction playSoundFileNamed:@"50Caliber.wav" waitForCompletion:NO]];
    [node addChild:bullet];
    [self runAction: [SKAction sequence:@[
                                          [SKAction runBlock:^{isReady = NO;}],
                                          [SKAction waitForDuration:shotInterval],
                                          [SKAction runBlock:^{isReady = YES;}]
                                          ]]];
    return 0;
}

@end
