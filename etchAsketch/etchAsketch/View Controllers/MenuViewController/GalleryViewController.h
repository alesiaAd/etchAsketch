//
//  GalleryViewController.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinatingDelegate.h"

@interface GalleryViewController : UIViewController

@property (nonatomic, strong) NSArray *galleryArray;
@property (nonatomic, weak) id<CoordinatingDelegate> coordinatingDelegate;
@end

