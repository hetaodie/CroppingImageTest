//
//  AnimationView.h
//  CroppingImageTest
//
//  Created by Netease on 16/2/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enum-All.h"

@protocol AnimationDelegate <NSObject>

- (void)onAnimationDrawArray:(NSArray *)aArray;

@end

@interface AnimationView : UIView
@property (nonatomic, assign) AnimationType animationType;
@property (nonatomic, assign) id<AnimationDelegate>delegate;

@end
