//
//  EMAddUpdateVC.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMAddUpdateVC.h"
#import "EMDataBaseManager.h"

@interface EMAddUpdateVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIBarButtonItem * submitButton;
@property (strong, nonatomic) EMDataBaseManager * dbManager;

@end

@implementation EMAddUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(submitAction)];
    
    [self.navigationItem setRightBarButtonItem:self.submitButton];
    self.dbManager = [[EMDataBaseManager alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if ([self.launchType isEqualToNumber:[NSNumber numberWithInt:UPDATE]]) {
        
        self.name.text = self.employee.name;
        self.gender.text = self.employee.gender;
        self.dob.text = [self.employee.dob stringValue];
        self.hobbies.text = self.employee.hobbies;
        self.designation.text = self.employee.designation;
    //        self.empImage.image =  NEED TO CHECK //self.employee.imageLink;
    }
}

-(void)submitAction {
    
    if ([self.launchType isEqualToNumber:[NSNumber numberWithInt:ADD]]) {
    
        self.employee = [[EMEmployee alloc] init];
        self.employee.name = self.name.text;
        self.employee.gender = self.gender.text;
        self.employee.dob = [NSNumber numberWithInt:[self.dob.text intValue]];
        self.employee.hobbies = self.hobbies.text;
        self.employee.designation = self.designation.text;
//        self.employee.imageLink = @""                         // NEED TO CHECK
        self.employee.empId = [NSString stringWithFormat:@"EMP_%@", [EMUtility getCurrentTime]];

        [self.dbManager insertEntity:self.employee];
    }
    else {
        
        self.employee.name = self.name.text;
        self.employee.gender = self.gender.text;
        self.employee.dob = [NSNumber numberWithInt:[self.dob.text intValue]];
        self.employee.hobbies = self.hobbies.text;
        self.employee.designation = self.designation.text;
        //        self.employee.imageLink = @""                 // NEED TO CHECK
        [self.dbManager updateEntity:self.employee];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 0;
}
 
*/ 

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
