//
//  EMAddUpdateVC.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

typedef enum {
    ADD = 0,
    UPDATE = 1
} LAUNCH_TYPE;

#import <UIKit/UIKit.h>
#import "EMEmployee.h"
#import "EMUtility.h"

@interface EMAddUpdateVC : UITableViewController 

@property (strong, nonatomic) NSNumber * launchType;
@property (strong, nonatomic) EMEmployee *employee;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIImageView *empImage;
@property (weak, nonatomic) IBOutlet UITextField *designation;
@property (weak, nonatomic) IBOutlet UITextField *dob;
@property (weak, nonatomic) IBOutlet UITextView *address;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *hobbies;
@property (nonatomic, strong) UIImagePickerController * imagePicker;

@end
