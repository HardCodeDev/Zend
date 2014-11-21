//
//  DynamicPlatform.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Platform.h"

@interface DynamicPlatform : Platform {
    CGPoint beginPoint, endPoint;
    CGFloat speed;
    CGFloat speedX, speedY;
    BOOL isMovingForward, isInCheckpoint;
}

@property CGPoint beginPoint, endPoint;
@property CGFloat speed;
@property BOOL isMovingForward, isInCheckpoint;

+ (instancetype)platformWithImageNamed:(NSString *)imageName;
- (void)initPhysicsBody;
- (void)update;

@end
