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

@interface EMEmpHomeVC () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) EMDataBaseManager * dbManager;
@property (strong, nonatomic) NSMutableArray * filteredArray;
- (void)setUpNavigation;

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
    self.empSearchBar.delegate = self;
    self.empList = [[NSMutableArray alloc] init];
    self.filteredArray = [[NSMutableArray alloc] init];
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
        self.empList = [NSMutableArray arrayWithArray:array];
        self.filteredArray = [NSMutableArray arrayWithArray:array];
        self.empCountLabel.text = [NSString stringWithFormat:@"%02lu",self.filteredArray.count];
        [self.empTableView reloadData];
    }];
    
    [self setUpNavigation];
}

- (void)setUpNavigation {

 
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                       NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18]
                                                                       }];
    
    [self.navigationController.navigationBar setBarTintColor: [UIColor blueColor]];
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    
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

- (IBAction)sortAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sort by"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * nameSort = [UIAlertAction actionWithTitle:@"Name"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          
          [self sortArray:@"name"];
      }];
    
    UIAlertAction * dobSort = [UIAlertAction actionWithTitle:@"DOB"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
          [self sortArray:@"dob"];
      }];
    
    UIAlertAction * designationSort = [UIAlertAction actionWithTitle:@"Designation"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
         [self sortArray:@"designation"];
      }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil];
    
    [alertController addAction:nameSort];
    [alertController addAction:dobSort];
    [alertController addAction:designationSort];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sortArray:(NSString *)sortParameter {

    NSSortDescriptor *descriptor;
    if ([sortParameter isEqualToString:@"name"]) {
    
        descriptor = [[NSSortDescriptor alloc] initWithKey:sortParameter
                                                 ascending:YES
                                                  selector:@selector(caseInsensitiveCompare:)];
    }
    else {
        descriptor = [[NSSortDescriptor alloc] initWithKey:sortParameter ascending:NO];
    }

    self.filteredArray = [NSMutableArray arrayWithArray:[self.empList sortedArrayUsingDescriptors:@[descriptor]]];
    [self.empTableView reloadData];
}

//============================================================================================================================================
#pragma mark : TABLE VIEW DELEGATES
//============================================================================================================================================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EMEmployeeCell * employeeCell = (EMEmployeeCell *)[tableView dequeueReusableCellWithIdentifier:@"EMEmployeeCell"];
    
    EMEmployee *employee = [self.filteredArray objectAtIndex:indexPath.row];
    
    employeeCell.empName.text = employee.name;
    employeeCell.empDate.text = [NSString stringWithFormat:@"%@", employee.dateAdded];
    employeeCell.empDate.text = [EMUtility getDateOfJoin:employee.dateAdded];
    employeeCell.gender.text = employee.gender;
    employeeCell.empDOB.text = [EMUtility getFormattedDOB:[EMUtility getDate:employee.dob]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        employeeCell.empImage.layer.cornerRadius = employeeCell.empImage.frame.size.width/2;
        employeeCell.empImage.layer.masksToBounds = YES;
        
        UIImage *image = employee.imageLink ? [EMUtility getImage:employee.imageLink] : [UIImage imageNamed:@"user_default.png"];
        [employeeCell.empImage setImage:image];
    });
    
    return employeeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EMDetailsVC * empDetailsVC = (EMDetailsVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMDetailsVC"];
    empDetailsVC.employee = [self.empList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:empDetailsVC animated:YES];
    [self.empSearchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        EMEmployee *employee = [self.filteredArray objectAtIndex:indexPath.row];
        [self.dbManager deleteEntity:employee.empId];
        [self.filteredArray removeObject:employee];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.empCountLabel.text = [NSString stringWithFormat:@"%02lu",self.filteredArray.count];
    }
    else
    {
        NSLog(@"Unhandled editing style! %ld", (long)editingStyle);
    }
}

//============================================================================================================================================
#pragma mark : UISearchDisplayBar DELEGATES
//============================================================================================================================================

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    dispatch_async(dispatch_get_main_queue(), ^{
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
        [self.filteredArray removeAllObjects];
        NSArray *searchArray = [self.empList filteredArrayUsingPredicate:predicate];
        [self.filteredArray addObjectsFromArray:searchArray];
    
        if (!searchText.length) {
            [self.filteredArray addObjectsFromArray:self.empList];
            [searchBar resignFirstResponder];
        }
        
        [self.empTableView reloadData];
    });
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"DID_END");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
