//
//  Level.h
//  Zend
//
//  Created by Nikita Makarov on 20/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlatformFactory.h"
#import "CharacterFactory.h"
#import "Stage.h"
#import "DeathLine.h"

@interface Level : NSObject {
    NSInteger level;
    NSString  *pathToLevels;
    
    NSMutableArray *platforms;
    NSMutableArray *zombies;
    NSMutableArray *stages;
    
    PlatformFactory  *pFactory;
    CharacterFactory *cFactory;
}

@property NSInteger currentZombie;
@property NSInteger currentStage;

@property NSMutableArray *platforms;
@property NSMutableArray *zombies;
@property NSMutableArray *stages;

@property BOOL stagesExist;

- (id)initWithLevel:(NSInteger)selectedLevel;

- (void)loadPlatforms;
- (void)loadZombies;
- (void)loadStages;

- (void)buildOn:(SKNode *)node;
- (void)createPlatformsOn:(SKNode *)node;
- (void)createNextPackOfZombiesOn:(SKNode *)node;

@end
