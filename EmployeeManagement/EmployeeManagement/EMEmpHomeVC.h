//
//  EMEmpHomeVC.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMEmpHomeVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *empTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *empSearchBar;
@property (strong, nonatomic) NSMutableArray * empList;

- (IBAction)addEmployee:(id)sender;
- (IBAction)backAction:(id)sender;

@end
