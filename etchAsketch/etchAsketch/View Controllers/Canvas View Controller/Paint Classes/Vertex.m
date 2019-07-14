//
//  Vertex.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/14/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        _color = [decoder decodeObjectForKey:@"color"];
        _size = [[decoder decodeObjectForKey:@"size"] CGSizeValue];
        _location = [[decoder decodeObjectForKey:@"location"] CGPointValue];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.color forKey:@"color"];
    [encoder encodeObject:[NSValue valueWithCGSize:self.size] forKey:@"size"];
    [encoder encodeObject:[NSValue valueWithCGPoint:self.location] forKey:@"location"];
}


+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)drawWithContext:(CGContextRef)context {
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, self.size.width);
    CGContextAddLineToPoint(context, x, y);
}

@end
