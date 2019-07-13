//
//  CoordinatingDelegate.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletionHandler)(void);
@class Paint;
@class DrawingSettings;

@protocol CoordinatingDelegate <NSObject>

//@optional
- (void)showMenu;
- (void)showGalleryViewControllerWithCompletion:(CompletionHandler)handler;
- (void)showPatternsViewControllerWithCompletion:(CompletionHandler)handler;
- (void)showCanvasViewController;
- (void)showCanvasViewControllerWithSketch:(Paint *)sketch;
- (void)swowCanvasViewControllerAndApplyDrawingSettings:(DrawingSettings *)settings;
- (void)hidePagesViewController;
@end



NS_ASSUME_NONNULL_END
