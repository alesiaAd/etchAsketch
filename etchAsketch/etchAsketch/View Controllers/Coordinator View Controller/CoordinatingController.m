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
    [self showMenu];
    if (self.isFirstLaunch) {
        [self showPages];
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

- (void)showCanvasViewController {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:self.canvasViewController animated:YES];
}

- (void)showGalleryViewControllerWithCompletion:(nonnull CompletionHandler)handler {
    self.navigationController.navigationBarHidden = NO;
     [self.navigationController pushViewController:self.galleryViewController animated:YES];
}

- (void)showPatternsViewControllerWithCompletion:(nonnull CompletionHandler)handler {
    self.navigationController.navigationBarHidden = NO;
    self.patternsViewController.galleryArray = [Patterns sharedInstance].patterns;
    [self.navigationController pushViewController:self.patternsViewController animated:YES];
}

- (void)showMenuWithCompletion:(nonnull CompletionHandler)handler {
    [self showMenu];
}

- (void)hidePagesViewController {
    [self.pagesViewController willMoveToParentViewController:nil];
    [self.pagesViewController.view removeFromSuperview];
    [self.pagesViewController removeFromParentViewController];
    self.navigationItem.rightBarButtonItem = nil;
    [self.view setNeedsDisplay];
}

- (void)showCanvasViewControllerWithSketch:(Paint *)sketch {
//    self.canvasViewController.canvasView
    [self showCanvasViewController];
}

- (void)swowCanvasViewControllerAndApplyDrawingSettings:(DrawingSettings *)settings {
    
}

@end
