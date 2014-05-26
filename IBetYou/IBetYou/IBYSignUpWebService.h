//
//  IBYSignUpWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"

@protocol IBYSignUpWebServiceDelegate <NSObject>
- (void)signUpWebServiceDidCompleteSignUp;
- (void)signUpWebServiceDidFailWithError:(NSError *)error;
@end

@interface IBYSignUpWebService : IBYWebService

@property (weak, nonatomic) id<IBYSignUpWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYSignUpWebServiceDelegate>)delegate;
- (void)signUpWithEmail:(NSString *)email password:(NSString *)password;

@end
