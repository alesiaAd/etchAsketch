//
//  CoordinatingDelegate.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^CompletionHandler)(void);

@class Paint;


@protocol CoordinatingDelegate <NSObject>


- (void)showMenu;
- (void)showGalleryViewControllerWithCompletion:(CompletionHandler)handler;
- (void)showPatternsViewControllerWithCompletion:(CompletionHandler)handler;
- (void)showCanvasViewController;
- (void)showCanvasViewControllerWithSketch:(Paint *)sketch;
- (void)hidePagesViewController;

@end




