//
//  PlatformFactory.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "PlatformFactory.h"

@implementation PlatformFactory

- (Platform *) createPlatformWithImageNamed:(NSString *)imageName atPosition:(CGPoint)point
{
    Platform *platform = [Platform platformWithImageNamed:imageName];
    platform.position = point;
    [platform initPhysicsBody];
    return platform;
}
- (Platform *) createDynamicPlatformWithImageNamed:(NSString *)imageName
                                    beginPosition:(CGPoint)beginPoint
                                      endPosition:(CGPoint)endPoint
                                             speed:(CGFloat)speed
{
    DynamicPlatform *platform = [DynamicPlatform platformWithImageNamed:imageName];
    platform.position = beginPoint;
    platform.beginPoint = beginPoint;
    platform.endPoint = endPoint;
    platform.speed = speed;
    [platform initPhysicsBody];
    return platform;
}

@end