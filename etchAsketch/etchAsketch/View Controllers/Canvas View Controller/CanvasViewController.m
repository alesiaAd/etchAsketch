//
//  CanvasViewController.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "CanvasViewController.h"
#import "KnobView.h"
#import "KnobGestureRecognizer.h"
#import "KnobRender.h"
#import "Drawings.h"
#import "PaintView.h"
#import "Paint.h"

@interface CanvasViewController (){
    KnobView *_knobControl;
    KnobView *_knobControlTwo;
}

@end
@implementation CanvasViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _knobControl = [[KnobView alloc] initWithFrame:self.knobPlaceHolderY.bounds];
    [self.knobPlaceHolderY addSubview:_knobControl];
    
    _knobControlTwo = [[KnobView alloc] initWithFrame:self.knobPlaceHolderX.bounds];
    [self.knobPlaceHolderX addSubview:_knobControlTwo];
    
    
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 4.0;
    
    
    _knobControlTwo.lineWidth = 4.0;
    _knobControlTwo.pointerLength = 4.0;
//
    self.view.tintColor = [UIColor redColor];
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    [_knobControlTwo addObserver:self forKeyPath:@"value" options:0 context:NULL];
   // _knobControl.continuous = NO;
    
    _viewR = [[UIView alloc] init];
    _viewL = [[UIView alloc] init];
    [self.saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents: UIControlEventTouchUpInside];
    Vertex *vertex = [Vertex new];
    CGPoint translation = CGPointMake(250, 250);
    vertex.location = translation;
    vertex.color = [UIColor greenColor];
    self.canvasView.paint = [Paint new];
    [self.canvasView.paint addVertexToPath: vertex];
    [self.canvasView setNeedsDisplay];
    
    self.drawingData = [Paint new];
}

- (IBAction)showMenu:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonPressed {
    [self.canvasView createThumbnailForPaint];
    self.drawingData.imageFullSize = self.canvasView.paint.imageFullSize;
    [[Drawings sharedInstance].drawings addObject:self.drawingData];
    [[Drawings sharedInstance] saveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)randomValueDidPressed:(id)sender {
    for (NSInteger i = 0; i < 1000; i++){
        [_knobControl setValue:i];
        [_knobControlTwo setValue:i];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%f",_knobControl.value);
    [_viewR setFrame:CGRectMake(_knobControlTwo.value, 0, 10, 10)];
    [_viewL setFrame:CGRectMake(0, _knobControl.value, 10, 10)];
    _viewR.layer.backgroundColor = UIColor.blueColor.CGColor;
    _viewL.layer.backgroundColor = UIColor.redColor.CGColor;
    
    //CGPoint p1 = CGPointMake(_knobControl.value, 50);
    
//    CGRect frame = CGRectMake(_viewR.frame.origin.x, _viewL.frame.origin.y, 10, 10);
    
    
    [_canvasView addSubview:_viewR];
    [_viewR addSubview:_viewL];
    
    Vertex *vertex = [Vertex new];
    CGPoint translation = CGPointMake(_knobControlTwo.value, _knobControl.value);
    vertex.location = translation;
    vertex.color = [UIColor greenColor];
    vertex.size = CGSizeMake(10, 10);
    [self.canvasView.paint addVertexToPath:vertex];
    [self.drawingData.path addObject:vertex];
    [self.canvasView setNeedsDisplay];
}


@end
