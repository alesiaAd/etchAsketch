//
//  CanvasViewController.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnobView.h"
#import "ImagesComparator.h"

@class PaintView;
@class Paint;


@interface CanvasViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroungImageView;
@property (nonatomic, strong) Paint *backgroundPaint;
@property (weak, nonatomic) IBOutlet PaintView *canvasView;
@property (weak, nonatomic) IBOutlet UIView *knobPlaceHolderY;
@property (weak, nonatomic) IBOutlet UIView *knobPlaceHolderX;
@property (nonatomic, strong) KnobView *knobControl;
@property (nonatomic, strong) KnobView *knobControlX;

- (IBAction)randomValueDidPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) Paint *drawingData;

@end


