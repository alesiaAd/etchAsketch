//
//  ImagesComparator.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ImagesComparator.h"

@implementation ImagesComparator

- (NSArray *)takePixelsFromImage:(UIImage *)image {
    NSMutableArray *result = [NSMutableArray new];
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    unsigned char *pixels = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, 4*width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    for (int y = 0; y < height; y++){
        for (int x = 0; x < width; x++){
            NSUInteger idx = (width*y+x)*4;
            
            CGFloat red = pixels[idx];
            CGFloat green = pixels[idx + 1];
            CGFloat blue = pixels[idx + 2];
            CGFloat alpha = pixels[idx + 3];

            UIColor *acolor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
            [result addObject:acolor];
        }
    }
    
    imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    free(pixels);
    return result;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSInteger)compareImage:(UIImage *)backgroungImage withImage:(UIImage *)foregroundImage {
    foregroundImage = [self imageWithImage:foregroundImage scaledToSize:backgroungImage.size];
    NSInteger matchingCount = 0;
    NSInteger picturePixelsCount = 0;
    UIColor *white = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    NSArray *array1 = [self takePixelsFromImage:backgroungImage];
    NSArray *array2 = [self takePixelsFromImage:foregroundImage];
    for (int i = 0; i < array1.count; i++) {
        if (![array1[i] isEqual:white]) {
            picturePixelsCount++;
            UIColor *color = array2[i];
            if (CGColorGetAlpha(color.CGColor) != 0) {
                matchingCount++;
            }
        }
    }
    return (CGFloat)matchingCount / (CGFloat)picturePixelsCount * 100;
}

@end
