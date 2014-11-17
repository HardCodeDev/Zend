//
//  GameScene.h
//  Zend
//

//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlatformFactory.h"

@interface GameScene : SKScene {

    SKNode *world;
    PlatformFactory *pFactory;

}

@end
