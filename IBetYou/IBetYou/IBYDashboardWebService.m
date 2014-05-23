 //
//  IBYDashboardWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYDashboardWebService.h"
#import "IBYAppState.h"

@implementation IBYDashboardWebService

#pragma mark - Lifecycle

- (id)initWithDelegate:(id<IBYDashboardWebServiceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)requestDashboard
{
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager GET:[self URLStringWithPath:@"/dashboard"]
           parameters:@{
                        @"token" : [IBYAppState state].loginToken
                        }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  //{"result":{"points":"90","users":[{"email":"pablo","won":1},{"email":"email@domain.com","lost":1}]}}
                  
                  NSDictionary *result = responseObject[@"result"];

                  IBYLoggedUser *loggedUser = [[IBYLoggedUser alloc] init];
                  loggedUser.points = [result[@"points"] integerValue];
                  loggedUser.pointsOnTable = [result[@"points_on_table"] integerValue];
                  loggedUser.email = [[IBYAppState state] userEmail];
                  // TODO: Crazy Parsing
//                  NSMutableArray *users = [NSMutableArray array];
//                  NSMutableDictionary *usersDictionary = [NSMutableDictionary dictionary];
//                  
//                  for (NSDictionary *userBeingParsed in result[@"users"])
//                  {
//                      NSString *email = userBeingParsed[@"email"];
//                     
//                      if ([[usersDictionary allKeys] containsObject:email])
//                      {
//                          NSDictionary *user = usersDictionary[email];
//                      }
//                  }
                  
                  [_delegate dashboardWebServiceDidFinishWithLoggedUser:loggedUser users:nil];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [_delegate dashboardWebServiceDidFailWithError:error];
              }];
}

@end
