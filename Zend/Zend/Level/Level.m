//
//  Level.m
//  Zend
//
//  Created by Nikita Makarov on 20/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Level.h"

@implementation Level

@synthesize platforms, zombies, stages;
@synthesize currentZombie;
@synthesize currentStage;
@synthesize stagesExist;

- (id)initWithLevel:(NSInteger)selectedLevel {
    
    self = [super init];
    if (self) {
        level = selectedLevel;
        
        NSBundle *bundle = [NSBundle mainBundle];
        pathToLevels = bundle.resourcePath;
        pathToLevels = [pathToLevels stringByAppendingString:@"/Levels/Level"];
        pathToLevels = [pathToLevels stringByAppendingString:[@(level) stringValue]];
        
        platforms = [NSMutableArray array];
        zombies   = [NSMutableArray array];
        stages    = [NSMutableArray array];
        
        pFactory = [[PlatformFactory alloc] init];
        cFactory = [[CharacterFactory alloc] init];
        
        currentZombie = 0;
        currentStage  = 0;
        stagesExist   = YES;
    }
    return self;
}

- (void)loadPlatforms {
    
    NSError  *error;
    NSString *path = [pathToLevels stringByAppendingString:@"/platforms.json"];
    NSURL    *url = [NSURL fileURLWithPath:path];
    NSData   *jsonPlatformsData = [NSData dataWithContentsOfURL:url];
    NSDictionary *jsonPlatformsDict = [NSJSONSerialization JSONObjectWithData:jsonPlatformsData
                                                                     options:0
                                                                       error:&error];
    if (jsonPlatformsDict) {
        NSString *type, *texture; // add action
        CGFloat positionX, positionY, endPositionX, endPositionY;
        CGFloat angle, speed;
        for (id platformsDict in [jsonPlatformsDict objectForKey:@"platforms"]) {
            type      = [platformsDict objectForKey:@"type"];
            texture   = [platformsDict objectForKey:@"texture"];
            angle     = [[platformsDict objectForKey:@"angle"] floatValue];
            positionX = [[platformsDict objectForKey:@"positionX"] floatValue];
            positionY = [[platformsDict objectForKey:@"positionY"] floatValue];
            
            Platform *newPlatform;
            if ([type isEqualToString:@"dynamic"]) {
                // add action
                endPositionX = [[platformsDict objectForKey:@"endPositionX"] floatValue];
                endPositionY = [[platformsDict objectForKey:@"endPositionY"] floatValue];
                speed        = [[platformsDict objectForKey:@"speed"] floatValue];
                
                newPlatform = [pFactory createDynamicPlatformWithImageNamed:texture
                                                              beginPosition:CGPointMake(positionX, positionY)
                                                                endPosition:CGPointMake(endPositionX, endPositionY)
                                                                      speed:speed
                                                                  zRotation:angle];
            }
            else {
                newPlatform = [pFactory createPlatformWithImageNamed:texture
                                                          atPosition:CGPointMake(positionX, positionY)
                                                           zRotation:angle];
            }
            [platforms addObject:newPlatform];
        }
    }
    else {
        NSLog(@"Error from reading platforms data.");
    }
    
}

- (void)loadZombies {
    
    NSError  *error;
    NSString *path = [pathToLevels stringByAppendingString:@"/zombies.json"];
    NSURL    *url = [NSURL fileURLWithPath:path];
    NSData   *jsonZombiesData = [NSData dataWithContentsOfURL:url];
    NSDictionary *jsonZiombiesDict = [NSJSONSerialization JSONObjectWithData:jsonZombiesData
                                                                      options:0
                                                                        error:&error];
    if (jsonZiombiesDict) {
        NSString *type;
        CGFloat positionX, positionY;
        for (id zombiesDict in [jsonZiombiesDict objectForKey:@"zombies"]) {
            type      = [zombiesDict objectForKey:@"type"];
            positionX = [[zombiesDict objectForKey:@"positionX"] floatValue];
            positionY = [[zombiesDict objectForKey:@"positionY"] floatValue];
            Character *newZombie;
            if ([type isEqualToString:@"skinny"]) {
                newZombie = [cFactory createCharacter:SZOMBIE atPosition:CGPointMake(positionX, positionY)];
            }
            else if ([type isEqualToString:@"fat"]) {
                newZombie = [cFactory createCharacter:FZOMBIE atPosition:CGPointMake(positionX, positionY)];
            }
            [zombies addObject:newZombie];
        }
    }
    else {
        NSLog(@"Error from reading zombies data.");
    }
    
}

- (void)loadStages {
    
    NSError  *error;
    NSString *path = [pathToLevels stringByAppendingString:@"/stages.json"];
    NSURL    *url = [NSURL fileURLWithPath:path];
    NSData   *jsonStagesData = [NSData dataWithContentsOfURL:url];
    NSDictionary *jsonStagesDict = [NSJSONSerialization JSONObjectWithData:jsonStagesData
                                                                     options:0
                                                                       error:&error];
    if (jsonStagesDict) {
        CGFloat position;
        NSInteger amount;
        for (id stagesDict in [jsonStagesDict objectForKey:@"stages"]) {
            position = [[stagesDict objectForKey:@"position"] floatValue];
            amount = [[stagesDict objectForKey:@"amount"] floatValue];
            Stage *newStage = [[Stage alloc] initAtPosition:position withAmount:amount];
            [stages addObject:newStage];
        }
    }
    else {
        NSLog(@"Error from reading stages data.");
    }
    
}

- (void)buildOn:(SKNode *)node {
    
    [self loadPlatforms];
    [self loadZombies];
    [self loadStages];
    
    [self createPlatformsOn:node];
    
}

- (void)createPlatformsOn:(SKNode *)node {
    
    for (id platform in platforms) {
        [node addChild:platform];
    }
    
}

- (void)createNextPackOfZombiesOn:(SKNode *)node {
    
    Stage *stage = [stages objectAtIndex:currentStage];
    
    for (NSInteger zombieNum = currentZombie; zombieNum < currentZombie + stage.amountOfZombies; zombieNum++) {
        [node addChild:[zombies objectAtIndex:zombieNum]];
    }
    currentZombie += stage.amountOfZombies;
    currentStage++;
    if (currentStage >= stages.count) {
        stagesExist = NO;
    }
    
}

@end
