//
//  AGFadingSegue.m
//  Istrebit
//
//  Created by Andrey Gordeev on 1/10/14.
//  Copyright (c) 2014 Andrey Gordeev. All rights reserved.
//

#import "AGFadingSegue.h"

@implementation AGFadingSegue

- (void)perform
{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
        
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.view.window.layer addAnimation:transition forKey:kCATransition];
    [self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
}

@end
