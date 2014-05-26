//
//  IBYDashboardWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"
#import "IBYLoggedUser.h"

@protocol IBYDashboardWebServiceDelegate <NSObject>
- (void)dashboardWebServiceDidFinishWithLoggedUser:(IBYLoggedUser *)loggedUser users:(NSArray *)users;
- (void)dashboardWebServiceDidFailWithError:(NSError *)error;
@end

@interface IBYDashboardWebService : IBYWebService

@property (weak, nonatomic) id<IBYDashboardWebServiceDelegate> delegate;

- (id)initWithDelegate:(id<IBYDashboardWebServiceDelegate>)delegate;
- (void)requestDashboard;

@end
