//
//  Ship.h
//  Apocalypse
//
//  Created by Erik Peterson on 4/27/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <SpriteKit/SKSpriteNode.h>
#import "Ship.h"



@interface HeroShip : Ship

-(void) setUpPhysics;
-(void) applyThrust:(CGPoint) direction;
-(void) stopThrust;
-(void) explode;

@end
