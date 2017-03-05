//
//  EMDataBaseManager.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMEmployee.h"

@interface EMDataBaseManager : NSObject

-(void)insertEntity:(EMEmployee *)employee;
-(NSMutableArray *)fetchAllEntity;

@end
