//
//  IBYUpdateBetWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"

@class IBYBet;

@protocol IBYUpdateBetWebServiceDelegate <NSObject>
- (void)updateBetDidUpdate;
- (void)updateBetDidFailWithError:(NSError *)error;
@end

@interface IBYUpdateBetWebService : IBYWebService

@property (weak, nonatomic) id<IBYUpdateBetWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYUpdateBetWebServiceDelegate>)delegate;
- (void)updateBet:(IBYBet *)bet withCommand:(NSString *)command;

@end
