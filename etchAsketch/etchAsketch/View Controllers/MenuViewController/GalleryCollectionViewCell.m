//
//  GalleryCollectionViewCell.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 14/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

@implementation GalleryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
