//
//  GalleryViewController.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinatingDelegate.h"
#import "Paint.h"

@interface GalleryViewController : UIViewController

@property (nonatomic, strong) NSArray <Paint *> *galleryArray;
@property (nonatomic, weak) id <CoordinatingDelegate> coordinatingDelegate;
@end

