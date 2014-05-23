//
//  IBYMyCurrentBetsViewController.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYMyCurrentBetsViewController.h"
#import "IBYMyBetsWebService.h"
#import "IBYBetCell.h"
#import "IBYBetDetailViewController.h"

@interface IBYMyCurrentBetsViewController () <IBYMyBetsWebServiceDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBYMyBetsWebService *myBetsWebService;
@property (strong, nonatomic) NSArray *myBets;

@end

@implementation IBYMyCurrentBetsViewController

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"My Current Bets";
        _myBetsWebService = [[IBYMyBetsWebService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showProgressHUDWithText:@"Loading..."];
    [_myBetsWebService requestMyBets];
}

#pragma mark - IBYMyBetsWebServiceDelegate

- (void)myBetsWebServiceDidFinishWithBets:(NSArray *)bets
{
    [self hideProgressHUD];
    _myBets = bets;
    [_tableView reloadData];
}

- (void)myBetsWebServiceDidFailWithError:(NSError *)error
{
    [self hideProgressHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not retrieve data" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myBets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBYBetCell *cell = [tableView dequeueReusableCellWithIdentifier:IBYBetCellIdentifier];
    if (!cell)
    {
        cell = [IBYBetCell cell];
    }
    cell.bet = [self betAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    IBYBet *bet = [self betAtIndexPath:indexPath];
    IBYBetDetailViewController *controller = [[IBYBetDetailViewController alloc] initWithBet:bet];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private

- (IBYBet *)betAtIndexPath:(NSIndexPath *)indexPath
{
    return _myBets[indexPath.row];
}

@end
