//
//  IBYBet.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYBet.h"
#import "IBYAppState.h"

@implementation IBYBet

#pragma mark - Class

+ (IBYBetStatus)statusWithString:(NSString *)string
{
    IBYBetStatus status = IBYBetStatusNoStatus;
    
    if ([string isEqualToString:@"new"])
    {
        status = IBYBetStatusNew;
    }
    else if ([string isEqualToString:@"accepted"])
    {
        status = IBYBetStatusAccepted;
    }
    else if ([string isEqualToString:@"rejected"])
    {
        status = IBYBetStatusRejected;
    }
    else if ([string isEqualToString:@"won"])
    {
        status = IBYBetStatusWon;
    }
    else if ([string isEqualToString:@"lost"])
    {
        status = IBYBetStatusLost;
    }
    
    return status;
}

+ (NSString *)stringWithStatus:(IBYBetStatus)status
{
    NSString *string = nil;
    switch (status)
    {
        case IBYBetStatusNoStatus:  string = @"no status"; break;
        case IBYBetStatusNew:       string = @"Waiting..."; break;
        case IBYBetStatusAccepted:  string = @"Accepted"; break;
        case IBYBetStatusRejected:  string = @"Rejected"; break;
        case IBYBetStatusWon:       string = @"Won"; break;
        case IBYBetStatusLost:      string = @"Lost"; break;
    }
    return string;
}

+ (UIImage *)imageForStatus:(IBYBetStatus)status
{
    NSString *imageName = nil;
    switch (status)
    {
        case IBYBetStatusNew:
            imageName = @"hand";
            break;
        case IBYBetStatusAccepted:
            imageName = @"handshake";
            break;
        case IBYBetStatusRejected:
            imageName = @"x";
            break;
        case IBYBetStatusWon:
            imageName = @"thumbsup";
            break;
        case IBYBetStatusLost:
            imageName = @"thumbsdown";
            break;
        case IBYBetStatusNoStatus:
            imageName = @"";
            break;
    }
    return [UIImage imageNamed:imageName];
}

#pragma mark - Public

- (NSString *)opponentEmail
{
    if ([self userIsOwner])
    {
        return self.challengee;
    }
    return self.challenger;
}

#pragma mark - Private

- (BOOL)userIsOwner
{
    return [_challenger isEqualToString:[IBYAppState state].userEmail];
}

@end
