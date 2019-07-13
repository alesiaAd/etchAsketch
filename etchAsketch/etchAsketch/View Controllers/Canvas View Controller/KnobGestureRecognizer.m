//
//  KnobGestureRecognizer.m
//  etchAsketch
//
//  Created by Anna Ershova on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "KnobGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation KnobGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action{
    self = [super initWithTarget:target action:action];
    if (self) {
        self.maximumNumberOfTouches = 1;
        self.minimumNumberOfTouches = 1;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self updateTouchAngleWithTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self updateTouchAngleWithTouches:touches];
}

#pragma mark - Utility methods
- (void)updateTouchAngleWithTouches:(NSSet *)touchs{
    UITouch *touch = [touchs anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    self.touchAngle = [self calculateAngleToPoint:touchPoint];
}

- (CGFloat)calculateAngleToPoint:(CGPoint)point{
    CGPoint centerOffset = CGPointMake(point.x - CGRectGetMidX(self.view.bounds), point.y - CGRectGetMidY(self.view.bounds));
    return atan2(centerOffset.y, centerOffset.x);
}

@end
