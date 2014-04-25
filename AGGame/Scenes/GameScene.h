//
//  GameScene.h
//  AGGame
//

//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef void (^AGAssetLoadCompletionHandler)(void);

@protocol GameSceneDelegate <NSObject>

- (void)presentGameOverViewController;

@end

@interface GameScene : SKScene<SKPhysicsContactDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<GameSceneDelegate> delegate;
+ (void)loadSceneAssetsWithCompletionHandler:(AGAssetLoadCompletionHandler)handler;

@end
