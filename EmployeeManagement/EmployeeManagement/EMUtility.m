//
//  EMUtility.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMUtility.h"

@implementation EMUtility

+(NSNumber *)getCurrentTime {
    return [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] * 1000];
}

@end
