//
//  HCAppDelegate.m
//  ZendTesting
//
//  Created by Nikita Makarov on 09/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "HCAppDelegate.h"
#import "HCMyScene.h"

@implementation HCAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [HCMyScene sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
