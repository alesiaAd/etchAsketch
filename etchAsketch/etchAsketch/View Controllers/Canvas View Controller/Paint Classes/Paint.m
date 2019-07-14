//
//  Paint.m
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "Paint.h"



@implementation Paint

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        _path = [decoder decodeObjectForKey:@"path"];
        _imageFullSize = [decoder decodeObjectForKey:@"imageFullSize"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.path forKey:@"path"];
    [encoder encodeObject:self.imageFullSize forKey:@"imageFullSize"];
}

- (instancetype)init {
    if (self = [super init]) {
        _path = [NSMutableArray array];
    }
    return self;
}


+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)addVertexToPath:(Vertex *)vertex {
    [self.path addObject:vertex];
}

- (void)removeLastVertex {
    [self.path removeLastObject];
}

- (Vertex *)lastChild {
    return [self.path lastObject];
}


@end
