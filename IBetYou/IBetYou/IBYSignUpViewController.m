//
//  IBYSignUpViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYSignUpViewController.h"
#import "IBYSignUpWebService.h"

@interface IBYSignUpViewController () <IBYSignUpWebServiceDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

@property (strong, nonatomic) IBYSignUpWebService *signUpWebService;

@end

@implementation IBYSignUpViewController

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYSignUpViewControllerDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _signUpWebService = [[IBYSignUpWebService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.autodismissKeyboard = YES;
}

#pragma mark - IBAction

- (IBAction)signUpButtonPressed:(id)sender
{
    [self hideKeyboard];
    [self showProgressHUDWithText:@"Creating account..."];
    [_signUpWebService signUpWithEmail:_emailTextField.text
                              password:_passwordTextField.text];
}

- (IBAction)emailTextFieldEditingChanged:(id)sender
{
    [self validateForm];
}

- (IBAction)anyPasswordTextFieldEditingChanged:(id)sender
{
    [self validateForm];
    
    if (![self passwordsMatch])
    {
        [self showMessage:@"Passwords don't match" color:[UIColor redColor]];
    }
    else
    {
        [self clearMessage];
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _emailTextField)
    {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField)
    {
        [_confirmPasswordTextField becomeFirstResponder];
    }
    else if (textField == _confirmPasswordTextField && [self isValidForm])
    {
        [self signUpButtonPressed:_signUpButton];
    }
    return YES;
}

#pragma mark - IBYSignUpWebServiceDelegate

- (void)signUpWebServiceDidCompleteSignUp
{
    [self hideProgressHUD];
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate signUpViewControllerDidSignUpWithEmail:_emailTextField.text
                                                 password:_passwordTextField.text];
    }];
}

- (void)signUpWebServiceDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not create account" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private

- (BOOL)isValidForm
{
    return _emailTextField.text.length > 0 && _passwordTextField.text.length > 0 && [self passwordsMatch];
}

- (BOOL)passwordsMatch
{
    return [_confirmPasswordTextField.text isEqualToString:_passwordTextField.text];
}

- (void)validateForm
{
    _signUpButton.enabled = [self isValidForm];
}

@end
