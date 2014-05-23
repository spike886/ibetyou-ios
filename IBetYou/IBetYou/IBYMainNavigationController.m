//
//  IBYMainNavigationController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYMainNavigationController.h"
#import "IBYTabBarController.h"

@interface IBYMainNavigationController ()

@property (strong, nonatomic) IBYTabBarController *tabBarController;

@end

@implementation IBYMainNavigationController

#pragma mark - Class

+ (instancetype)mainNavigationController
{
    IBYTabBarController *tabBarController = [[IBYTabBarController alloc] init];
    IBYMainNavigationController *mainNavigationController = [[IBYMainNavigationController alloc] initWithRootViewController:tabBarController];
    if (mainNavigationController)
    {
        mainNavigationController.title = @"Welcome!";
        mainNavigationController.tabBarController = tabBarController;
        [mainNavigationController setNavigationBarHidden:YES];
    }
    return mainNavigationController;
}

@end
