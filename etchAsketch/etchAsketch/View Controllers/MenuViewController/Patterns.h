//
//  Patterns.h
//  etchAsketch
//
//  Created by Alesia Adereyko on 14/07/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Paint.h"

@interface Patterns : NSObject

@property (nonatomic, strong) NSMutableArray <Paint *> *patterns;

+ (instancetype)sharedInstance;

@end
