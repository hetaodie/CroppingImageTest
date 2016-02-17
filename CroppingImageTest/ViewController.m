//
//  ViewController.m
//  CroppingImageTest
//
//  Created by Netease on 16/2/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+XG.h"
#import "CropViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)btnBegin:(id)sender {
    CropViewController *vc = [[CropViewController alloc] initWithNibName:@"CropViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
}

//
//- (UIImage*) createImageWithColor:(UIColor*) color
//{
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}

@end
