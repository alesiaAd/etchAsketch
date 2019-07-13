//
//  ImagesComparator.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagesComparator : NSObject

- (NSArray *)takePixelsFromImage:(UIImage *)image;
- (NSInteger)compareImage:(UIImage *)backgroungImage withImage:(UIImage *)foregroundImage;

@end
