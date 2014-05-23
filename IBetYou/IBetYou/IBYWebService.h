//
//  IBYWebService.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface IBYWebService : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

- (NSString *)URLStringWithPath:(NSString *)path;

@end
