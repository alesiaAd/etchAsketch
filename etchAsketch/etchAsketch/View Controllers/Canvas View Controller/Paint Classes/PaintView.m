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
    CGContextMoveToPoint(context, 0, 0);
    for (Vertex *vertex in self.paint.path) {
        [vertex drawWithContext:context];
    }
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetLineCap(context, kCGLineCapSquare);
}


//- (void)awakeFromNib {
//    [super awakeFromNib];
//    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:self.backgroundImageView];
//            [NSLayoutConstraint activateConstraints:@[
//                [self.backgroundImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
//                [self.backgroundImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
//                [self.backgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
//                [self.backgroundImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
//            ]];
//}

@end
