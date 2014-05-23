//
//  IBYMyBetsWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYMyBetsWebService.h"
#import "IBYAppState.h"

@implementation IBYMyBetsWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYMyBetsWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)requestMyBets
{
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager GET:[self URLStringWithPath:@"/bet/mine"]
           parameters:@{
                        @"token" : [IBYAppState state].loginToken
                        }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSArray *result = responseObject[@"result"];
                  NSMutableArray *bets = [NSMutableArray array];
                  
                  for (NSDictionary *dictionary in result)
                  {
                      IBYBet *bet = [[IBYBet alloc] init];
                      bet.betID = [dictionary[@"id"] integerValue];
                      bet.points = [dictionary[@"points"] integerValue];
                      bet.status = [IBYBet statusWithString:dictionary[@"status"]];
                      bet.challenger = dictionary[@"challenger"];
                      bet.challengee = dictionary[@"challengee"];
                      bet.description = dictionary[@"description"];
                      [bets addObject:bet];
                  }
                  
                  [_delegate myBetsWebServiceDidFinishWithBets:bets];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [_delegate myBetsWebServiceDidFailWithError:error];
              }];
}


@end
