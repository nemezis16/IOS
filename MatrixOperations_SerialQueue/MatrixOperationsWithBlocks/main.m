//
//  main.m
//  MatrixOperationsWithBlocks
//
//  Created by MacBook on 16.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operations.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        SquareMatrix* matrix1=[[SquareMatrix alloc]initWithRowsAndColumns:2];
        NSLog(@"%@",[matrix1 description]);
        
        SquareMatrix* matrix2=[[SquareMatrix alloc]initWithRowsAndColumns:2];
        NSLog(@"%@",[matrix2 description]);
        
        //add
        [Operations addMatrixOne:matrix1 andTwo:matrix2 withBlock:^(SquareMatrix* someMatrix){
            NSLog(@"add %@",[someMatrix description]);
        }];
        
        
        //substract
        [Operations subMatrixOne:matrix1 andTwo:matrix2 withBlock:^(SquareMatrix* someMatrix){
            NSLog(@"substract %@",[someMatrix description]);
        }];
        
        //multiply
        [Operations multiplyMatrixOne:matrix1 andTwo:matrix2 withBlock:^(SquareMatrix* someMatrix){
            NSLog(@"multiply %@",[someMatrix description]);
        }];     
        
        //multiply on scalar
        int scalar=3;
        [Operations multiplyMatrix:matrix1 onScalar:scalar withBlock:^(SquareMatrix* someMatrix){
            
            NSLog(@"multiply on scalar %i: %@",scalar,[someMatrix description]);
        }];
        
        
        //copy matrix
        __block SquareMatrix* matrix3=[matrix1 copy];
        
        //check is equal
        if([matrix1 isEqual:matrix3])
            NSLog(@"They are equal");
        else
            NSLog(@"They are not equal");
        
        //inverse matrix
        NSLog(@"Previous matrix: %@",[matrix3 description]);
        [Operations inverseMatrixByJordanGauss:matrix3 withBlock:^(SquareMatrix* someMatrix){
            NSLog(@"Inversed matrix: %@",[someMatrix description]);
            
            //check inversed matrix
            [Operations multiplyMatrixOne:matrix1 andTwo:someMatrix withBlock:^(SquareMatrix* someMatrix2){
                NSLog(@"check the matrix %@",[someMatrix2 description]);
            }];
        }];
        
        
        sleep(4);
        
        //check is equal again
        if([matrix1 isEqual:matrix3])
            NSLog(@"They are equal");
        else
            NSLog(@"They are not equal");
        
        
    }
    return 0;
}

