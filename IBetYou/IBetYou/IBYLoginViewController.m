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
#import "IBYAppState.h"

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

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.autodismissKeyboard = YES;
    if([[IBYAppState state] loginToken])
    {
        [self showMainScreenAnimated:NO];
    }
}

#pragma mark - IBAction

- (IBAction)textFieldEditingChanged:(id)sender
{
    [self validateForm];
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
    [self resetTextFields];
    [self showMainScreenAnimated:YES];
}

- (void)loginWebServiceDidFailWithError:(NSError *)error
{
    [[IBYAppState state] setUserEmail:nil];
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

- (void)showMainScreenAnimated:(BOOL)animated
{
    IBYMainNavigationController *navigationController = [IBYMainNavigationController mainNavigationController];
    [self.navigationController presentViewController:navigationController animated:animated completion:nil];
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
    [[IBYAppState state] setUserEmail:email];
    [self hideKeyboard];
    [self showProgressHUDWithText:@"Logging in..."];
    [_loginWebService loginWithEmail:email password:password];
}

- (void)resetTextFields
{
    _emailTextField.text = @"";
    _passwordTextField.text = @"";
    [self validateForm];
}

- (void)validateForm
{
    _loginButton.enabled = [self isValidForm];
}

@end
