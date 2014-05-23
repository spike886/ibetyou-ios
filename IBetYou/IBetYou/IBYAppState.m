//
//  IBYAppState.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYAppState.h"

NSString *const LoginTokenKey = @"login_token";

@interface IBYAppState ()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end

@implementation IBYAppState

#pragma mark - Singleton

+ (instancetype)state
{
    static IBYAppState *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _loginToken = [_userDefaults objectForKey:LoginTokenKey];
    }
    return self;
}

#pragma mark - Accessors

- (void)setLoginToken:(NSString *)loginToken
{
    _loginToken = loginToken;
    [_userDefaults setObject:loginToken forKey:LoginTokenKey];
}

@end
