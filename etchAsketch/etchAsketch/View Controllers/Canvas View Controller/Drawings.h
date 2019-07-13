//
//  Drawings.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 13/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawingData.h"

@interface Drawings : NSObject

@property (nonatomic, strong) NSMutableArray *drawings;

- (void) loadData;
- (void) saveData;
+ (instancetype)sharedInstance;

@end

