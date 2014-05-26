//
//  IBYTabBarController.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IBYTabBarTabName)
{
    IBYTabBarMyCurrentBetsTab   = 0,
    IBYTabBarScoreboardTab      = 1,
    IBYTabBarCreateBetTab       = 2
};

@interface IBYTabBarController : UITabBarController

@end
