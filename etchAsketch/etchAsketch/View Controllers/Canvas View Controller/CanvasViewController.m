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

@interface CanvasViewController (){
    KnobView *_knobControl;
}

@end
@implementation CanvasViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _knobControl = [[KnobView alloc] initWithFrame:self.knobPlaceHolderY.bounds];
    [self.knobPlaceHolderY addSubview:_knobControl];
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
    self.view.tintColor = [UIColor redColor];
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    _knobControl.continuous = NO;
    
    self.drawingData = [DrawingData new];
   
    [self.saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents: UIControlEventTouchUpInside];
}
- (IBAction)showMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonPressed {
    [[Drawings sharedInstance].drawings addObject:self.drawingData];
    [[Drawings sharedInstance] saveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)randomValueDidPressed:(id)sender {
    for (NSInteger i = 0; i < 400; i++){
    [_knobControl setValue:i];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%f",_knobControl.value);
    CGRect frame = CGRectMake(50, _knobControl.value, 10, 10);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.backgroundColor = UIColor.blueColor.CGColor;
    
    [self.drawingData.pixels addObject:[NSValue valueWithCGRect:frame]];
    
    [_canvasView addSubview:view];
}


@end
