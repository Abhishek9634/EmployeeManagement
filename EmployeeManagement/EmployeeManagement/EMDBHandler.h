//
//  EMDBHandler.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EMDBHandler : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
-(void)saveContext;
+ (instancetype)sharedManager;

@end
