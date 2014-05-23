//
//  IBYLoginWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYLoginWebService.h"

@interface IBYLoginWebService ()

@end

@implementation IBYLoginWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYLoginWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
    [self.manager POST:[self URLStringWithPath:@"/login"]
            parameters:@{@"email" : email, @"password" : password}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [_delegate loginWebServiceDidCompleteLogin];
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if (operation.response.statusCode == 403)
                   {
                       NSError *loginError = [NSError errorWithDomain:@"Login domain"
                                                                 code:403
                                                             userInfo:@{NSLocalizedDescriptionKey : @"Invalid username/password"}];
                       [_delegate loginWebServiceDidFailWithError:loginError];
                   }
                   else
                   {
                       [_delegate loginWebServiceDidFailWithError:error];
                   }
               }];
}

@end
