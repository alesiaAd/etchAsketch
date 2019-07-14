//
//  PaintView.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Paint;


@interface PaintView : UIView

@property (nonatomic, strong) Paint *paint;
- (void)createThumbnailForPaint;
@end

NS_ASSUME_NONNULL_END
