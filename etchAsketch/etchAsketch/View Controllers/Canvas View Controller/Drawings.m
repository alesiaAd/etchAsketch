//
//  Drawings.m
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "Drawings.h"
#import "Paint.h"


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

- (void)loadData {
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *directoryPath = [documentsURL.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:@"library.eas"];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *dataArray = [fileHandle readDataToEndOfFile];
    NSMutableArray *arrayOfEncodedObjects = [NSKeyedUnarchiver unarchiveObjectWithData:dataArray];
    NSMutableArray *encodedDrawings = [NSMutableArray new];
    for (NSData *encodedObject in arrayOfEncodedObjects) {
        Paint *decodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        [encodedDrawings addObject:decodedObject];
    }
    self.drawings = encodedDrawings;
}

- (void)saveData {
    NSMutableArray *encodedDrawings = [NSMutableArray new];
    for(Paint *drawing in self.drawings) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:drawing requiringSecureCoding:YES error:nil];
        [encodedDrawings addObject:encodedObject];
    }
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:encodedDrawings requiringSecureCoding:YES error:nil];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *directoryPath = [documentsURL.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:@"library.eas"];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:arrayData attributes:nil];
}

@end
