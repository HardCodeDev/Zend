//
//  Level.m
//  Zend
//
//  Created by Nikita Makarov on 20/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "Level.h"

@implementation Level

- (id)initWithLevel:(NSInteger)lvl {
    self = [super init];
    if (self) {
        level = lvl;
<<<<<<< HEAD
        //pathToLevels = @"/Users/air/Documents/Object Oriented Programming/ZendGame/quiz/Zend/Zend/Levels/Level";
        pathToLevels = @"Levels/Level";
=======
        pathToLevels = @"/Users/air/Documents/Object Oriented Programming/ZendGame/quiz/Zend/Zend/Levels/Level";
>>>>>>> quiz
        pathToLevels = [pathToLevels stringByAppendingString:[@(lvl) stringValue]];
        
        platforms = [NSMutableArray array];
        zombies   = [NSMutableArray array];
        stages    = [NSMutableArray array];
        
        pFactory = [[PlatformFactory alloc] init];
        cFactory = [[CharacterFactory alloc] init];
    }
    return self;
}

- (void)loadPlatforms {
    NSError  *error;
    NSString *path = [pathToLevels stringByAppendingString:@"/platforms.json"];
<<<<<<< HEAD
    NSLog(@"%@", path);
=======
>>>>>>> quiz
    NSURL    *url = [NSURL fileURLWithPath:path];
    NSData   *jsonPlatformsData = [NSData dataWithContentsOfURL:url];
    NSDictionary *jsonPlatformsDict = [NSJSONSerialization JSONObjectWithData:jsonPlatformsData
                                                                     options:0
                                                                       error:&error];
    if (jsonPlatformsDict) {
        NSString *type, *texture; //*action;
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
    
}

- (void)createPlatformsOn:(SKNode *)node {
    for (id platform in platforms) {
        [node addChild:platform];
    }
}

- (void)createZombiesOn:(SKNode *)node {
    for (id zombie in zombies) {
        [node addChild:zombie];
    }
}

- (void)createStagesOn:(SKNode *)node {
    for (id stage in stages) {
        [node addChild:stage];
    }
}

- (void)buildOn:(SKNode *)node {
    [self loadPlatforms];
    [self loadZombies];
    [self createPlatformsOn:node];
    [self createZombiesOn:node];
}

@end
