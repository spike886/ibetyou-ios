//
//  IBYUser.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBYUser : NSObject

@property (strong, nonatomic) NSString *email;
@property (readwrite, nonatomic) NSInteger won;
@property (readwrite, nonatomic) NSInteger lost;

@end
