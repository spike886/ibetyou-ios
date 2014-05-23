//
//  IBYBetCell.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBYBet;

@interface IBYBetCell : UITableViewCell

extern NSString *const IBYBetCellIdentifier;

@property (strong, nonatomic) IBYBet *bet;

+ (instancetype)cell;

@end
