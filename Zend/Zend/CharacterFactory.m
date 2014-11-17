//
//  CharacterFactory.m
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import "CharacterFactory.h"

//static NSArray *prototypes;

@implementation CharacterFactory

- (id)init {
    self = [super init];
    if (self) {
        
        Human *baseHuman = [[Human alloc] init];
        SkinnyZombie *baseSkinnyZombie = [[SkinnyZombie alloc] init];
        FatZombie *baseFatZombie =[[FatZombie alloc] init];
        prototypes = [NSArray arrayWithObjects:baseHuman, baseSkinnyZombie, baseFatZombie, nil];
        
    }
    return self;
}

- (Character *)spawnCharacter:(NSString *)characterName
                     withType:(NSString *)characterType {
    
    if ([characterName isEqualToString:@"Player"]) {
        Character *newCharacter = [[prototypes objectAtIndex:0] cloneWithType:characterType];
        return newCharacter;
    }
    
    else if ([characterName isEqualToString:@"Friend"]) {
        Character *newCharacter = [[prototypes objectAtIndex:0] cloneWithType:characterType];
        return newCharacter;
    }
    
    else if ([characterName isEqualToString:@"SkinnyZombie"]) {
        Character *newCharacter = [[prototypes objectAtIndex:1] cloneWithType:characterType];
        return newCharacter;
    }
    
    else if ([characterName isEqualToString:@"FatZombie"]) {
        Character *newCharacter = [[prototypes objectAtIndex:2] cloneWithType:characterType];
        return newCharacter;
    }
    
    else {
        return nil;
    }
    
}

@end
