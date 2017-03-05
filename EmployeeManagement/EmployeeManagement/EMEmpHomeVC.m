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
#import "EMUtility.h"

@interface EMEmpHomeVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) EMDataBaseManager * dbManager;

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
    self.dbManager = [[EMDataBaseManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.empList.count) {
        [self.empList removeAllObjects];
    }
    
    [self.dbManager fetchAllEntityWithCompletion:^(NSMutableArray *array) {
        self.empList = array;
        [self.empTableView reloadData];
    }];
}

//============================================================================================================================================
#pragma mark : NAVIGATION BAR BUTTON ACTIONS
//============================================================================================================================================

- (IBAction)addEmployee:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EMAddUpdateVC * empAddUpdateVC = (EMAddUpdateVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMAddUpdateVC"];
    empAddUpdateVC.launchType = [NSNumber numberWithInt:ADD];
    [self.navigationController pushViewController:empAddUpdateVC animated:YES];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    empDetailsVC.employee = [self.empList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:empDetailsVC animated:YES];
}

@end
