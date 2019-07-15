//
//  PaintView.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>



@class Paint;


@interface PaintView : UIView

@property (nonatomic, strong) Paint *paint;
//@property (nonatomic, strong) UIImageView *backgroundImageView;
- (void)createThumbnailForPaint;
@end


