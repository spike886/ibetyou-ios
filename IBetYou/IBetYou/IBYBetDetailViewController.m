//
//  IBYBetDetailViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYBetDetailViewController.h"
#import "IBYBet.h"
#import "IBYUpdateBetWebService.h"

@interface IBYBetDetailViewController () <IBYUpdateBetWebServiceDelegate>

@property (strong, nonatomic) IBOutlet UILabel *challengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *challengeeLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointsOnTableLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBYUpdateBetWebService *updateBetWebService;
@property (strong, nonatomic) IBYBet *bet;

@end

@implementation IBYBetDetailViewController

#pragma mark - Lifecycle

- (id)initWithBet:(IBYBet *)bet
{
    self = [super init];
    if (self)
    {
        self.title = @"Bet Details";
        _bet = bet;
        _updateBetWebService = [[IBYUpdateBetWebService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

#pragma mark - IBAction

- (IBAction)acceptButtonPressed:(id)sender
{
    [self requestUpdateBetWithCommand:@"accept"];
}

- (IBAction)rejectButtonPressed:(id)sender
{
    [self requestUpdateBetWithCommand:@"reject"];
}

- (IBAction)wonButtonPressed:(id)sender
{
    [self requestUpdateBetWithCommand:@"won"];
}

- (IBAction)lostButtonPressed:(id)sender
{
    [self requestUpdateBetWithCommand:@"lost"];
}

#pragma mark - IBYUpdateBetWebServiceDelegate

- (void)updateBetDidUpdate
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bet updated!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateBetDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not update bet" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private

- (void)updateUI
{
    _challengerLabel.text = _bet.challenger;
    _challengeeLabel.text = _bet.challengee;
    _descriptionLabel.text = _bet.description;
    _statusLabel.text = [IBYBet stringWithStatus:_bet.status];
    _pointsOnTableLabel.text = [NSString stringWithFormat:@"%ld", (long)_bet.points];
}

- (void)requestUpdateBetWithCommand:(NSString *)command
{
    [self showProgressHUDWithText:@"Updating bet..."];
    [_updateBetWebService updateBet:_bet withCommand:command];
}

@end
