//
//  IBYMyBetsWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"
#import "IBYBet.h"

@class IBYBet;

@protocol IBYMyBetsWebServiceDelegate <NSObject>
- (void)myBetsWebServiceDidFinishWithBets:(NSArray *)bets;
- (void)myBetsWebServiceDidFailWithError:(NSError *)error;
@end

@interface IBYMyBetsWebService : IBYWebService

@property (weak, nonatomic) id<IBYMyBetsWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYMyBetsWebServiceDelegate>)delegate;
- (void)requestMyBets;

@end
