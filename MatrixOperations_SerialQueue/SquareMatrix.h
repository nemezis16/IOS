//
//  SquareMatrix.h
//  MatrixOperationsWithBlocks
//
//  Created by MacBook on 17.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareMatrix : NSObject <NSCopying>

@property NSMutableArray* arr;
@property NSMutableArray* arr2;

-(instancetype)initWithRowsAndColumns:(NSInteger)N;

-(NSString*)description;

-(id)copyWithZone:(NSZone *)zone;

-(BOOL)isEqual:(id)object;

@end
