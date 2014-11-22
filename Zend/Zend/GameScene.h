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
#import "Level.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    SKNode *world;
    CharacterFactory *cFactory;
    PlatformFactory *pFactory;
    PlayerControl *pl1Control, *pl2Control;
    Level *level;
}

@end
