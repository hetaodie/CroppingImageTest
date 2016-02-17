//
//  UIImage+Crop.m
//  CroppingImageTest
//
//  Created by Netease on 16/2/16.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)
+ (UIImage *)imageWithImage:(UIImage *)image CropRectInRect:(CGRect)cropRect{
    
    UIImage *cropImage = [self cropImageWithImage:image Rect:cropRect];
    
    return cropImage;
}

+ (UIImage *)cropImageWithImage:(UIImage *)image Rect:(CGRect)rect{
    
    CGImageRef cropImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:cropImageRef];
    CGImageRelease(cropImageRef);
    return cropImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image CropEllipseInRect:(CGRect)cropRect{
    
     UIImage *cropImage = [self cropImageWithImage:image Rect:cropRect];
    CGSize size = CGSizeMake(cropImage.size.width, cropImage.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //alow antialiasing
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextAddEllipseInRect(context,CGRectMake(0, 0, size.width, size.height));
    CGContextClip(context);
    
    [cropImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //取出整个图片上下文的图片
    cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cropImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image CropEOEllipseInRect:(CGRect)cropRect inEllipseInRect:(CGRect)inRect{
    UIImage *cropImage = [self cropImageWithImage:image Rect:cropRect];
    CGSize size = CGSizeMake(cropImage.size.width, cropImage.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //alow antialiasing
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextAddEllipseInRect(context,CGRectMake(0, 0, cropRect.size.width, cropRect.size.height));
    CGContextAddEllipseInRect(context,CGRectMake(inRect.origin.x - cropRect.origin.x, inRect.origin.y - cropRect.origin.y, inRect.size.width, inRect.size.height));
    
    CGContextEOClip(context);
    
    [cropImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //取出整个图片上下文的图片
    cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cropImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image Rect:(CGRect)rect lines:(CGPoint *)points count:(int)count;{
    UIImage *cropImage = [self cropImageWithImage:image Rect:rect];
    CGSize size = CGSizeMake(cropImage.size.width, cropImage.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //alow antialiasing
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    for (int i=0; i<count; i++) {
        points[i].x -=rect.origin.x;
        points[i].y -=rect.origin.y;
        
    }
    
    CGContextAddLines(context, points, count);
    CGContextClosePath(context);
    
    CGContextClip(context);
    
    [cropImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //取出整个图片上下文的图片
    cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cropImage;
}

@end
