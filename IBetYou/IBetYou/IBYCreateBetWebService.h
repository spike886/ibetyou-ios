//
//  IBYCreateBetWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"

@protocol IBYCreateBetWebServiceDelegate <NSObject>
- (void)createBetWebServiceDidCreateBet;
- (void)createBetWebServiceDidFailWithError:(NSError *)error;
@end

@interface IBYCreateBetWebService : IBYWebService

@property (weak, nonatomic) id<IBYCreateBetWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYCreateBetWebServiceDelegate>)delegate;
- (void)requestCreateBetWithDescription:(NSString *)description challengee:(NSString *)challengee points:(NSInteger)points;

@end
