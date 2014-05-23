//
//  IBYBetCell.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYBetCell.h"
#import "IBYBet.h"

NSString *const IBYBetCellIdentifier = @"BetCell";

@interface IBYBetCell ()

@property (strong, nonatomic) IBOutlet UIImageView *statusImageView;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation IBYBetCell

#pragma mark - Class

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"IBYBetCell" owner:nil options:nil] firstObject];
}

#pragma mark - Accessors

- (void)setBet:(IBYBet *)bet
{
    _bet = bet;
    
    _emailLabel.text = [bet opponentEmail];
    _descriptionLabel.text = [bet description];
    _statusImageView.image = [IBYBet imageForStatus:bet.status];
}

@end
