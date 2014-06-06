//
//  Ship.m
//  Apocalypse
//
//  Created by Erik Peterson on 5/13/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import "Ship.h"
#import "ActionScene.h"

@implementation Ship

-(void)setUpPhysics
{
    SKPhysicsBody * body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    body.affectedByGravity = NO;
    body.allowsRotation = YES;
    body.dynamic = YES;
    body.density = 0.5;
    body.mass = 0.9;
    body.resting = YES;
    self.physicsBody = body;
}

-(void) applyThrust:(CGPoint) direction
{
    
}

-(void) stopThrust
{
    
}

- (CGVector) directionVector
{
    CGVector vector;
    CGFloat distance = self.size.height/2;
    CGFloat theta = self.zRotation;
    CGFloat dx,dy = 0.0;
    int quadrant;
    if (theta >= 0.0 && theta < M_PI/2) {
        quadrant = 2;
        dy = distance;
    }
    if (theta >= M_PI/2 && theta < M_PI) {
        quadrant = 3;
        dy = -distance;
    }
    if (theta < 0 && theta >= -M_PI/2 ) {
        quadrant = 1;
        dy = distance;
        
    }
    if (theta < -M_PI/2 && theta >= -M_PI) {
        quadrant = 4;
        dy = -distance;
    }
    // normalizing to x,y coordinate system by rotating 90 degrees
    //theta += M_PI/2;
    theta = theta - M_PI/2;
    if (theta != 0 && theta != M_PI) {
        dx = dy/tanf(theta);
    }
    else
        dx = 0.0;
    
    
    vector = CGVectorMake(dx, dy);
    
    return vector;
    
}

-(SKEmitterNode *) createWeaponEmiterNodeWithPosition:(CGPoint) position
{
    SKEmitterNode * weapon = [NSKeyedUnarchiver unarchiveObjectWithFile:weaponPath];
    //SKNode * weapon = [[SKNode alloc] init];
    [weapon setScale:0.2];
    //weapon.zRotation = self.zRotation;
    weapon.position = position;
    //[weapon setParticlePosition:position];
    
    return weapon;
    
}

-(SKPhysicsBody *) createWeaponPhysicsBodyWithRadius:(CGFloat) x
{
    SKPhysicsBody * body;
    body = [SKPhysicsBody bodyWithCircleOfRadius:x];
    body.affectedByGravity = NO;
    body.allowsRotation = NO;
    body.dynamic = YES;
    body.density = 0.1;
    body.mass = 0.1;
    body.resting = YES;
    
    return body;
    
}

-(void) fireWeapon
{
    SKPhysicsBody * body;
    CGFloat force;
    CGRect f;
    CGPoint pos;
    CGVector v;
    SKEmitterNode * weapon;
    
    pos = self.position;
    f = self.frame;
    force = 10.0;
    [self runAction:pewPewSoundAction];
    v = [self directionVector];
    pos.x += v.dx;
    pos.y += v.dy;
    weapon = [self createWeaponEmiterNodeWithPosition:pos];
    weapon.name = @"newFireBall";
    [self.parent addChild:weapon];
    body = [self createWeaponPhysicsBodyWithRadius:self.frame.size.width/10];
    weapon.physicsBody = body;
    [weapon.physicsBody applyForce:CGVectorMake(force *v.dx, force * v.dy)];
    
}

-(void) explode
{
    
}


@end
