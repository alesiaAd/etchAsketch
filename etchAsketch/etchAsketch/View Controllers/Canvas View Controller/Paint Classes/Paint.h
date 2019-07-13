//
//  Paint.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol  MarkProtocol;


@interface Paint : NSObject


@end



@protocol MarkProtocol <NSObject>


@optional
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSInteger count;

- (void)addMark:(id <MarkProtocol>)mark;
- (void)removeMark:(id <MarkProtocol>)mark;
- (id <MarkProtocol>)childAtIndex:(NSInteger)index;
- (id <MarkProtocol>)lastChild;


@end


NS_ASSUME_NONNULL_END
