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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, _knobControl.value, 10, 10)];
    view.layer.backgroundColor = UIColor.blueColor.CGColor;
    
    [_canvasView addSubview:view];
}


@end
