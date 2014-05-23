//
//  IBYJSONRequestSerializer.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYJSONRequestSerializer.h"

@implementation IBYJSONRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *mutableRequest = [[super requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return mutableRequest;
}

@end
