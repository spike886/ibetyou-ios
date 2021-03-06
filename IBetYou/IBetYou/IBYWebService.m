//
//  IBYWebService.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYWebService.h"
#import "IBYJSONRequestSerializer.h"

NSString *const IBYWebServiceBaseURLString = @"http://192.168.1.30:4567";

@implementation IBYWebService

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _manager = [AFHTTPRequestOperationManager manager];
//        IBYJSONRequestSerializer *serializer = [[IBYJSONRequestSerializer alloc] init];
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Public

- (NSString *)URLStringWithPath:(NSString *)path
{
    return [IBYWebServiceBaseURLString stringByAppendingString:path];
}

@end
