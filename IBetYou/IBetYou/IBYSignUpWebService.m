//
//  IBYSignUpWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYSignUpWebService.h"

@interface IBYSignUpWebService ()

@end

@implementation IBYSignUpWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYSignUpWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password
{
    [self.manager POST:[self URLStringWithPath:@"/signup"]
            parameters:@{@"email" : email, @"password" : password}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [_delegate signUpWebServiceDidCompleteSignUp];
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if (operation.response.statusCode == 403)
                   {
                       NSError *signUpError = [NSError errorWithDomain:@"SignUp domain"
                                                                  code:403
                                                              userInfo:@{NSLocalizedDescriptionKey : @"Email is already registered.\nTry with another email."}];
                       [_delegate signUpWebServiceDidFailWithError:signUpError];
                   }
                   else
                   {
                       [_delegate signUpWebServiceDidFailWithError:error];
                   }
               }];
}

@end
