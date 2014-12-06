//
//  ZendTests.m
//  ZendTests
//
//  Created by Nikita Makarov on 16.11.14.
//  Copyright (c) 2014 HardCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "GameScene.h"

@interface ZendTests : XCTestCase

@end

@implementation ZendTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateSkinnyZombie {
    
    CGPoint spawnPosition = CGPointMake(0, 0);
    
    /* CREATE CORRECT ZOMBIE PATTERN */
    
    Character *zombiePattern = [[SkinnyZombie alloc] initWithImageNamed:@"SkinnyZombie"];
    
    /* INIT CORRECT PHYSICS BODY */
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, -40, 80);
    CGPathAddLineToPoint(path, NULL, 40, 80);
    CGPathAddLineToPoint(path, NULL, 40, -75);
    CGPathAddLineToPoint(path, NULL, 30, -80);
    CGPathAddLineToPoint(path, NULL, -30, -80);
    CGPathAddLineToPoint(path, NULL, -40, -75);
    CGPathCloseSubpath(path);
    
    zombiePattern.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    zombiePattern.physicsBody.restitution = 0;
    zombiePattern.physicsBody.friction = 0.0;
    zombiePattern.physicsBody.allowsRotation = NO;
    zombiePattern.physicsBody.dynamic = YES;
    
    zombiePattern.physicsBody.categoryBitMask    = ZOMBIE;
    zombiePattern.physicsBody.collisionBitMask   = PLATFORM | DYNAMIC_PLATFORM;
    zombiePattern.physicsBody.contactTestBitMask = GROUND | PLATFORM | DYNAMIC_PLATFORM | HUMAN | ZOMBIE;
    zombiePattern.physicsBody.friction = 0;
    zombiePattern.physicsBody.mass     = 1;
    
    /* INIT CORRECT GENERAL PROPERTIES */
    
    zombiePattern.type = SZOMBIE;
    zombiePattern.jumpSpeed = 500;
    zombiePattern.runSpeed  = 300;
    zombiePattern.position  = spawnPosition;
    zombiePattern.health    = 2;
    zombiePattern.zPosition = 10;
    [zombiePattern.weapon setFirstSlotWeaponType:MELEE];
    
    /* CREATE TEST ZOMBIE UNIT */
    
    CharacterFactory *factory = [[CharacterFactory alloc] init];
    Character        *testZombie  = [factory createCharacter:SZOMBIE atPosition:spawnPosition];
    
    /* TEST PHYSICS BODY */
    
    XCTAssertEqual(zombiePattern.physicsBody.restitution,
                   testZombie.physicsBody.restitution,
                   @"property [restitution] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.friction,
                   testZombie.physicsBody.friction,
                   @"property [friction] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.allowsRotation,
                   testZombie.physicsBody.allowsRotation,
                   @"property [allowsRotation] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.dynamic,
                   testZombie.physicsBody.dynamic,
                   @"property [dynamic] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.categoryBitMask,
                   testZombie.physicsBody.categoryBitMask,
                   @"property [categoryBitMask] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.collisionBitMask,
                   testZombie.physicsBody.collisionBitMask,
                   @"property [collisionBitMask] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.contactTestBitMask,
                   testZombie.physicsBody.contactTestBitMask,
                   @"property [contactTestBitMask] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.friction,
                   testZombie.physicsBody.friction,
                   @"property [friction] should be equal");
    
    XCTAssertEqual(zombiePattern.physicsBody.mass,
                   testZombie.physicsBody.mass,
                   @"property [mass] should be equal");

    /* TEST GENERAL PROPERTIES */
    
    XCTAssertEqual(zombiePattern.type,
                   testZombie.type,
                   @"property [type] should be equal");
    
    XCTAssertEqual(zombiePattern.jumpSpeed,
                   testZombie.jumpSpeed,
                   @"property [jumpSpeed] should be equal");
    
    XCTAssertEqual(zombiePattern.runSpeed,
                   testZombie.runSpeed,
                   @"property [runSpeed] should be equal");
    
    XCTAssertEqual(zombiePattern.position.x,
                   testZombie.position.x,
                   @"property [position.x] should be equal");

    XCTAssertEqual(zombiePattern.position.y,
                   testZombie.position.y,
                   @"property [position.y] should be equal");
    
    XCTAssertEqual(zombiePattern.health,
                   testZombie.health,
                   @"property [health] should be equal");
    
    XCTAssertEqual(zombiePattern.zPosition,
                   testZombie.zPosition,
                   @"property [zPosition] should be equal");
    
    XCTAssertEqual(zombiePattern.weapon.firstGun.damage,
                   testZombie.weapon.firstGun.damage,
                   @"property [weapon.firstGun.damage] should be equal");
    
    XCTAssertEqual(zombiePattern.weapon.firstGun.shotInterval,
                   testZombie.weapon.firstGun.shotInterval,
                   @"property [weapon.firstGun.shotInterval] should be equal");
    
    XCTAssertEqual(zombiePattern.weapon.firstGun.isReady,
                   testZombie.weapon.firstGun.isReady,
                   @"property [weapon.firstGun.isReady] should be equal");
    
}

- (void)testLoadingPlatforms {
    Level *level = [[Level alloc] initWithLevel:0];
    [level loadPlatforms];
    for (Platform *platform in level.platforms) {
        XCTAssertNotNil(platform, @"platform should not be nil");
    }
}

- (void)testZombiezJSONDataIsCorrect {
    
    NSInteger amountInZombiesJSON = 0;
    NSInteger amountInStagesJSON  = 0;
    
    SKNode *world = [[SKNode alloc] init];
    Level  *level = [[Level alloc] initWithLevel:0];
    [level buildOn:world];
    
    amountInZombiesJSON = level.zombies.count;
    
    for (Stage *stage in level.stages) {
        amountInStagesJSON += stage.amountOfZombies;
    }
    
    XCTAssertEqual(amountInZombiesJSON, amountInStagesJSON, @"amounts should be equal");
    
}

@end
