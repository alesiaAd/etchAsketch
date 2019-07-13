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



- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (Vertex *vertex in self.paint.path) {
        [vertex drawWithContext:context];
    }
}

@end
