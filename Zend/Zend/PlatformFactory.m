//
//  PlatformFactory.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "PlatformFactory.h"

@implementation PlatformFactory

- (Platform *)createPlatformWithImageNamed:(NSString *)imageName
                                atPosition:(CGPoint)point
                                 zRotation:(CGFloat)angle
{
    Platform *platform = [Platform platformWithImageNamed:imageName];
    [platform initPhysicsBody];
    platform.position = point;
    platform.zRotation = angle * M_PI / 180;
    return platform;
}

- (Platform *)createDynamicPlatformWithImageNamed:(NSString *)imageName
                                    beginPosition:(CGPoint)beginPoint
                                      endPosition:(CGPoint)endPoint
                                             speed:(CGFloat)speed
                                         zRotation:(CGFloat)angle
{
    DynamicPlatform *platform = [DynamicPlatform platformWithImageNamed:imageName];
    [platform initPhysicsBody];
    platform.position = beginPoint;
    platform.beginPoint = beginPoint;
    platform.endPoint = endPoint;
    platform.speed = speed;
    platform.zRotation = angle * M_PI / 180;
    return platform;
}

@end
