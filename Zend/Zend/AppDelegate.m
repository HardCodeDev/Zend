//
//  AppDelegate.m
//  Zend
//
//  Created by Anton Yakimenko on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScene.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    CGSize screenSize = CGSizeMake(1440, 900);
    
    GameScene *scene = [[GameScene alloc] initWithSize:screenSize];
    
    [[NSApplication sharedApplication] setPresentationOptions:NSFullScreenWindowMask];
    
    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;
    scene.backgroundColor = [SKColor blackColor];
    [self.skView presentScene:scene];

    /* Sprite Kit applies additional optimizations to improve rendering performance */
    self.skView.ignoresSiblingOrder = YES;
    
    //self.skView.showsFPS = YES;
    //self.skView.showsNodeCount = YES;
    scene.physicsWorld.contactDelegate = (id<SKPhysicsContactDelegate>)scene;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
