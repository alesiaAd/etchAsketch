//
//  Vertex.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/14/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface Vertex : NSObject <NSCoding, NSSecureCoding>


@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint location;

- (void)drawWithContext:(CGContextRef)context;
@end



