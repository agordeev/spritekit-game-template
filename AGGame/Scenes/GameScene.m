//
//  GameScene.m
//  AGGame
//
//  Created by Andrey Gordeev on 4/9/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

// Layers
@property (nonatomic) SKNode *backgroundLayer;
@property (nonatomic) SKNode *uiLayer;

// Gesture Recognizers
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.view.ignoresSiblingOrder = YES;
        [self buildScene];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    [self setUpGestures];
}

#pragma mark - Building Scene

- (void)buildScene {
    [self addLayers];
    [self configurePhysics];
}

- (void)addLayers {
    self.backgroundLayer = [SKNode node];
    self.backgroundLayer.zPosition = 100;
    [self addChild:self.backgroundLayer];
    
//    // Add other layers here, for example:
//    self.playerLayer = [SKNode node];
//    self.playerLayer.zPosition = 200;
//    [self addChild:self.playerLayer];
    
    
    self.uiLayer = [SKNode node];
    self.uiLayer.zPosition = 1000;
    [self addChild:self.uiLayer];
}

- (void)configurePhysics {
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    self.physicsBody.categoryBitMask = GROUND_CATEGORY;
    self.physicsWorld.contactDelegate = self;
//    self.physicsWorld.gravity = CGVectorMake(0, -5.0);
}

#pragma mark - Gestures

- (void)setUpGestures {
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer {
    CGPoint touchPoint = [self convertPointFromView:[recognizer locationInView:self.view]];
}

#pragma mark - Game logic

- (void)gameOver {
    [self.delegate presentGameOverViewController];
}

#pragma mark - SKScene methods 

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)dealloc {
    NSLog(@"GAME SCENE DEALLOCATED");
}

#pragma mark - Shared Assets

+ (void)loadSceneAssetsWithCompletionHandler:(AGAssetLoadCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Load the shared assets in the background.
        [self loadSceneAssets];
        
        if (!handler) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Call the completion handler back on the main queue.
            handler();
        });
    });
}

+ (void)loadSceneAssets {
//    sBackgroundTexture = [SKTexture textureWithImageNamed:@"background"];
}

//static SKTexture *sBackgroundTexture = nil;
//- (SKTexture *)backgroundTexture {
//    return sBackgroundTexture;
//}

@end
