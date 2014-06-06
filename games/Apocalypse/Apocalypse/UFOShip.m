//
//  UFOShip.m
//  Apocalypse
//
//  Created by Erik Peterson on 5/7/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import "UFOShip.h"
#import "ActionScene.h"

@implementation UFOShip



-(void) setUpPhysics
{
    SKPhysicsBody * body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    body.affectedByGravity = NO;
    body.allowsRotation = YES;
    body.dynamic = YES;
    body.density = 0.5;
    body.mass = 0.9;
    body.resting = YES;
    body.contactTestBitMask = 0x1;
    body.categoryBitMask = ufoCategory;
    body.collisionBitMask = shipCategory | ufoCategory | weaponCategory;
    body.contactTestBitMask = shipCategory | ufoCategory | weaponCategory;
    self.physicsBody = body;
    
}

@end
