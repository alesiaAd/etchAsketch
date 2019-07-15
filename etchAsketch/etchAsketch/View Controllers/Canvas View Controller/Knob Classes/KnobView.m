//
//  KnobView.m
//  etchAsketch
//
//  Created by Anna Ershova on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "KnobView.h"
#import "CanvasViewController.h"


@implementation KnobView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _minimumValue = 0.0;
        _maximumValue = 500;
        _value = 0.0;
        _continuous = YES;
        _gestureRecognizer = [[KnobGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:_gestureRecognizer];
        [self createKnobUI];
    }
    return self;
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated
{
    if(value != _value) {
        [self willChangeValueForKey:@"value"];
        _value = MIN(self.maximumValue, MAX(self.minimumValue, value));
        CGFloat angleRange = self.endAngle - self.startAngle;
        CGFloat valueRange = self.maximumValue - self.minimumValue;
        CGFloat angleForValue = (_value - self.minimumValue) / valueRange * angleRange + self.startAngle;
        [_knobRenderer setPointerAngle:angleForValue animated:animated];
        
        [self didChangeValueForKey:@"value"];
    }
}

- (void)setBounds:(CGRect)bounds{
    [_knobRenderer updateWithBounds:bounds];
}
- (void)setValue:(CGFloat)value
{
    [self setValue:value animated:NO];
}

- (CGFloat)lineWidth
{
    return _knobRenderer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _knobRenderer.lineWidth = lineWidth;
}

- (CGFloat)startAngle
{
    return _knobRenderer.startAngle;
}

- (void)setStartAngle:(CGFloat)startAngle
{
    _knobRenderer.startAngle = startAngle;
}

- (CGFloat)endAngle
{
    return _knobRenderer.endAngle;
}

- (void)setEndAngle:(CGFloat)endAngle
{
    _knobRenderer.endAngle = endAngle;
}

- (CGFloat)pointerLength
{
    return _knobRenderer.pointerLength;
}

- (void)setPointerLength:(CGFloat)pointerLength
{
    _knobRenderer.pointerLength = pointerLength;
}

- (void)tintColorDidChange{
    _knobRenderer.color = self.tintColor;
}

- (void)createKnobUI{
    self.knobRenderer = [[KnobRender alloc] init];
    [_knobRenderer updateWithBounds:self.bounds];
    self.knobRenderer.color = self.tintColor;
    self.knobRenderer.startAngle = 0;
    self.knobRenderer.endAngle = M_PI * 2;
    self.knobRenderer.lineWidth = 4.0;
    self.knobRenderer.pointerLength = 6.0;
    self.knobRenderer.pointerAngle = _knobRenderer.startAngle;
    [self.layer addSublayer:_knobRenderer.trackLayer];
    [self.layer addSublayer:_knobRenderer.pointerLayer];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"value"]) {
        return NO;
    }else{
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)handleGesture:(KnobGestureRecognizer *)gesture{
    CGFloat midPointAngle = (2 * M_PI + self.startAngle - self.endAngle) / 2 + self.endAngle;
    CGFloat boundedAngle = gesture.touchAngle;
    if(boundedAngle > midPointAngle) {
        boundedAngle -= 2 * M_PI;
    } else if (boundedAngle < (midPointAngle - 2 * M_PI)) {
        boundedAngle += 2 * M_PI;
    }
    boundedAngle = MIN(self.endAngle, MAX(self.startAngle, boundedAngle));
    CGFloat angleRange = self.endAngle - self.startAngle;
    CGFloat valueRange = self.maximumValue - self.minimumValue;
    CGFloat valueForAngle = (boundedAngle - self.startAngle) / angleRange * valueRange + self.minimumValue;
    self.value = valueForAngle;
    if (self.continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        if(self.gestureRecognizer.state == UIGestureRecognizerStateEnded
           || self.gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end


