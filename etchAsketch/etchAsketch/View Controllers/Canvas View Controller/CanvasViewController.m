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

@interface CanvasViewController ()

@property (nonatomic, assign) CGFloat stylusPositionX;

@property (nonatomic, assign) CGFloat stylusPositionY;


@end

@implementation CanvasViewController


#pragma - mark ViewController lifecycle

- (void)viewDidLoad {
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
    [self moveStylusToStart];
    [self.canvasView setNeedsDisplay];
    self.drawingData = [Paint new];
    [Drawings sharedInstance].drawings = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    self.submitButton.hidden = YES;
    if (self.backgroundPaint) {
        self.canvasView.paint = self.backgroundPaint;
    }
    self.backgroungImageView.backgroundColor = [UIColor whiteColor];
    self.backgroungImageView.image = self.canvasView.paint.backgroundImage;
    if (self.canvasView.paint.path.count > 0) {
        [self.canvasView setNeedsDisplay];
    }
    if (self.canvasView.paint.backgroundImage.size.width != 0) {
        self.canvasView.backgroundColor = [UIColor clearColor];
        self.submitButton.hidden = NO;
        [self.submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    self.canvasView.paint.path = @[].mutableCopy;
    self.backgroungImageView.image = nil;
    self.canvasView.paint.backgroundImage = [UIImage imageNamed:@""];
    [self.canvasView setNeedsDisplay];
    [self.backgroungImageView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma - mark
- (void)moveStylusToStart {
    Vertex *vertex = [Vertex new];
    self.stylusPositionX = CGRectGetMidX(self.canvasView.bounds);
    self.stylusPositionY = CGRectGetMidY(self.canvasView.bounds);
    CGPoint translation = CGPointMake(self.stylusPositionX, self.stylusPositionY);
    vertex.location = translation;
    vertex.color = [UIColor blackColor];
    self.canvasView.paint = [Paint new];
    [self.canvasView.paint addVertexToPath: vertex];
}

#pragma - mark

- (void)submit {
    ImagesComparator *comparator = [ImagesComparator new];
    UIImage *backgroungImage = [UIImage new];
    backgroungImage = [self createBackgroundViewScreenShot];
    UIImage *foregroundImage = [UIImage new];
    foregroundImage = [self createForegroundViewScreenShot];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSInteger result = [comparator compareImage:backgroungImage withImage:foregroundImage];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hoorah!" message:[NSString stringWithFormat:@"Your result is %ld", (long)result] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    });
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)showMenu:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self configureAnimation];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)configureAnimation {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.62f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveButtonPressed {
    [self createViewsScreenShot];
    self.drawingData.imageFullSize = self.canvasView.paint.imageFullSize;
    self.drawingData.backgroundImage = self.canvasView.paint.backgroundImage;
    [[Drawings sharedInstance].drawings addObject:self.drawingData];
    [[Drawings sharedInstance] saveData];
}

- (void)createViewsScreenShot {
    UIGraphicsBeginImageContextWithOptions(self.canvasView.frame.size, NO, [UIScreen mainScreen].scale);
    [self.backgroungImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    [self.canvasView.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.canvasView.paint.imageFullSize = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (UIImage *)createBackgroundViewScreenShot {
    UIImage *screen = [UIImage new];
    UIGraphicsBeginImageContextWithOptions(self.canvasView.frame.size, NO, [UIScreen mainScreen].scale);
    [self.backgroungImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    screen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screen;
}

- (UIImage *)createForegroundViewScreenShot {
    UIImage *screen = [UIImage new];
    UIGraphicsBeginImageContextWithOptions(self.canvasView.frame.size, NO, [UIScreen mainScreen].scale);
    [self.canvasView.layer renderInContext:UIGraphicsGetCurrentContext()];
    screen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screen;
}



- (IBAction)randomValueDidPressed:(id)sender {
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
        self.knobControl.value = 0;
        self.knobControlX.value = 0;
        self.canvasView.paint.path = @[].mutableCopy;
        [self.canvasView setNeedsDisplay];
        [self.backgroungImageView setNeedsDisplay];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
    }
}


@end
