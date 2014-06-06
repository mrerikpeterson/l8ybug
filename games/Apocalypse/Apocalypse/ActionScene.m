//
//  MyScene.m
//  Apocalypse
//
//  Created by Erik Peterson on 4/27/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import "ActionScene.h"



@implementation ActionScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.3 green:0.15 blue:0.15 alpha:1.0];
        SKSpriteNode * background = [SKSpriteNode spriteNodeWithImageNamed:@"space1" ];
        ship = [HeroShip spriteNodeWithImageNamed:@"Spaceship"];
        
        ship.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        
        [ship setScale:0.2];
        [ship setUpPhysics];
        [ship setName:@"ship"];
        
        ufoShip = [UFOShip spriteNodeWithImageNamed:@"UFO_metalic.png"];
        ufoShip.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100.0);
        [ufoShip setScale:0.2];
        [ufoShip setName:@"ufoShip"];
        [ufoShip setUpPhysics];
        CGVector vector = CGVectorMake(1000.0,0.0);
        
        
        
        //[background setScale:0.5];
        background.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMidY(self.frame));
        [self addChild:background];
        [self addChild:ship];
        [self addChild:ufoShip];
        [ufoShip.physicsBody applyForce:vector];
        
        self.physicsWorld.contactDelegate = self;
        
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    if ([touches count] == 2) {
        [ship fireWeapon];
    }
    
    if ([touches count] == 1) {
        UITouch * touch = [[touches objectEnumerator]nextObject];
        CGPoint location = [touch locationInNode:self];
        [ship applyThrust:location];
        thrustTime = event.timestamp;
    }

    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch * touch = [[touches objectEnumerator]nextObject];
        CGPoint location = [touch locationInNode:self];
        [ship applyThrust:location];
        thrustTime = event.timestamp;
    }
    
}


-(void) gotoMenuScene
{
    SKView * skView = (SKView *)[[[UIApplication sharedApplication] keyWindow] rootViewController].view;
    SKScene * scene = [[WelcomeScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self enumerateChildNodesWithName:@"ship" usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint pos = node.position;
        if (node.position.x < 0) {
            pos.x = self.size.width;
        }
        if (node.position.x > self.size.width) {
            pos.x = 0.0;
        }
        if (node.position.y < 0) {
            pos.y = self.size.height;
        }
        if (node.position.y > self.size.height)
        {
            pos.y = 0.0;
        }
        node.position = pos;
        if (currentTime - thrustTime > 1.2) {
            [ship stopThrust];
        }
        
    }];
    [self enumerateChildNodesWithName:@"ufoShip" usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint pos = node.position;
        if (node.position.x < 0) {
            pos.x = self.size.width;
        }
        if (node.position.x > self.size.width) {
            pos.x = 0.0;
        }
        if (node.position.y < 0) {
            pos.y = self.size.height;
        }
        if (node.position.y > self.size.height)
        {
            pos.y = 0.0;
        }
        node.position = pos;
        
        
    }];
    [self enumerateChildNodesWithName:@"newFireBall" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.x < 0) {
            [node removeFromParent];
        }
        if (node.position.x > self.size.width) {
            [node removeFromParent];
        }
        if (node.position.y < 0) {
            [node removeFromParent];
        }
        if (node.position.y > self.size.height)
        {
            [node removeFromParent];
        }
        
    }];
    if ([[self children] count] == 1) {
        [self gotoMenuScene];
    }
    //NSLog(@"Children: %d",[[self children] count]);


}

-(void) explosionTest:(SKNode *) a
{
    if ([a.name isEqualToString:@"ufoShip"] || [a.name isEqualToString:@"ship"]) {
        [self explodeNode:a];
    }
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKNode * a;
    SKNode * b;
    
    a = contact.bodyA.node;
    b = contact.bodyB.node;
    
    [self explosionTest:a];
    [self explosionTest:b];
    
    
}
-(void) burnDownExplosion:(NSArray *) args
{
    [NSThread sleepForTimeInterval:5];
    [(SKEmitterNode*)[args objectAtIndex:0] removeFromParent];
    if([(NSString*)[args objectAtIndex:1] isEqualToString:@"ufoShip"])
    {
        [self gotoMenuScene];
    }
}

-(void) explodeNode:(SKNode *) n
{
    NSString * explosionString = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    NSString * nodeName;
    NSMutableArray * array = [[NSMutableArray alloc] init];
    //[NSKeyedUnarchiver unarchiveObjectWithFile:name];
    SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionString];
    explosion.position = n.position;
    explosion.name = @"explosion";
    nodeName = n.name;
    [array addObject:explosion];
    [array addObject:nodeName];
    [self addChild:explosion];
    
    [n removeFromParent];
    [NSThread detachNewThreadSelector:@selector(burnDownExplosion:) toTarget:self withObject:array];

}

/*
-(void) longPress
{
    CGPoint point = [thrustGesture locationInView:self.view];
    UITouch * touch = thrustGesture getTouch
    
    
    if ([touches count] == 1) {
        UITouch * touch = [[touches objectEnumerator]nextObject];
        CGPoint location = [touch locationInNode:self];
        [ship applyThrust:location];
        thrustTime = event.timestamp;
    }
    
}
*/



@end
