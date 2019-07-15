//
//  PagesChildViewController.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "PagesChildViewController.h"

@interface PagesChildViewController ()

@end

@implementation PagesChildViewController

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurePageImage];
}

- (void)viewDidAppear:(BOOL)animated {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"screen%ld", (long)self.index + 1]];
    self.pageImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.pageImage setImage:image];
}

#pragma mark -

- (void)configurePageImage {
    self.pageImage = [UIImageView new];
    self.pageImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pageImage];
    [NSLayoutConstraint activateConstraints:
     @[
       [self.pageImage.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
       [self.pageImage.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
       [self.pageImage.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
       [self.pageImage.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20]
       ]
     ];
}

@end
