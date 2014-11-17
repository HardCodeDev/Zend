//
//  Platform.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Platform : SKSpriteNode

+ (instancetype)platformWithImageNamed:(NSString *)imageName;
- (void)update;
- (void)initPhysicsBody;
@end
