//
//  EMDetailsVC.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMDetailsVC.h"
#import "EMAddUpdateVC.h"

@interface EMDetailsVC ()

@property (strong, nonatomic) UIBarButtonItem * submitButton;

@end

@implementation EMDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.empImage.layer.cornerRadius = self.empImage.frame.size.width/2;
        self.empImage.layer.masksToBounds = YES;
    });
    
    self.submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(updateAction)];
    
    [self.navigationItem setRightBarButtonItem:self.submitButton];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
//    self.empImage.image = nil;
    self.name.text = self.employee.name;
    self.dob.text = [NSString stringWithFormat:@"%@", self.employee.dob];
    self.address.text = self.employee.address;
    self.gender.text = self.employee.gender;
    self.hobbies.text = self.employee.hobbies;
    
    UIImage *image = self.employee.imageLink ? [EMUtility getImage:self.employee.imageLink] : [UIImage imageNamed:@"user_default.png"];
    [self.empImage setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateAction {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EMAddUpdateVC * empAddUpdateVC = (EMAddUpdateVC *)[storyBoard instantiateViewControllerWithIdentifier:@"EMAddUpdateVC"];
    empAddUpdateVC.launchType = [NSNumber numberWithInt:UPDATE];
    empAddUpdateVC.employee = self.employee;
    [self.navigationController pushViewController:empAddUpdateVC animated:YES];
}

@end
