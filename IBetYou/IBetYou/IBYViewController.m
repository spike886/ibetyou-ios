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

@property (strong, nonatomic) UIGestureRecognizer *gestureRecognizer;

@end

@implementation IBYViewController

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    }
    return self;
}

#pragma mark - Accessors

- (void)setAutodismissKeyboard:(BOOL)autodismissKeyboard
{
    _autodismissKeyboard = autodismissKeyboard;
    
    if (autodismissKeyboard)
    {
        [self.view addGestureRecognizer:_gestureRecognizer];
    }
    else
    {
        [self.view removeGestureRecognizer:_gestureRecognizer];
    }
}

#pragma mark - Public

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

- (void)showMessage:(NSString *)message color:(UIColor *)color
{
    _messageLabel.text = message;
    _messageLabel.textColor = color;
}

- (void)clearMessage
{
    _messageLabel.text = @"";
}

@end
