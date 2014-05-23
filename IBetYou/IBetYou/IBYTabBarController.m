//
//  IBYTabBarController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYTabBarController.h"
#import "IBYMyCurrentBetsViewController.h"
#import "IBYDashboardViewController.h"
#import "IBYCreateBetViewController.h"

@interface IBYTabBarController ()

@end

@implementation IBYTabBarController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IBYMyCurrentBetsViewController *myCurrentBetsViewController = [[IBYMyCurrentBetsViewController alloc] init];
    IBYDashboardViewController *dashboardViewController = [[IBYDashboardViewController alloc] init];
    IBYCreateBetViewController *createBetViewController =[[IBYCreateBetViewController alloc] init];
    
    UINavigationController *navigationCurrent = [[UINavigationController alloc] initWithRootViewController:myCurrentBetsViewController];
    UINavigationController *navigationDashboard = [[UINavigationController alloc] initWithRootViewController:dashboardViewController];
    UINavigationController *navigationCreate = [[UINavigationController alloc] initWithRootViewController:createBetViewController];
    
    navigationCurrent.title = @"Current";
    navigationDashboard.title = @"Dashboard";
    navigationCreate.title = @"Create";
    
    self.viewControllers = @[navigationCurrent, navigationDashboard, navigationCreate];
    self.selectedIndex = IBYTabBarScoreboardTab;
}

@end
