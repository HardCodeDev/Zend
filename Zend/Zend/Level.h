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


@interface Level : NSObject {
    NSInteger level;
    NSString *pathToLevels;
    NSMutableArray *platforms; // платформы для текущего уровня
    NSMutableArray *zombies;   // зомби
    NSMutableArray *stages;    // флаги уровня, на которых будут появляться новые зомби
    PlatformFactory *pFactory;
    CharacterFactory *cFactory;
}

- (id)initWithLevel:(NSInteger)lvl;
- (void)loadPlatforms;
- (void)loadZombies;
- (void)loadStages;
- (void)createPlatformsOn:(SKNode *)node;
- (void)createZombiesOn:(SKNode *)node;
- (void)createStagesOn:(SKNode *)node;
- (void)buildOn:(SKNode *)node;

@end