//
//  IBYScoreboardViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYScoreboardViewController.h"
#import "IBYAppState.h"

@interface IBYScoreboardViewController ()

@end

@implementation IBYScoreboardViewController

#pragma mark - IBAction

- (IBAction)logoutButtonPressed:(id)sender
{
    [[IBYAppState state] setLoginToken:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
