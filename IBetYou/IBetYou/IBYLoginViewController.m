//
//  IBYLoginViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYLoginViewController.h"
#import "IBYLoginWebService.h"
#import "IBYSignUpViewController.h"
#import "IBYMainNavigationController.h"

@interface IBYLoginViewController () <IBYLoginWebServiceDelegate, IBYSignUpViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBYLoginWebService *loginWebService;
@property (strong, nonatomic) IBYSignUpViewController *signUpViewController;

@end

@implementation IBYLoginViewController

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"Welcome!";
        _loginWebService = [[IBYLoginWebService alloc] initWithDelegate:self];
        _signUpViewController = [[IBYSignUpViewController alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - IBAction

- (IBAction)textFieldEditingChanged:(id)sender
{
    _loginButton.enabled = [self isValidForm];
}

- (IBAction)loginButtonPressed:(id)sender
{
    [self loginWithEmail:_emailTextField.text password:_passwordTextField.text];
}

- (IBAction)signUpButtonPressed:(id)sender
{
    [self.navigationController presentViewController:_signUpViewController animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _emailTextField)
    {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField && [self isValidForm])
    {
        [self loginButtonPressed:_loginButton];
    }
    return YES;
}

#pragma mark - IBYLoginWebServiceDelegate

- (void)loginWebServiceDidCompleteLogin
{
    [self hideProgressHUD];
    [self showMainScreen];
}

- (void)loginWebServiceDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - IBYSignUpViewControllerDelegate

- (void)signUpViewControllerDidSignUpWithEmail:(NSString *)email password:(NSString *)password
{
    [self loginWithEmail:email password:password];
}

#pragma mark - Private

- (BOOL)isValidForm
{
    return _emailTextField.text.length > 0 && _passwordTextField.text.length > 0;
}

- (void)showMainScreen
{
    IBYMainNavigationController *navigationController = [[IBYMainNavigationController alloc] init];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
    [self hideKeyboard];
    [self showProgressHUDWithText:@"Logging in..."];
    [_loginWebService loginWithEmail:email password:password];
}

@end
