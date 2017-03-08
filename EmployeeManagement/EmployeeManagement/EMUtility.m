//
//  EMUtility.m
//  EmployeeManagement
//
//  Created by Abhishek Thapliyal on 3/5/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

#import "EMUtility.h"

@implementation EMUtility

+(NSNumber *)getCurrentTime {
    return [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] * 1000];
}

+(NSString *)saveImage:(UIImage *)image
{
    NSString * docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * timestamp = [NSString stringWithFormat:@"IMG_%f.jpg",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString * filePath = [docDirPath stringByAppendingPathComponent:timestamp];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}

+(UIImage *)getImage:(NSString *)filePath
{
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * mainPath = [docDir stringByAppendingPathComponent:[filePath lastPathComponent]];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:mainPath]];
    UIImage *image = [UIImage imageWithContentsOfFile:mainPath];
    return image;
}

@end
