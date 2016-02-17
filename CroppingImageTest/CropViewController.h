//
//  CropViewController.h
//  CroppingImageTest
//
//  Created by Netease on 16/2/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationView.h"

@interface CropViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet AnimationView *animationView;
@property (weak, nonatomic) IBOutlet UIImageView *cropImageView;

@end
