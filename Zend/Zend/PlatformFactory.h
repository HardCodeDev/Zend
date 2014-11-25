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

- (Platform *)createPlatformWithImageNamed:(NSString *)imageName
<<<<<<< HEAD
                                 atPosition:(CGPoint)point
                                  zRotation:(CGFloat)angle;

- (Platform *)createDynamicPlatformWithImageNamed:(NSString *)imageName
                                     beginPosition:(CGPoint)beginPoint
                                       endPosition:(CGPoint)endPoint
                                             speed:(CGFloat)speed
                                         zRotation:(CGFloat)angle;
=======
                                atPosition:(CGPoint)point
                                zRotation:(CGFloat)angle;

- (Platform *)createDynamicPlatformWithImageNamed:(NSString *)imageName
                                    beginPosition:(CGPoint)beginPoint
                                      endPosition:(CGPoint)endPoint
                                            speed:(CGFloat)speed
                                        zRotation:(CGFloat)angle;

>>>>>>> quiz
@end
