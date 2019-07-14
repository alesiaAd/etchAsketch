//
//  ViewController.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 12/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "MenuViewController.h"



@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIStackView *stackView = [UIStackView new];
    [self.view addSubview:stackView];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:50],
          [stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-50],
          [stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
          [stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
          ]];
    [stackView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [stackView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 5;
    
    UIButton *galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [galleryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:galleryButton];
    [galleryButton setTitle:@"Gallery" forState:UIControlStateNormal];
    galleryButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIButton *sketchButton = [UIButton new];
    [sketchButton setTitle:@"Sketch" forState:UIControlStateNormal];
    [self.view addSubview:sketchButton];
    sketchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [sketchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    UIButton *patternsButton = [UIButton new];
    [patternsButton setTitle:@"Patterns" forState:UIControlStateNormal];
    [self.view addSubview:patternsButton];
    patternsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [patternsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [stackView addArrangedSubview:galleryButton];
    [stackView addArrangedSubview:sketchButton];
    [stackView addArrangedSubview:patternsButton];
    
    [galleryButton addTarget:self action:@selector(galleryButtonPressed)  forControlEvents:UIControlEventTouchUpInside];
    [sketchButton addTarget:self action:@selector(sketchButtonPressed)  forControlEvents:UIControlEventTouchUpInside];
    [patternsButton addTarget:self action:@selector(patternsButtonPressed)  forControlEvents:UIControlEventTouchUpInside];
}

- (void)galleryButtonPressed {
    [self.coordinatingDelegate showGalleryViewControllerWithCompletion:^{
    }];
}

- (void)patternsButtonPressed {
    [self.coordinatingDelegate showPatternsViewControllerWithCompletion:^{
    }];
}

- (void)sketchButtonPressed {
    [self.coordinatingDelegate showCanvasViewController];
}


@end
