//
//  EMEmpHomeVC.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMEmpHomeVC.h"
#import "EMEmployeeCell.h"
#import "EMEmployee.h"
#import "EMAddUpdateVC.h"
#import "EMDetailsVC.h"
#import "EMDataBaseManager.h"

@interface EMEmpHomeVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation EMEmpHomeVC


//============================================================================================================================================
#pragma mark : VIEW LIFE CYCLE
//============================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.empTableView.delegate = self;
    self.empTableView.dataSource = self;
    self.empList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================================================================================
#pragma mark : NAVIGATION BAR BUTTON ACTIONS
//============================================================================================================================================

- (IBAction)addEmployee:(id)sender {
    
    NSLog(@"ADDING EMPLOYEE TO LIST");
    
    EMEmployee *employee = [[EMEmployee alloc] init];
    employee.name = @"Abhishek";
    employee.gender = @"Male";
    [self.empList addObject:employee];
    [self.empTableView reloadData];
    
    EMDataBaseManager * dbManager = [[EMDataBaseManager alloc] init];
    [dbManager insertEntity:employee];
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    EMAddUpdateVC * empAddUpdateVC = (EMAddUpdateVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMAddUpdateVC"];
//    [self.navigationController pushViewController:empAddUpdateVC animated:YES];
}

- (IBAction)backAction:(id)sender {
    
    EMDataBaseManager * dbManager = [[EMDataBaseManager alloc] init];
    [dbManager fetchAllEntity];
}

//============================================================================================================================================
#pragma mark : TABLE VIEW DELEGATES
//============================================================================================================================================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.empList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EMEmployeeCell * employeeCell = (EMEmployeeCell *)[tableView dequeueReusableCellWithIdentifier:@"EMEmployeeCell"];
    
    EMEmployee *employee = [self.empList objectAtIndex:indexPath.row];
    
    employeeCell.empName.text = employee.name;
    employeeCell.empDate.text = [NSString stringWithFormat:@"%@", employee.dateAdded];
    employeeCell.gender.text = employee.gender;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        employeeCell.empImage.layer.cornerRadius = employeeCell.empImage.frame.size.width/2;
        employeeCell.empImage.layer.masksToBounds = YES;
    });
    
    return employeeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EMDetailsVC * empDetailsVC = (EMDetailsVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMDetailsVC"];
    [self.navigationController pushViewController:empDetailsVC animated:YES];
}

@end
