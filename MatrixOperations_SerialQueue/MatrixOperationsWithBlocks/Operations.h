//
//  Operations.h
//  MatrixOperationsWithBlocks
//
//  Created by MacBook on 16.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquareMatrix.h"

typedef void(^someBlock)(SquareMatrix*);

@interface Operations : NSObject

+(void)addMatrixOne:(SquareMatrix*)matrix1 andTwo:(SquareMatrix*)matrix2 withBlock:(someBlock)someBlock ;

+(void)subMatrixOne:(SquareMatrix*)matrix1 andTwo:(SquareMatrix*)matrix2 withBlock:(someBlock)someBlock ;

+(void)multiplyMatrixOne:(SquareMatrix*)matrix1 andTwo:(SquareMatrix*)matrix2 withBlock:(someBlock)someBlock;

+(void)multiplyMatrix:(SquareMatrix*)matrix1 onScalar:(NSInteger)integer withBlock:(someBlock)someBlock;

+(void)inverseMatrixByJordanGauss:(SquareMatrix*)matrix withBlock:(someBlock)someBlock;

@end
