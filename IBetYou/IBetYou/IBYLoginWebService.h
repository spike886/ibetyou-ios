//
//  IBYLoginWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"

@protocol IBYLoginWebServiceDelegate <NSObject>
- (void)loginWebServiceDidCompleteLogin;
- (void)loginWebServiceDidFailWithError:(NSError *)error;
@end

@interface IBYLoginWebService : IBYWebService

@property (weak, nonatomic) id<IBYLoginWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYLoginWebServiceDelegate>)delegate;
- (void)loginWithEmail:(NSString *)email password:(NSString *)password;

@end
