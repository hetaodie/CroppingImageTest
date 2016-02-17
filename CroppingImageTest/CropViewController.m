//
//  CropViewController.m
//  CroppingImageTest
//
//  Created by Netease on 16/2/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CropViewController.h"
#import "UIImage+Crop.h"

@interface CropViewController () <AnimationDelegate>
@property (nonatomic,strong) NSMutableArray *points;
@end

@implementation CropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *showIconImage = [UIImage imageNamed:@"test.jpg"];
    self.imageView.image = showIconImage;
    self.animationView.animationType = AnimationTypeOfRect;
    _points = [[NSMutableArray alloc] init];
    self.animationView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bthRect:(id)sender {
        self.animationView.animationType = AnimationTypeOfRect;
}
- (IBAction)btnEllipse:(id)sender {
        self.animationView.animationType = AnimationTypeOfEllipse;
}
- (IBAction)btnDonut:(id)sender {
        self.animationView.animationType = AnimationTypeOfEOEllipse;
}
- (IBAction)btnPath:(id)sender {
        self.animationView.animationType = AnimationTypeOfLines;
}

- (IBAction)btnCrop:(id)sender {
    if ([self.points count]==0) {
        return;
    }
    
    switch (self.animationView.animationType) {
        case AnimationTypeOfRect: {
            
            CGPoint point0 = [[self.points objectAtIndex:0] CGPointValue];
            CGPoint point1 = [[self.points objectAtIndex:1] CGPointValue];
            
            

            
            UIImage *image = self.imageView.image;
            CGFloat scaleH = image.size.height/self.animationView.frame.size.height;
            CGFloat scaleW = image.size.width/self.animationView.frame.size.width;
            
            CGRect currentRect = CGRectMake (
                                             (point0.x > point1.x) ? point1.x * scaleW : point0.x * scaleW,
                                             (point0.y > point1.y) ? point1.y * scaleH: point0.y * scaleH,
                                             fabs(point0.x - point1.x)* scaleW,
                                             fabs(point0.y - point1.y)*scaleH);
//            CGRect frame = CGRectMake(300, 200, image.size.width/3, image.size.height/3);
            UIImage *cropImage = [UIImage imageWithImage:image CropRectInRect:currentRect];
            self.cropImageView.image = cropImage;
            break;
        }
        case AnimationTypeOfEllipse: {
            
            CGPoint point0 = [[self.points objectAtIndex:0] CGPointValue];
            CGPoint point1 = [[self.points objectAtIndex:1] CGPointValue];
            
            
            UIImage *image = self.imageView.image;
//            CGRect frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
            CGFloat scaleH = image.size.height/self.animationView.frame.size.height;
            CGFloat scaleW = image.size.width/self.animationView.frame.size.width;
            
            CGRect currentRect = CGRectMake (
                                             (point0.x > point1.x) ? point1.x * scaleW : point0.x * scaleW,
                                             (point0.y > point1.y) ? point1.y * scaleH: point0.y * scaleH,
                                             fabs(point0.x - point1.x)* scaleW,
                                             fabs(point0.y - point1.y)*scaleH);
            
            UIImage *cropImage = [UIImage imageWithImage:image CropEllipseInRect:currentRect];
            self.cropImageView.image = cropImage;
            break;
        }
        case AnimationTypeOfEOEllipse: {
            CGPoint point0 = [[self.points objectAtIndex:0] CGPointValue];
            CGPoint point1 = [[self.points objectAtIndex:1] CGPointValue];
            
            
            UIImage *image = self.imageView.image;
            //            CGRect frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
            CGFloat scaleH = image.size.height/self.animationView.frame.size.height;
            CGFloat scaleW = image.size.width/self.animationView.frame.size.width;
            CGFloat wRadius =  fabs(point0.x - point1.x)* scaleW/2;
            CGFloat HRadius =  fabs(point0.x - point1.x)* scaleH/2;
            CGRect currentRect = CGRectMake (
                                             (point0.x > point1.x) ? point1.x * scaleW : point0.x * scaleW,
                                             (point0.y > point1.y) ? point1.y * scaleH: point0.y * scaleH,
                                             fabs(point0.x - point1.x)* scaleW,
                                             fabs(point0.y - point1.y)*scaleH);
            
            CGRect inRect = CGRectMake (
                                             (((point0.x > point1.x) ? point1.x * scaleW : point0.x * scaleW) + wRadius/2),
                                             (((point0.y > point1.y) ? point1.y * scaleH: point0.y * scaleH) + HRadius/2),
                                             fabs(point0.x - point1.x)* scaleW-wRadius,
                                             fabs(point0.y - point1.y)* scaleH-HRadius);
            
            UIImage *cropImage = [UIImage imageWithImage:image CropEOEllipseInRect:currentRect inEllipseInRect:inRect];
            self.cropImageView.image = cropImage;
            break;
        }
        case AnimationTypeOfLines: {
            
            UIImage *image = self.imageView.image;
            CGPoint minPoint = [self getMinPoint:self.points];
            CGPoint maxPoint = [self getMaxPoint:self.points];
            
            CGFloat scaleH = image.size.height/self.animationView.frame.size.height;
            CGFloat scaleW = image.size.width/self.animationView.frame.size.width;
            CGRect rect = CGRectMake(minPoint.x * scaleW, minPoint.y * scaleH, (maxPoint.x-minPoint.x) * scaleW, (maxPoint.y-minPoint.y)* scaleH);
            
            NSUInteger pointNum = [self.points count];
            CGPoint points[pointNum];
            for (int i =0; i<[self.points count]; i++) {
                points[i]= [[self.points objectAtIndex:i] CGPointValue];
                points[i].x *=scaleW;
                points[i].y *=scaleH;
            }

            UIImage *cropImage = [UIImage imageWithImage:image Rect:rect lines:points count:(int)pointNum];
            
            self.cropImageView.image = cropImage;
            break;
        }
    }
    
}

- (void)onAnimationDrawArray:(NSArray *)aArray{
    [self.points setArray:aArray];
}


- (CGPoint)getMinPoint:(NSArray *)aArray
{
    CGPoint pointFirst = [[aArray objectAtIndex:0] CGPointValue];
    __block CGFloat minX = pointFirst.x;
    __block CGFloat minY = pointFirst.y;
    [aArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint objPoint = [obj CGPointValue];
        minX = MIN(minX, objPoint.x);
        minY = MIN(minY, objPoint.y);
    }];
    CGPoint minPoint = CGPointMake(minX, minY);
    return minPoint;
}


- (CGPoint)getMaxPoint:(NSArray *)aArray
{
    CGPoint pointFirst = [[aArray objectAtIndex:0] CGPointValue];
    __block CGFloat maxX = pointFirst.x;
    __block CGFloat maxY = pointFirst.y;
    [aArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint objPoint = [obj CGPointValue];
        maxX = MAX(maxX, objPoint.x);
        maxY = MAX(maxY, objPoint.y);
    }];
    CGPoint maxPoint = CGPointMake(maxX, maxY);
    return maxPoint;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
