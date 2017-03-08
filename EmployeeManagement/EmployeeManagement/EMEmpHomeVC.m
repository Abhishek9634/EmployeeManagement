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
@property (strong, nonatomic) NSMutableArray * empName;

@end

@implementation EMEmpHomeVC
{
    NSArray *searchResults;
    NSArray *searchObjects;
}

//============================================================================================================================================
#pragma mark : VIEW LIFE CYCLE
//============================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.empTableView.delegate = self;
    self.empTableView.dataSource = self;
    self.empList = [[NSMutableArray alloc] init];
    self.empName = [[NSMutableArray alloc] init];
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
        [self.empName removeAllObjects];
    }
    
    [self.dbManager fetchAllEntityWithCompletion:^(NSMutableArray *array, NSMutableArray * empNameList) {
        self.empList = array;
        self.empName = empNameList;
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    return self.empList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EMEmployeeCell * employeeCell = (EMEmployeeCell *)[tableView dequeueReusableCellWithIdentifier:@"EMEmployeeCell"];
    
    EMEmployee *employee = [self.empList objectAtIndex:indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        if(employeeCell == nil)
        {
            employeeCell = [[EMEmployeeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EMEmployeeCell"];
        }
        
        employeeCell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        employeeCell.empName.text = employee.name;
        employeeCell.empDate.text = [NSString stringWithFormat:@"%@", employee.dateAdded];
        employeeCell.gender.text = employee.gender;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            employeeCell.empImage.layer.cornerRadius = employeeCell.empImage.frame.size.width/2;
            employeeCell.empImage.layer.masksToBounds = YES;
        });
    }
    
    return employeeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EMDetailsVC * empDetailsVC = (EMDetailsVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMDetailsVC"];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
//        empDetailsVC.employee = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        empDetailsVC.employee = [self.empList objectAtIndex:indexPath.row];
    }
//    [self.navigationController pushViewController:empDetailsVC animated:YES];
}

//============================================================================================================================================
#pragma mark : UISearchDisplayController DELEGATES
//============================================================================================================================================

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    searchResults = [[self.empName filteredArrayUsingPredicate:resultPredicate] mutableCopy];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

@end
