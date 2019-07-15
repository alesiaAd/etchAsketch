//
//  PagesViewController.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinatingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PagesViewController : UIViewController
@property (nonatomic, weak) id<CoordinatingDelegate> coordinatingDelegate;
@end

NS_ASSUME_NONNULL_END
