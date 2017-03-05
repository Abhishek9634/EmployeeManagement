//
//  Employee.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Employee : NSManagedObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *dob;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSNumber *dateAdded;
@property (nullable, nonatomic, copy) NSString *imageLink;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *designation;
@property (nullable, nonatomic, copy) NSString *hobbies;

@end
