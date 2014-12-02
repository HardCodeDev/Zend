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

@property NSMutableArray *platforms;
@property NSMutableArray *zombies;
@property NSMutableArray *stages;

- (id)initWithLevel:(NSInteger)selectedLevel;

- (void)loadPlatforms;
- (void)loadZombies;
- (void)loadStages;

- (void)createPlatformsOn:(SKNode *)node;
- (void)createZombiesOn:(SKNode *)node;
- (void)createStagesOn:(SKNode *)node;

- (void)buildOn:(SKNode *)node;
- (void)createNextPackOfZombiesOn:(SKNode *)node fromStage:(Stage *)stage;

@end
