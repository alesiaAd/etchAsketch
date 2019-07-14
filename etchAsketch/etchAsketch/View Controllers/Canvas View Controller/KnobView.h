//
//  KnobView.h
//  etchAsketch
//
//  Created by Anna Ershova on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnobGestureRecognizer.h"
#import "KnobRender.h"



@interface KnobView : UIControl

@property (nonatomic, assign) CGFloat value;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;
@property (nonatomic, assign, getter = isContinuous) BOOL continuous;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat pointerLength;
@property (nonatomic) KnobGestureRecognizer *gestureRecognizer;
@property (nonatomic) KnobRender *knobRenderer;

@end


