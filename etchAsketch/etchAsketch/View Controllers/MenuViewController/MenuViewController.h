//
//  ViewController.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 12/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinatingDelegate.h"



@interface MenuViewController : UIViewController


@property (nonatomic, weak) id<CoordinatingDelegate> coordinatingDelegate;



@end

