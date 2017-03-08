//
//  EMUtility.h
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EMUtility : NSObject

+(NSNumber *)getCurrentTime;
+(NSString *)saveImage:(UIImage *)image;
+(UIImage *)getImage:(NSString *)filePath;

@end
