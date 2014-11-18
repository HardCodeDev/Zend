//
//  GameScene.h
//  Zend
//

//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlatformFactory.h"
#import "CharacterFactory.h"
#import "PlayerControl.h"

@interface GameScene : SKScene {

    SKNode *world;
    CharacterFactory *cFactory;
    PlatformFactory *pFactory;
    PlayerControl *plControl;

}

@end
