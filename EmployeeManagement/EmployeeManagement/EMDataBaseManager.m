//
//  EMDataBaseManager.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMDataBaseManager.h"
#import "EMDBHandler.h"
#import "Employee.h"

@implementation EMDataBaseManager

-(void)insertEntity:(EMEmployee *)employee {
    
    EMDBHandler * dbHandler = [EMDBHandler sharedManager];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee"
                                              inManagedObjectContext:dbHandler.persistentContainer.viewContext];
    
    Employee *dbEmployee = [[Employee alloc] initWithEntity:entity
                             insertIntoManagedObjectContext:dbHandler.persistentContainer.viewContext];
    
    dbEmployee.name = employee.name;
    dbEmployee.dob = employee.dob;
    dbEmployee.gender = employee.gender;
    dbEmployee.imageLink = employee.imageLink;
    dbEmployee.dateAdded = employee.dateAdded;
    dbEmployee.designation = employee.designation;
    dbEmployee.address = employee.address;
    dbEmployee.hobbies = employee.hobbies;
    
    NSError *error = nil;
    [dbHandler.persistentContainer.viewContext save:&error];
    NSLog(@"INSERT ENTITY ERROR(IF_ANY) : %@", error.description);
}

-(NSMutableArray *)fetchAllEntity {
    
    NSMutableArray * employeeList = [[NSMutableArray alloc] init];
    EMDBHandler * dbHandler = [EMDBHandler sharedManager];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSError *error = nil;
    NSArray *results = [dbHandler.persistentContainer.viewContext executeFetchRequest:request error:&error];
    NSLog(@"FETCH ENTITY ERROR(IF_ANY) : %@ && COUNT : %lu", error.description, results.count);
    
    for (Employee *dbEmployee in results) {
    
        EMEmployee *employee = [[EMEmployee alloc] init];
        employee.name = dbEmployee.name;
        employee.dob = dbEmployee.dob;
        employee.gender = dbEmployee.gender;
        employee.imageLink = dbEmployee.imageLink;
        employee.dateAdded = dbEmployee.dateAdded;
        employee.designation = dbEmployee.designation;
        employee.address = dbEmployee.address;
        employee.hobbies = dbEmployee.hobbies;
        
        [employeeList addObject:employee];
    }

    return employeeList;
}

@end
