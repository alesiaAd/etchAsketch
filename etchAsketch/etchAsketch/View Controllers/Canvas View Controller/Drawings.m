//
//  Drawings.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "Drawings.h"

static NSString * drawingsKey = @"drawings";

@implementation Drawings

+ (instancetype)sharedInstance
{
    static Drawings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Drawings alloc] init];
    });
    return sharedInstance;
}

- (void) loadData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrayOfencodedObjects = [defaults objectForKey:drawingsKey];
    self.drawings = [NSMutableArray new];
    for (NSData *encodedObject in arrayOfencodedObjects) {
        DrawingData * decodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        [self.drawings addObject:decodedObject];
    }
}

- (void) saveData {
    NSMutableArray *encodedDrawings = [NSMutableArray new];
    for(DrawingData *drawing in self.drawings) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:drawing requiringSecureCoding:NO error:nil];
        [encodedDrawings addObject:encodedObject];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedDrawings forKey:drawingsKey];
    [defaults synchronize];
}

@end
