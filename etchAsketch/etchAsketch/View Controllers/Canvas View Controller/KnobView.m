//
//  KnobView.m
//  etchAsketch
//
//  Created by Anna Ershova on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "KnobView.h"
#import "KnobRender.h"
#import "KnobGestureRecognizer.h"

@implementation KnobView {
    KnobRender *_knobRenderer;
    KnobGestureRecognizer *_gestureRecognizer;
}

@dynamic lineWidth;
@dynamic startAngle;
@dynamic endAngle;
@dynamic pointerLength;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _minimumValue = 0.0;
        _maximumValue = 300.0;
        _value = 0.0;
        _continuous = YES;
        _gestureRecognizer = [[KnobGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:_gestureRecognizer];
        [self createKnobUI];
    }
    return self;
}


#pragma mark - API Methods
- (void)setValue:(CGFloat)value animated:(BOOL)animated
{
    if(value != _value) {
        [self willChangeValueForKey:@"value"];
        // Save the value to the backing ivar
        // Make sure we limit it to the requested bounds
        _value = MIN(self.maximumValue, MAX(self.minimumValue, value));
        
        CGFloat angleRange = self.endAngle - self.startAngle;
        CGFloat valueRange = self.maximumValue - self.minimumValue;
        CGFloat angleForValue = (_value - self.minimumValue) / valueRange * angleRange + self.startAngle;
        [_knobRenderer setPointerAngle:angleForValue animated:animated];
        
        [self didChangeValueForKey:@"value"];
    }
}
#pragma mark - Property overrides
- (void)setBounds:(CGRect)bounds{
   // [_knobRenderer updateWithBounds:bounds];
}
- (void)setValue:(CGFloat)value
{
    // Chain with the animation method version
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
    _knobRenderer = [[KnobRender alloc] init];
    [_knobRenderer updateWithBounds:self.bounds];
    _knobRenderer.color = self.tintColor;
    //set some defaults
    _knobRenderer.startAngle = 0;
    _knobRenderer.endAngle = M_PI * 2;
    _knobRenderer.lineWidth = 2.0;
    _knobRenderer.pointerLength = 1.0;
    _knobRenderer.pointerAngle = _knobRenderer.startAngle;
    // Add the layers
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
    // 1. Mid-point angle
    CGFloat midPointAngle = (2 * M_PI + self.startAngle - self.endAngle) / 2 + self.endAngle;
    
    // 2. Ensure the angle is within a suitable range
    CGFloat boundedAngle = gesture.touchAngle; 
    if(boundedAngle > midPointAngle) {
        boundedAngle -= 2 * M_PI;
    } else if (boundedAngle < (midPointAngle - 2 * M_PI)) {
        boundedAngle += 2 * M_PI;
    }
    // 3. Bound the angle to within the suitable range
    boundedAngle = MIN(self.endAngle, MAX(self.startAngle, boundedAngle));
    
    // 4. Convert the angle to a value
    CGFloat angleRange = self.endAngle - self.startAngle;
    CGFloat valueRange = self.maximumValue - self.minimumValue;
    CGFloat valueForAngle = (boundedAngle - self.startAngle) / angleRange * valueRange + self.minimumValue;
    
    // 5. Set the control to this value
    self.value = valueForAngle;
    
    // Notify of value change
    if (self.continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        // Only send an update if the gesture has completed
        if(_gestureRecognizer.state == UIGestureRecognizerStateEnded
           || _gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end

