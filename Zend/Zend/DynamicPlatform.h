//
//  DynamicPlatform.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Platform.h"

@interface DynamicPlatform : Platform
{
    CGPoint beginPoint, endPoint;
    CGFloat speed;
    CGFloat speedX, speedY;
    bool isMovingForward, isInCheckpoint;
}

@property CGPoint beginPoint, endPoint;
@property CGFloat speed;
@property bool isMovingForward, isInCheckpoint;

+ (instancetype)platformWithImageNamed:(NSString *)imageName;
- (void)update;

@end
