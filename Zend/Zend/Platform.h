//
//  Platform.h
//  Zend
//
//  Created by Anton Yakimenko on 17.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Enums.h"
#import "GroundLine.h"

@interface Platform : SKSpriteNode {
    GroundLine *ground;
}
+ (instancetype)platformWithImageNamed:(NSString *)imageName;
- (void)update;
- (void)initPhysicsBody;
<<<<<<< HEAD
- (void)initGroundLine;
=======

>>>>>>> quiz
@end
