//
//  CanvasViewController.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "CanvasViewController.h"
#import "KnobGestureRecognizer.h"
#import "KnobRender.h"
#import "Drawings.h"
#import "PaintView.h"
#import "Paint.h"

@implementation CanvasViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.knobControl = [[KnobView alloc] initWithFrame:self.knobPlaceHolderY.bounds];
    self.knobControlX = [[KnobView alloc] initWithFrame:self.knobPlaceHolderX.bounds];
    [self.knobPlaceHolderY addSubview:self.knobControl];
    [self.knobPlaceHolderX addSubview:self.knobControlX];
 
    
    self.knobControl.lineWidth = 10.0;
    self.knobControl.pointerLength = 12.0;
    self.knobControlX.lineWidth = 10.0;
    self.knobControlX.pointerLength = 12.0;
    self.knobPlaceHolderX.layer.cornerRadius = self.knobPlaceHolderX.frame.size.height / 2;
    self.knobPlaceHolderY.layer.cornerRadius = self.knobPlaceHolderX.frame.size.height / 2;
    
    self.view.tintColor = [UIColor lightGrayColor];
    [self.knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    [self.knobControlX addObserver:self forKeyPath:@"value" options:0 context:NULL];
     self.knobControl.continuous = NO;
    
    
    [self.saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents: UIControlEventTouchUpInside];
    Vertex *vertex = [Vertex new];
    //CGPoint translation = CGPointMake(self.knobControlX.value,self.knobControl.value);
    //vertex.location = translation;
    //vertex.color = [UIColor blackColor];
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
    self.drawingData.thumbnail = self.canvasView.paint.thumbnail;
    [[Drawings sharedInstance].drawings addObject:self.drawingData];
    [[Drawings sharedInstance] saveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)randomValueDidPressed:(id)sender {
    
 //   CGFloat randomValue =  (arc4random() % 101) / 100.f;
    [self.knobControl setValue:self.canvasView.frame.size.height];
    [self.knobControlX setValue:self.canvasView.frame.size.width];
    
    self.knobControl.maximumValue = self.canvasView.frame.size.height;
    self.knobControlX.maximumValue = self.canvasView.frame.size.width;

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

    
    self.knobControl.maximumValue = self.canvasView.frame.size.height;
    self.knobControlX.maximumValue = self.canvasView.frame.size.width;
    NSLog(@"%f, %f",self.knobControl.maximumValue,self.knobControlX.maximumValue);
   
    Vertex *vertex = [Vertex new];
    CGPoint translation = CGPointMake(self.knobControlX.value,self.knobControl.value);
    vertex.location = translation;
    vertex.color = [UIColor blackColor];
    vertex.size = CGSizeMake(5, 5);
    [self.canvasView.paint addVertexToPath:vertex];
    [self.drawingData.path addObject:vertex];
    [self.canvasView setNeedsDisplay];
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"begin shake");
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
         NSLog(@"end shake");
    }
}

@end
