//
//  GalleryViewController.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCollectionViewCell.h"

static NSString *cellIdentifier = @"GalleryCollectionViewCell";

@interface GalleryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10],
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
    ]];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:GalleryCollectionViewCell.class forCellWithReuseIdentifier:cellIdentifier];
    [self configureNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

#pragma - mark Navigation animation and appearance

- (void)configureNavigation {
    [self.navigationItem setHidesBackButton:YES animated:NO];
    UIBarButtonItem *closeGallery = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"cross exit button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(showMenu)];
    self.navigationItem.rightBarButtonItem = closeGallery;
}

- (void)showMenu {
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
}

#pragma - mark

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageView.image = self.galleryArray[indexPath.item].imageFullSize;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.galleryArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Paint *paint = self.galleryArray[indexPath.item];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
//    UIView *imgView = [UIView new];
//    imgView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:imgView];
//    [NSLayoutConstraint activateConstraints:@[
//        [imgView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10],
//        [imgView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10],
//        [imgView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10],
//        [imgView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
//    ]];
    
    if (paint.backgroundImage.size.width == 0) {
        paint.backgroundImage = self.galleryArray[indexPath.item].imageFullSize;
    }
    [self.coordinatingDelegate showCanvasViewControllerWithSketch:paint];
}

@end
