//
//  IBYViewController.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBYViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (readwrite, nonatomic) BOOL autodismissKeyboard;

- (void)showProgressHUDWithText:(NSString *)text;
- (void)hideProgressHUD;
- (void)hideKeyboard;
- (void)showMessage:(NSString *)message color:(UIColor *)color;
- (void)clearMessage;

@end
