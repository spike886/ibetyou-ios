//
//  IBYLoggedUser.h
//  IBetYou
//
//  Created by Pablo Villar on 5/23/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IBYUser.h"

@interface IBYLoggedUser : IBYUser

@property (readwrite, nonatomic) NSInteger points;
@property (readwrite, nonatomic) NSInteger pointsOnTable;

@end
