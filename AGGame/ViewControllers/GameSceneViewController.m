//
//  GamesSceneViewController.m
//  AGGame
//
//  Created by Andrey Gordeev on 4/9/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "GameSceneViewController.h"
#import "GameScene.h"

@interface GameSceneViewController()

@property (weak, nonatomic) IBOutlet SKView *skView;

@end

@implementation GameSceneViewController

#pragma mark - UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.backgroundColor = [UIColor blackColor];
    self.skView.backgroundColor = [UIColor blackColor];
    if (!self.skView.window) {
        [self.view addSubview:self.skView];
    }
#ifdef DEBUG
    self.skView.showsFPS = YES;
    //    self.skView.showsPhysics = YES;
    self.skView.showsNodeCount = YES;
#endif
    
    if (!self.skView.scene) {
        CGSize viewSize = self.view.bounds.size;
        // On iPhone/iPod touch we want to see a similar amount of the scene as on iPad.
        // So, we set the size of the scene to be double the size of the view, which is
        // the whole screen, 3.5- or 4- inch. This effectively scales the scene to 50%.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            viewSize.height *= 1.58;
            viewSize.width *= 1.58;
        }
        SKScene *loadingScene = [[SKScene alloc] initWithSize:viewSize];
        loadingScene.backgroundColor = [UIColor blackColor];
        loadingScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.skView presentScene:loadingScene];
        
        [GameScene loadSceneAssetsWithCompletionHandler:^{
            [self presentSceneWithSize:(CGSize)viewSize];
        }];
    }
}

#pragma mark - Presentint GameScene

- (void)presentSceneWithSize:(CGSize)viewSize {
    GameScene *scene = [[GameScene alloc] initWithSize:viewSize];
    scene.delegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.skView presentScene:scene transition:[SKTransition crossFadeWithDuration:1.f]];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Need to deallocate GameScene (if game is not paused)
    [self.skView removeFromSuperview];
    self.skView = nil;
}

#pragma mark - GameSceneDelegate methods

- (void)presentGameOverViewController {
//    [self performSegueWithIdentifier:@"GameOverSegue" sender:nil];
}

#pragma mark - Misc

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
    
}

@end
