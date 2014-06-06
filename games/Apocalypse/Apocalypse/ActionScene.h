//
//  MyScene.h
//  Apocalypse
//

//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "HeroShip.h"
#import "UFOShip.h"
#import "WelcomeScene.h"

static const uint32_t shipCategory        =  0x1 << 0;
static const uint32_t ufoCategory         =  0x1 << 1;
static const uint32_t weaponCategory        =  0x1 << 2;

@interface ActionScene : SKScene <SKPhysicsContactDelegate> {
    HeroShip *ship;
    UFOShip * ufoShip;
    NSTimeInterval thrustTime;

}

-(void) explodeNode:(SKNode *) n;



@end
