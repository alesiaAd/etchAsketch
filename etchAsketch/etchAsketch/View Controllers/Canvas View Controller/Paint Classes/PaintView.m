//
//  PaintView.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "PaintView.h"
#import "Paint.h"



@implementation PaintView

- (void)createThumbnailForPaint {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.paint.imageFullSize = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    [self.paint.path enumerateObjectsUsingBlock:^(Vertex * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            CGContextMoveToPoint(context, obj.location.x, obj.location.y);
        }
        [obj drawWithContext:context];
    }];
//    for (Vertex *vertex in self.paint.path) {
//
//
//    }
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetLineCap(context, kCGLineCapSquare);
}


@end
