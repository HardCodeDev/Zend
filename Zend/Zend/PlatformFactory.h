//
//  PlatformFactory.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//
#import "Platform.h"
#import "DynamicPlatform.h"

@interface PlatformFactory : NSObject

- (Platform *) createPlatformWithImageNamed:(NSString *)imageName atPosition:(CGPoint)point;
- (Platform *) createDynamicPlatformWithImageNamed:(NSString *)imageName
                                     beginPosition:(CGPoint)beginPoint
                                       endPosition:(CGPoint)endPoint
                                             speed:(CGFloat)speed;
@end
