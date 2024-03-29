//
//  CoordinatorViewController.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "CoordinatingController.h"
#import "PagesViewController.h"
#import "MenuViewController.h"
#import "GalleryViewController.h"
#import "CanvasViewController.h"
#import "Patterns.h"
#import "Drawings.h"
#import "PaintView.h"

static NSString *const hasRunOnceKey = @"hasRunAppOnceKey";



@interface CoordinatingController ()
@property (nonatomic, assign, getter=isFirstLaunch) BOOL firstLaunch;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) GalleryViewController *galleryViewController;
@property (nonatomic, strong) GalleryViewController *patternsViewController;
@property (nonatomic, strong) CanvasViewController *canvasViewController;
@property (nonatomic, strong) PagesViewController *pagesViewController;
@end


@implementation CoordinatingController

#pragma mark - Object Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        [self checkForFirstLaunch];
        _menuViewController = [MenuViewController new];
        _menuViewController.coordinatingDelegate = self;
        _galleryViewController = [GalleryViewController new];
        _galleryViewController.coordinatingDelegate = self;
        _patternsViewController = [GalleryViewController new];
        _patternsViewController.coordinatingDelegate = self;
        _canvasViewController = [CanvasViewController new];
    }
    return self;
}

- (void)checkForFirstLaunch {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:hasRunOnceKey] == NO) {
        _firstLaunch = YES;
        [defaults setBool:YES forKey:hasRunOnceKey];
    }
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isFirstLaunch) {
        [self showPages];
    } else {
        [self showMenu];
    }
}

#pragma mark -

- (void)showPages {
    self.pagesViewController = [PagesViewController new];
    self.pagesViewController.coordinatingDelegate = self;
    [self addChildViewController:self.pagesViewController];
    self.pagesViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pagesViewController.view];
    [NSLayoutConstraint activateConstraints:
     @[
       
       [self.pagesViewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
       [self.pagesViewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
       [self.pagesViewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
       [self.pagesViewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
       ]
     ];
    [self.pagesViewController didMoveToParentViewController:self];
}

- (void)showMenu {
    self.title = @"Menu";
    self.galleryViewController.title = @"Gallery";
    self.patternsViewController.title = @"Patterns";
    [self addChildViewController:self.menuViewController];
    self.menuViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.menuViewController.view];
    [NSLayoutConstraint activateConstraints:
     @[
       
       [self.menuViewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
       [self.menuViewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
       [self.menuViewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
       [self.menuViewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
       ]
     ];
    [self.menuViewController didMoveToParentViewController:self];
}


#pragma mark - CoordinatingDelegate

- (void)configureAnimation {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.62f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}

- (void)showCanvasViewController {
    self.navigationController.navigationBarHidden = YES;
    [self configureAnimation];
    [self.navigationController pushViewController:self.canvasViewController animated:NO];
}

- (void)showGalleryViewControllerWithCompletion:(nonnull CompletionHandler)handler {
    self.navigationController.navigationBarHidden = NO;
    [self configureAnimation];
    [[Drawings sharedInstance] loadData];
    self.galleryViewController.galleryArray = [Drawings sharedInstance].drawings;
    [self.navigationController pushViewController:self.galleryViewController animated:NO];
}

- (void)showPatternsViewControllerWithCompletion:(nonnull CompletionHandler)handler {
    self.navigationController.navigationBarHidden = NO;
    [self configureAnimation];
    self.patternsViewController.galleryArray = [Patterns sharedInstance].patterns;
    [self.navigationController pushViewController:self.patternsViewController animated:NO];
}

- (void)hidePagesViewController {
    [self.pagesViewController willMoveToParentViewController:nil];
    [self.pagesViewController.view removeFromSuperview];
    [self.pagesViewController removeFromParentViewController];
    self.navigationItem.rightBarButtonItem = nil;
    [self showMenu];
    [self.view setNeedsDisplay];
}

- (void)showCanvasViewControllerWithSketch:(Paint *)sketch {
    self.navigationController.navigationBarHidden = YES;
    self.canvasViewController.backgroundPaint = sketch;
    [self showCanvasViewController];
}



@end
