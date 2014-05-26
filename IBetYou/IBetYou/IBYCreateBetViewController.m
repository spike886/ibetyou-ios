//
//  IBYCreateBetViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYCreateBetViewController.h"
#import "IBYCreateBetWebService.h"
#import "IBYAppState.h"

@interface IBYCreateBetViewController () <IBYCreateBetWebServiceDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *betTextField;
@property (strong, nonatomic) IBOutlet UITextField *friendEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *pointsTextField;
@property (strong, nonatomic) IBOutlet UILabel *currentPointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *afterwardsPointsLabel;
@property (strong, nonatomic) IBOutlet UIButton *createButton;

@property (strong, nonatomic) IBYCreateBetWebService *createBetWebService;
@property (readwrite, nonatomic) NSInteger currentUserPoints;

@end

@implementation IBYCreateBetViewController

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"Create a Bet";
        _createBetWebService = [[IBYCreateBetWebService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.autodismissKeyboard = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _currentUserPoints = [[IBYAppState state] userPoints];
    [self updatePoints];
}

#pragma mark - IBAction

- (IBAction)createButtonPressed:(id)sender
{
    [self hideKeyboard];
    [self showProgressHUDWithText:@"Creating bet..."];
    [self requestCreateBet];
}

- (IBAction)anyTextFieldEditingChanged:(id)sender
{
    [self validateForm];
}

- (IBAction)pointsTextFieldEditingChanged:(id)sender
{
    [self updatePoints];
    if (![self userHasEnoughPointsToBet])
    {
        [self showMessage:@"You don't have enough points!" color:[UIColor redColor]];
    }
    else
    {
        [self clearMessage];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _betTextField)
    {
        [_friendEmailTextField becomeFirstResponder];
    }
    else if (textField == _friendEmailTextField)
    {
        [_pointsTextField becomeFirstResponder];
    }
    else if (textField == _pointsTextField)
    {
        [self createButtonPressed:_createButton];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _pointsTextField)
    {
        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark - IBYCreateBetWebServiceDelegate

- (void)createBetWebServiceDidCreateBet
{
    [self hideProgressHUD];
    [self resetFields];
    [self updatePoints];
    self.tabBarController.selectedIndex = IBYTabBarMyCurrentBetsTab;
}

- (void)createBetWebServiceDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not create bet" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private

- (void)validateForm
{
    _createButton.enabled = [self isValidForm];
}

- (BOOL)isValidForm
{
    return _betTextField.text.length > 0 && _friendEmailTextField.text.length > 0 && [self pointsFrom:_pointsTextField] > 0 && [self userHasEnoughPointsToBet];
}

- (BOOL)userHasEnoughPointsToBet
{
    return [self pointsFrom:_pointsTextField] <= [IBYAppState state].userPoints;
}

- (void)requestCreateBet
{
    [_createBetWebService requestCreateBetWithDescription:_betTextField.text
                                               challengee:_friendEmailTextField.text
                                                   points:_pointsTextField.text.integerValue];
}

- (NSInteger)pointsFrom:(id)object
{
    return [[object text] integerValue];
}

- (void)updatePoints
{
    _currentPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)[[IBYAppState state] userPoints]];
    NSInteger afterwardPoints = _currentUserPoints - [self pointsFrom:_pointsTextField];
    _afterwardsPointsLabel.text = [NSString stringWithFormat:@"%ld", (long)afterwardPoints];
}

- (void)resetFields
{
    _betTextField.text = @"";
    _friendEmailTextField.text = @"";
    _pointsTextField.text = @"";
}

@end