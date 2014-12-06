//
//  DynamicPlatform.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Platform.h"

@interface DynamicPlatform : Platform {
    
    CGFloat speedX, speedY;
    
}

@property CGPoint beginPoint;
@property CGPoint endPoint;
@property CGFloat speed;

@property BOOL    isMovingForward;
@property BOOL    isInCheckpoint;

+ (instancetype)platformWithImageNamed:(NSString *)imageName;
- (void)initPhysicsBody;
- (void)update;

@end
