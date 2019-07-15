//
//  Paint.h
//  etchAsketch
//
//  Created by Arseniy Strakh on 7/13/19.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vertex.h"





@interface Paint : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) NSMutableArray<Vertex *> *path;
@property (nonatomic, strong) UIImage *imageFullSize;
@property (nonatomic, strong) UIImage *backgroundImage;

- (void)addVertexToPath:(Vertex *)vertex;
- (void)removeLastVertex;
- (Vertex *)lastChild;


@end




