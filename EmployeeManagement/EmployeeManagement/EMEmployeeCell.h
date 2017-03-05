//
//  EMEmployeeCell.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMEmployeeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *empImage;
@property (weak, nonatomic) IBOutlet UILabel *empName;
@property (weak, nonatomic) IBOutlet UILabel *empDate;
@property (weak, nonatomic) IBOutlet UILabel *empDOB;
@property (weak, nonatomic) IBOutlet UILabel *gender;

@end
