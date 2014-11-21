//
//  DynamicPlatform.m
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "DynamicPlatform.h"

@implementation DynamicPlatform

@synthesize beginPoint, endPoint;
@synthesize speed;
@synthesize isMovingForward, isInCheckpoint;

+ (instancetype)platformWithImageNamed:(NSString *)imageName {
    DynamicPlatform *platform = [[DynamicPlatform alloc] initWithImageNamed:imageName];
    platform.isMovingForward = YES;
    platform.isInCheckpoint = YES;
    platform.name = @"DynamicPlatform";
    return platform;
}
- (void)initPhysicsBody {
    [super initPhysicsBody];
    self.physicsBody.categoryBitMask = DYNAMIC_PLATFORM;
}

- (void)update {
    
    if (((self.beginPoint.x <= self.endPoint.x && self.position.x >= endPoint.x)
      || (self.beginPoint.x >= self.endPoint.x && self.position.x <= endPoint.x))
     && ((self.beginPoint.y <= self.endPoint.y && self.position.y >= endPoint.y)
      || (self.beginPoint.y >= self.endPoint.y && self.position.y <= endPoint.y)))
    {
        self.isMovingForward = NO;
    }
    
    else if (((self.beginPoint.x <= self.endPoint.x && self.position.x <= beginPoint.x)
           || (self.beginPoint.x >= self.endPoint.x && self.position.x >= beginPoint.x))
          && ((self.beginPoint.y <= self.endPoint.y && self.position.y <= beginPoint.y)
           || (self.beginPoint.y >= self.endPoint.y && self.position.y >= beginPoint.y)))
    {
         self.isMovingForward = YES;
    }
    
    if(self.isMovingForward)
    {
        self.physicsBody.velocity = CGVectorMake((self.endPoint.x - self.beginPoint.x) * self.speed,
                                                 (self.endPoint.y - self.beginPoint.y) * self.speed);
    }
    
    else
    {
        self.physicsBody.velocity = CGVectorMake((self.beginPoint.x - self.endPoint.x) * self.speed,
                                                 (self.beginPoint.y - self.endPoint.y) * self.speed);
    }
    NSArray *children = [self children];
    SKNode *ground = [children objectAtIndex:0];
    ground.physicsBody.velocity = self.physicsBody.velocity;
}

@end
