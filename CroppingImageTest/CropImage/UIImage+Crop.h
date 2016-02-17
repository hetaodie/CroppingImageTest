//
//  UIImage+Crop.h
//  CroppingImageTest
//
//  Created by xu.wei on 16/2/16.
//  Copyright © 2016年 weixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enum-All.h"

@interface UIImage (Crop)
/*!
 *  根据给定的cropRect大小，截取图片image
 *
 *  @param image    需要截取的原始图片
 *  @param cropRect 截取的大小
 *
 *  @return 返回截取好的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image CropRectInRect:(CGRect)cropRect;

/*!
 *  根据给定的cropRect大小，截取图片image，截取的形状为椭圆
 *
 *  @param image    需要截取的原始图片
 *  @param cropRect 截取的大小
 *
 *  @return 返回截取好的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image CropEllipseInRect:(CGRect)cropRect;

/*!
 * 根据给定的cropRect和inRect的大小，截取图片image，获得环形的图片
 *
 *  @param image    需要截取的原始图片
 *  @param cropRect 外环的大小
 *  @param inRect   内环的大小
 *
 *  @return 返回截取好的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image CropEOEllipseInRect:(CGRect)cropRect inEllipseInRect:(CGRect)inRect;

/**
 *
 *
 *  @param image  根据给定的rect的大小，截取图片image，获取的是通过points包围的内容
 *  @param rect   截取图片的范围
 *  @param points 需要窃取图片内容包围的点
 *  @param count  点的个数
 *
 *  @return 返回截取好的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image Rect:(CGRect)rect lines:(CGPoint *)points count:(int)count;


@end
