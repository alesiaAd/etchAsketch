//
//  UINavigationBar+EatchASketch.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/14/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "UINavigationBar+EatchASketch.h"

@implementation UINavigationBar (EatchASketch)

- (void)configureNavigationBarForEatchASketch {
    [self configureTitle];
    [self configureBackGround];
}


#pragma mark - Appearance

- (void)configureTitle {
    NSDictionary *titleAttr = @{
                                NSFontAttributeName : [UIFont fontWithName:@"Copperplate" size:17],
                                NSForegroundColorAttributeName :  [UIColor colorNamed:@"YellowText"]
                                };
    self.titleTextAttributes = titleAttr;
}


- (void)configureBackGround {
    self.backgroundColor = [UIColor colorNamed:@"RedBackground"];
    self.barTintColor = [UIColor colorNamed:@"RedBackground"];
    self.shadowImage = [UIImage new];
}

@end
