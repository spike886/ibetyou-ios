//
//  IBYSignUpViewController.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYViewController.h"

@protocol IBYSignUpViewControllerDelegate <NSObject>
- (void)signUpViewControllerDidSignUpWithEmail:(NSString *)email password:(NSString *)password;
@end

@interface IBYSignUpViewController : IBYViewController

@property (weak, nonatomic) id<IBYSignUpViewControllerDelegate> delegate;

- (id)initWithDelegate:(id<IBYSignUpViewControllerDelegate>)delegate;

@end
