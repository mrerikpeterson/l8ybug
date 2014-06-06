//
//  WelcomeScene.m
//  Apocalypse
//
//  Created by Erik Peterson on 4/27/14.
//  Copyright (c) 2014 Erik Peterson. All rights reserved.
//

#import "WelcomeScene.h"
#import "ActionScene.h"

@implementation WelcomeScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.3 green:0.15 blue:0.15 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Baskerville"];
        
        myLabel.text = @"Apocalypse!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKView * skView = (SKView *)[[[UIApplication sharedApplication] keyWindow] rootViewController].view;
    
    SKScene * scene = [ActionScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
