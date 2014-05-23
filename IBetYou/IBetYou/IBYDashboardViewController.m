//
//  IBYDashboardViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYDashboardViewController.h"
#import "IBYDashboardWebService.h"
#import "IBYAppState.h"

@interface IBYDashboardViewController () <IBYDashboardWebServiceDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointsOnTableLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBYDashboardWebService *dashboardWebService;

@end

@implementation IBYDashboardViewController

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"Dashboard";
        _dashboardWebService = [[IBYDashboardWebService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _contentView.hidden = YES;
    
    [self showProgressHUDWithText:@"Loading data..."];
    [_dashboardWebService requestDashboard];
}

#pragma mark - IBAction

- (IBAction)logoutButtonPressed:(id)sender
{
    [[IBYAppState state] setLoginToken:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBYDashboardWebServiceDelegate

- (void)dashboardWebServiceDidFinishWithLoggedUser:(IBYLoggedUser *)loggedUser users:(NSArray *)users
{
    [self hideProgressHUD];
    [self updateUIWithLoggedUser:loggedUser];
}

- (void)dashboardWebServiceDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not retrieve data" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private

- (void)updateUIWithLoggedUser:(IBYLoggedUser *)loggedUser
{
    _pointsLabel.text = [NSString stringWithFormat:@"%ld", (long)loggedUser.points];
    _pointsOnTableLabel.text = [NSString stringWithFormat:@"%ld", (long)loggedUser.pointsOnTable];
    _userEmailLabel.text = loggedUser.email;
    
    _contentView.hidden = NO;
}

@end
