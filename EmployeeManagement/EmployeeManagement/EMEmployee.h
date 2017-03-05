//
//  EMEmployee.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMEmployee : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *dob;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSNumber *dateAdded;
@property (nonatomic, strong) NSString *imageLink;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *designation;
@property (nonatomic, strong) NSString *hobbies;

@end
