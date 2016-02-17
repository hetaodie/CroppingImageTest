//
//  AnimationView.m
//  CroppingImageTest
//
//  Created by Netease on 16/2/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "AnimationView.h"


@interface AnimationView()
@property (nonatomic, strong)NSMutableArray *points;
@property (nonatomic, assign) BOOL isEndDraw;

@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _points = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _points = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.points removeAllObjects];
    self.isEndDraw = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint begionPoint = [touch locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:begionPoint]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    switch (self.animationType) {
        case AnimationTypeOfRect: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:movePoint]];
            break;
        }
        case AnimationTypeOfEllipse: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:movePoint]];
            break;
        }
        case AnimationTypeOfEOEllipse: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:movePoint]];
            break;
        }
        case AnimationTypeOfLines: {
            [self.points addObject:[NSValue valueWithCGPoint:movePoint]];
            break;
        }
    }
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    switch (self.animationType) {
        case AnimationTypeOfRect: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:endPoint]];
            break;
        }
        case AnimationTypeOfEllipse: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:endPoint]];
            break;
        }
        case AnimationTypeOfEOEllipse: {
            if ([self.points count] >1) {
                [self.points removeObjectAtIndex:1];
            }
            [self.points addObject:[NSValue valueWithCGPoint:endPoint]];
            break;
        }
        case AnimationTypeOfLines: {
            [self.points addObject:[NSValue valueWithCGPoint:endPoint]];
            break;
        }
    }
    self.isEndDraw = YES;
     [self setNeedsDisplay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onAnimationDrawArray:)]) {
        [self.delegate onAnimationDrawArray:self.points];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if ([self.points count]<=0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    (context,1,1,1,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    
    CGPoint point0 = [[self.points objectAtIndex:0] CGPointValue];
    CGPoint point1 = [[self.points objectAtIndex:1] CGPointValue];
    
    CGRect currentRect = CGRectMake (
                                     (point0.x > point1.x) ? point1.x : point0.x,
                                     (point0.y > point1.y) ? point1.y : point0.y,
                                     fabs(point0.x - point1.x),
                                     fabs(point0.y - point1.y));
    CGFloat wRadius =  fabs(point0.x - point1.x)/2;
    CGFloat HRadius =  fabs(point0.x - point1.x)/2;
    
    CGRect inRect = CGRectMake (
                                     ((point0.x > point1.x) ? point1.x : point0.x) +wRadius/2,
                                     ((point0.y > point1.y) ? point1.y : point0.y)+HRadius/2,
                                     fabs(point0.x - point1.x)-wRadius,
                                     fabs(point0.y - point1.y)-HRadius);
    
    int pointNum = [self.points count];
    CGPoint points[pointNum];
    for (int i =0; i<[self.points count]; i++) {
        points[i]= [[self.points objectAtIndex:i] CGPointValue];
    }
    
    switch (self.animationType) {
        case AnimationTypeOfRect: {
            CGContextAddRect(context, currentRect);
            break;
        }
        case AnimationTypeOfEllipse: {
            CGContextAddEllipseInRect(context, currentRect);
            break;
        }
        case AnimationTypeOfEOEllipse: {
            CGContextAddEllipseInRect(context, currentRect);
             CGContextAddEllipseInRect(context, inRect);
            break;
        }
        case AnimationTypeOfLines: {
            CGContextAddLines(context, points, [self.points count]);
            if (self.isEndDraw) {
                CGContextClosePath(context);
            }

            break;
        }
    }
    
    CGContextStrokePath(context);
}



@end
