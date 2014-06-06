//
//  Ship.m
//  Apocalypse
//
//  Created by Erik Peterson on 4/27/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import "HeroShip.h"
#import "ActionScene.h"

@implementation HeroShip

-(void) setUpPhysics
{
    
    [super setUpPhysics];
    self.physicsBody.contactTestBitMask = 0x1;
    self.physicsBody.categoryBitMask = shipCategory;
    self.physicsBody.collisionBitMask = ufoCategory;
    self.physicsBody.contactTestBitMask = ufoCategory;
    self.physicsBody.contactTestBitMask = 0x1;
    thrust = 1.0;
    dir = 0;
    
    NSString *burstPath = [[NSBundle mainBundle] pathForResource:@"thrust" ofType:@"sks"];
    
    weaponPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    thrustNode = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
    thrustNode.position = CGPointMake(0.0,-160.0);
    [self addChild:thrustNode];
    
    pewPewSoundAction = [SKAction playSoundFileNamed:@"ApocoPewPew.m4a" waitForCompletion:NO];
    
    soundAction = [SKAction playSoundFileNamed:@"ApocoThrust.m4a" waitForCompletion:NO];

}

-(void) applyThrust:(CGPoint) direction
{
    //CGVector vector = CGVectorMake(thrust * cosf(direction),thrust * sinf(direction));
    CGFloat dx,dy,rx = 0.0,ry = 0.0,angle,rotAngle = 0.0,correction = 0.0;
    
    dx = direction.x - [self calculateAccumulatedFrame].origin.x;
    dy = direction.y - [self calculateAccumulatedFrame].origin.y;
    
    //quadrant 1
    if (dx >= 0 && dy >= 0) {
        
        ry = dy;
        rx = dx;
        correction =  M_PI + M_PI/2;
        angle = ry/sqrt(rx*rx + ry*ry);
        rotAngle = correction + angle;
    }
    //quadrant 2
    if (dx  < 0 && dy >= 0) {
        ry = dy;
        rx = -dx;
        correction = M_PI/2;
        angle = ry/sqrt(rx*rx + ry*ry);
        rotAngle = correction - angle;
    }
    //quadrant 3
    if (dx < 0 && dy < 0) {
        ry = -dy;
        rx = -dx;
        angle = ry/sqrt(rx*rx + ry*ry);
        correction = M_PI/2;
        rotAngle = correction + angle;
    }
    //quadrant 4
    if (dx >= 0 && dy < 0) {
        ry = -dy;
        rx = dx;
        angle = ry/sqrt(rx*rx + ry*ry);
        correction = M_PI + M_PI/2;
        rotAngle = correction - angle;
    }

    

    SKAction * rotationAction = [SKAction rotateToAngle:rotAngle duration:0.1 shortestUnitArc:YES];
    
    CGVector particlePosRange = CGVectorMake(50.0, 0.0);
    thrustNode.particlePositionRange = particlePosRange;
    
    CGVector vector = CGVectorMake(thrust * dx,thrust * dy);
    [self.physicsBody applyForce:vector];
    [self runAction:rotationAction];
    //[self runAction:soundAction];
    
    
}

-(void) stopThrust
{
    CGVector particlePosRange = CGVectorMake(0.0, 0.0);
    thrustNode.particlePositionRange = particlePosRange;

}

- (CGVector) directionVector
{
    CGVector vector;

    vector = [super directionVector];
    
    return vector;
}

-(SKEmitterNode *) createWeaponEmiterNodeWithPosition:(CGPoint) position
{
    SKEmitterNode * weapon;
    
    weapon = [super createWeaponEmiterNodeWithPosition:position];
    
    return weapon;
}

-(SKPhysicsBody *) createWeaponPhysicsBodyWithRadius:(CGFloat) x
{
    SKPhysicsBody * body;
    [self createWeaponPhysicsBodyWithRadius:x];
    body.categoryBitMask = weaponCategory;
    body.collisionBitMask = ufoCategory;
    body.contactTestBitMask = ufoCategory;
    return body;
}



-(void) explode
{
    
}


@end
