//
//  IBYAppState.m
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYAppState.h"

NSString *const LoginTokenKey = @"login_token";
NSString *const UserEmailKey = @"user_email";
NSString *const UserPointsKey = @"user_points";

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
        self.loginToken = [_userDefaults objectForKey:LoginTokenKey];
        self.userPoints = [[_userDefaults objectForKey:UserPointsKey] integerValue];
        self.userEmail = [_userDefaults objectForKey:UserEmailKey];
    }
    return self;
}

#pragma mark - Accessors

- (void)setLoginToken:(NSString *)loginToken
{
    _loginToken = loginToken;
    [_userDefaults setObject:loginToken forKey:LoginTokenKey];
}

- (void)setUserEmail:(NSString *)userEmail
{
    _userEmail = userEmail;
    [_userDefaults setObject:userEmail forKey:UserEmailKey];
}

- (void)setUserPoints:(NSInteger)userPoints
{
    _userPoints = userPoints;
    [_userDefaults setObject:@(userPoints) forKey:UserPointsKey];
}

@end
