//
//  IBYCreateBetWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYCreateBetWebService.h"
#import "IBYAppState.h"

@implementation IBYCreateBetWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYCreateBetWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)requestCreateBetWithDescription:(NSString *)description challengee:(NSString *)challengee points:(NSInteger)points
{
    [self.manager POST:[self URLStringWithPath:@"/bet/new"]
            parameters:@{
                         @"description" : description,
                         @"challengee" : challengee,
                         @"points" : [NSString stringWithFormat:@"%ld", (long)points],
                         @"token" : [IBYAppState state].loginToken
                         }
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [_delegate createBetWebServiceDidCreateBet];
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [_delegate createBetWebServiceDidFailWithError:error];
               }];
}

@end