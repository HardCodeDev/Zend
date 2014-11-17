//
//  PlatformFactory.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "PlatformFactory.h"

@implementation PlatformFactory

- (Platform*) createPlatformWithImageNamed:(NSString *)imageName atPosition:(CGPoint)point
{
    Platform *platform = [Platform platformWithImageNamed:imageName];
    platform.scale = 0.5;
    platform.position = point;
    platform.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform.frame.size];
    platform.physicsBody.dynamic = NO;
    return platform;
}

@end
