//
//  EMDetailsVC.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMEmployee.h"

@interface EMDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *empImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *hobbies;

@property (strong, nonatomic) EMEmployee *employee;

@end
