//
//  IBYTabBarController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYTabBarController.h"
#import "IBYMyCurrentBetsViewController.h"
#import "IBYScoreboardViewController.h"
#import "IBYCreateBetViewController.h"

@interface IBYTabBarController ()

@property (strong, nonatomic) IBYMyCurrentBetsViewController *myCurrentBetsViewController;
@property (strong, nonatomic) IBYScoreboardViewController *scoreboardViewController;
@property (strong, nonatomic) IBYCreateBetViewController *createBetViewControllers;

@end

@implementation IBYTabBarController

- (id)init
{
    self = [super init];
    if (self)
    {
        _myCurrentBetsViewController = [[IBYMyCurrentBetsViewController alloc] init];
        _scoreboardViewController = [[IBYScoreboardViewController alloc] init];
        _createBetViewControllers = [[IBYCreateBetViewController alloc] init];
        self.viewControllers = @[_myCurrentBetsViewController, _scoreboardViewController, _createBetViewControllers];
    }
    return self;
}

@end
