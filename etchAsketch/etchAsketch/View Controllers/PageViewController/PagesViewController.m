//
//  PagesViewController.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "PagesViewController.h"
#import "PagesChildViewController.h"

const NSInteger pagesCount = 2;

@interface PagesViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"Tutorial";
    self.view.backgroundColor = [UIColor colorNamed:@"RedBackground"];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [self.pageController.view setFrame:[self.view bounds]];
    
    PagesChildViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(PagesChildViewController *)viewController index];
    if (index == 0) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(PagesChildViewController *)viewController index];
    index++;
    if (index == pagesCount) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PagesChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    PagesChildViewController *childViewController = [[PagesChildViewController alloc] init];
    childViewController.index = index;
    if (index == pagesCount - 1) {
        [self.parentViewController.navigationItem setHidesBackButton:YES animated:YES];
        UIBarButtonItem *finishTutorial = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"cross exit button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self.coordinatingDelegate action:@selector(hidePagesViewController)];
        self.parentViewController.navigationItem.rightBarButtonItem = finishTutorial;
    }
    return childViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    [self setupPageControl];
    return pagesCount;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void) setupPageControl{
    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor lightGrayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor blackColor]];
    [[UIPageControl appearance] setTintColor: [UIColor blackColor]];
    
}

@end
