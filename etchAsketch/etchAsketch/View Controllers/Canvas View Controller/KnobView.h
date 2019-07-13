//
//  KnobView.h
//  etchAsketch
//
//  Created by Anna Ershova on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KnobView : UIControl

@property (nonatomic, assign) CGFloat value;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;

#pragma mark - Knob Behavior
@property (nonatomic, assign, getter = isContinuous) BOOL continuous;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat pointerLength;

@end


