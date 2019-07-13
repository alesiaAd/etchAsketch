//
//  DrawingData.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "DrawingData.h"

@implementation DrawingData

- (instancetype)init {
    if (self = [super init]) {
        self.pixels = [NSMutableArray new];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.pixels = [decoder decodeObjectForKey:@"pixels"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.pixels forKey:@"pixels"];
}

@end
