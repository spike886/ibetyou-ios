//
//  IBYUpdateBetWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYUpdateBetWebService.h"
#import "IBYAppState.h"
#import "IBYBet.h"

@implementation IBYUpdateBetWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYUpdateBetWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)updateBet:(IBYBet *)bet withCommand:(NSString *)command
{
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *path = @"/bet/";
    path = [path stringByAppendingString:[command stringByAppendingFormat:@"/%ld", (long)bet.betID]];
    [self.manager POST:[self URLStringWithPath:path]
            parameters:@{
                         @"token" : [IBYAppState state].loginToken
                         }
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [_delegate updateBetDidUpdate];
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [_delegate updateBetDidFailWithError:error];
              }];
}


@end
