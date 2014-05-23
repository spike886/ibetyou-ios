//
//  IBYViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface IBYViewController ()

@end

@implementation IBYViewController

- (void)showProgressHUDWithText:(NSString *)text
{
    [SVProgressHUD showWithStatus:text];
}

- (void)hideProgressHUD
{
    [SVProgressHUD dismiss];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

@end
