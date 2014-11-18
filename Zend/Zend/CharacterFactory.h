//
//  CharacterFactory.h
//  Zend
//
//  Created by Nikita Makarov on 17/11/14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Human.h"
#import "SkinnyZombie.h"
#import "FatZombie.h"

@interface CharacterFactory : NSObject {
    @private
    NSArray *prototypes;
}

- (id)init;
- (Character *)createCharacter:(CharacterType)cType;

@end
