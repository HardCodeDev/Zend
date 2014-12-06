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
        FatZombie *baseFatZombie = [[FatZombie alloc] init];
        prototypes = [NSArray arrayWithObjects:baseHuman, baseSkinnyZombie, baseFatZombie, nil];
    }
    return self;
    
}

- (Character *)createCharacter:(CharacterType)cType atPosition:(CGPoint)position {
    
    if (cType == PLAYER) {
        Character *newCharacter = [[prototypes objectAtIndex:0] cloneWithType:cType atPosition:position];
        return newCharacter;
    }
    
    else if (cType == FRIEND) {
        Character *newCharacter = [[prototypes objectAtIndex:0] cloneWithType:cType atPosition:position];
        return newCharacter;
    }
    
    else if (cType == SZOMBIE) {
        Character *newCharacter = [[prototypes objectAtIndex:1] cloneWithType:cType atPosition:position];
        return newCharacter;
    }
    
    else if (cType == FZOMBIE) {
        Character *newCharacter = [[prototypes objectAtIndex:2] cloneWithType:cType atPosition:position];
        return newCharacter;
    }
    
    else {
        return nil;
    }
    
}

@end
