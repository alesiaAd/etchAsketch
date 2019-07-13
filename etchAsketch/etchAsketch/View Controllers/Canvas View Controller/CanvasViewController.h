//
//  CanvasViewController.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingData.h"

@interface CanvasViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *canvasView;
@property (weak, nonatomic) IBOutlet UIView *knobPlaceHolderY;
@property (weak, nonatomic) IBOutlet UIView *knobPlaceHolderX;
@property (strong,nonatomic) NSArray *array;
@property (nonatomic,strong) UIView *viewR;
@property (nonatomic,strong) UIView *viewL;


- (IBAction)randomValueDidPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) DrawingData *drawingData;

@end


