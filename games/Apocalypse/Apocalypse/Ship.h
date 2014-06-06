//
//  Ship.h
//  Apocalypse
//
//  Created by Erik Peterson on 5/13/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface Ship : SKSpriteNode
{
    CGFloat thrust;
    CGFloat dir;
    AVAudioPlayer * player;
    SKEmitterNode * thrustNode;
    NSString *weaponPath;
    SKAction * pewPewSoundAction;
    SKAction * soundAction;
    
}

-(void)setUpPhysics;
-(void) applyThrust:(CGPoint) direction;
-(void) fireWeapon;
-(void) stopThrust;
-(void) explode;
- (CGVector) directionVector;
-(SKEmitterNode *) createWeaponEmiterNodeWithPosition:(CGPoint) position;
-(SKPhysicsBody *) createWeaponPhysicsBodyWithRadius:(CGFloat) x;
@end
