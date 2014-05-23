//
//  IBYBet.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IBYBetStatus)
{
    IBYBetStatusNoStatus,
    IBYBetStatusNew,
    IBYBetStatusAccepted,
    IBYBetStatusRejected,
    IBYBetStatusWon,
    IBYBetStatusLost
};

@interface IBYBet : NSObject

@property (readwrite, nonatomic) NSInteger betID;
@property (readwrite, nonatomic) NSInteger points;
@property (readwrite, nonatomic) IBYBetStatus status;
@property (strong, nonatomic) NSString *challenger;
@property (strong, nonatomic) NSString *challengee;
@property (strong, nonatomic) NSString *description;

+ (IBYBetStatus)statusWithString:(NSString *)string;
+ (UIImage *)imageForStatus:(IBYBetStatus)status;

+ (NSString *)stringWithStatus:(IBYBetStatus)status;
- (NSString *)opponentEmail;

@end
