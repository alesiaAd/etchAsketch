//
//  Patterns.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 14/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "Patterns.h"

@implementation Patterns

+ (instancetype)sharedInstance
{
    static Patterns *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Patterns alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.patterns = [NSMutableArray new];
        for (int i = 1; i <=7; i++) {
            Paint *paint = [Paint new];
            paint.backgroundImage = [UIImage imageNamed:[NSString stringWithFormat:@"Pattern%d", i]];
            [self.patterns addObject:paint];
        }
    }
    return self;
}

@end
