//
//  Operations.m
//  MatrixOperationsWithBlocks
//
//  Created by MacBook on 16.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "Operations.h"

@implementation Operations

+(void)addMatrixOne:(SquareMatrix *)matrix1 andTwo:(SquareMatrix *)matrix2 withBlock:(someBlock)someBlock{
    
    dispatch_queue_t mySerialQueue=dispatch_queue_create("com.osadchuk.MyQueue", DISPATCH_QUEUE_SERIAL);
    
        if ([[matrix1 arr]count]!=[[matrix2 arr]count]) {
            NSLog(@"matrix capacity are different");
            someBlock(nil);
        }else{
        
        int size=(int)[[matrix1 arr]count];
        __block SquareMatrix* matrix3=[[SquareMatrix alloc]initWithRowsAndColumns:size];
        
        for(int i=0;i<size;i++){
            for(int j=0;j<size;j++){
                dispatch_sync(mySerialQueue, ^{
                    NSLog(@" %@",[NSThread currentThread]);

                float matrix3_i_j=[[[[matrix3 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
                float matrix1_i_j=[[[[matrix1 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
                float matrix2_i_j=[[[[matrix2 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
                
                matrix3_i_j=matrix1_i_j+matrix2_i_j;
                
                [[[matrix3 arr]objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:matrix3_i_j]];
                    
                    if((i==size-1)&&(j==size-1)){
                        someBlock(matrix3);
                    }
                    
                });
            }
        }
        }
    
    
}

+(void)subMatrixOne:(SquareMatrix *)matrix1 andTwo:(SquareMatrix *)matrix2 withBlock:(someBlock)someBlock{
    
    
    dispatch_queue_t mySerialQueue=dispatch_queue_create("com.osadchuk.MyQueue", DISPATCH_QUEUE_SERIAL);
    
    if ([[matrix1 arr]count]!=[[matrix2 arr]count]) {
        NSLog(@"matrix capacity are different");
        someBlock (nil);
    }else{
    
    int size=(int)[[matrix1 arr]count];
    SquareMatrix* matrix3=[[SquareMatrix alloc]initWithRowsAndColumns:size];
    
    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            dispatch_sync(mySerialQueue, ^{
                NSLog(@" %@",[NSThread currentThread]);

            float matrix3_i_j=[[[[matrix3 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
            float matrix1_i_j=[[[[matrix1 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
            float matrix2_i_j=[[[[matrix2 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
            
            matrix3_i_j=matrix1_i_j-matrix2_i_j;
            
            [[[matrix3 arr]objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:matrix3_i_j]];
                if((i==size-1)&&(j==size-1)){
                    someBlock(matrix3);
                }
        });
        }
    }
    }
}

+(void)multiplyMatrixOne:(SquareMatrix *)matrix1 andTwo:(SquareMatrix *)matrix2 withBlock:(someBlock)someBlock{
    
    
    dispatch_queue_t mySerialQueue=dispatch_queue_create("com.osadchuk.MyQueue", DISPATCH_QUEUE_SERIAL);
    
    if ([[matrix1 arr]count]!=[[matrix2 arr]count]) {
        NSLog(@"matrix capacity are different");
        someBlock(nil);
    }else{
    
    int size=(int)[[matrix1 arr]count];
    SquareMatrix* matrix3=[[SquareMatrix alloc]initWithRowsAndColumns:size];
    
    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            
            [[[matrix3 arr]objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:0]];
            
            for(int k=0;k<size;k++){
                
                dispatch_sync(mySerialQueue, ^{
                    
                    NSLog(@" %@",[NSThread currentThread]);
                float matrix3_i_j=[[[[matrix3 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
                float matrix1_i_k=[[[[matrix1 arr]objectAtIndex:i]objectAtIndex:k]floatValue];
                float matrix2_k_j=[[[[matrix2 arr]objectAtIndex:k]objectAtIndex:j]floatValue];
                
                matrix3_i_j=matrix3_i_j+matrix1_i_k*matrix2_k_j;
                
                [[[matrix3 arr]objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:matrix3_i_j]];
                    
                    if((i==size-1)&&(j==size-1)&&(k==size-1)){
                        someBlock(matrix3);
                    }
                
            });
            }
        }
    }
    }
}

+(void)multiplyMatrix:(SquareMatrix *)matrix1 onScalar:(NSInteger)integer withBlock:(void (^)(SquareMatrix * ))someBlock{
    
        dispatch_queue_t mySerialQueue=dispatch_queue_create("com.osadchuk.MyQueue", DISPATCH_QUEUE_SERIAL);
    
        int size=(int)[[matrix1 arr]count];
        
        SquareMatrix*  matrix2=[[SquareMatrix alloc]initWithRowsAndColumns:size];
        
        for(int i=0;i<size;i++){
            for(int j=0;j<size;j++){
                
                dispatch_sync(mySerialQueue, ^{
                    
                    NSLog(@" %@",[NSThread currentThread]);
                    
                float matrix1_i_j=[[[[matrix1 arr]objectAtIndex:i]objectAtIndex:j]floatValue];
                matrix1_i_j=matrix1_i_j*integer;
                
                [[[matrix2 arr]objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:matrix1_i_j]];
                    
                    if((i==size-1)&&(j==size-1)){
                        someBlock(matrix2);
                    }
                });
            }
        }
    
}
 
+(void)inverseMatrixByJordanGauss:(SquareMatrix*)matrix withBlock:(someBlock)someBlock{
    
    dispatch_queue_t mySerialQueue=dispatch_queue_create("com.osadchuk.MyQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
    
    
    int size=(int)[[matrix arr]count];
    SquareMatrix* B=[[SquareMatrix alloc]initWithRowsAndColumns:size];
    
    for(int i=0;i<size;i++){
        NSMutableArray* rowsE=[B.arr objectAtIndex:i];
        for(int j=0;j<size;j++){
            if(i==j)
                [rowsE replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:1]];
            else
                [rowsE replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:0]];
        }
    }
    
    for(int k=0;k<size;k++){
        NSMutableArray* rowsAk=[matrix.arr objectAtIndex:k];
        NSMutableArray* rowsEk=[B.arr objectAtIndex:k];
        for(int j=k+1;j<size;j++){
            
            dispatch_group_async(group, mySerialQueue, ^{
                
            CGFloat n=[[rowsAk objectAtIndex:j]floatValue];
            CGFloat n2=[[rowsAk objectAtIndex:k]floatValue];
            CGFloat n3=n/n2;
                [rowsAk replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n3]];
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        for(int j=0;j<size;j++){
            dispatch_group_async(group, mySerialQueue, ^{
            CGFloat n=[[rowsEk objectAtIndex:j] floatValue];
            CGFloat n2=[[rowsAk objectAtIndex:k]floatValue];
                CGFloat n3=n/n2;
                [rowsEk replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n3]];
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        dispatch_group_async(group, mySerialQueue, ^{
            
        CGFloat n=(NSInteger)[rowsAk objectAtIndex:k];
        CGFloat n2=(NSInteger)[rowsAk objectAtIndex:k];
        CGFloat n3=n/n2;
        [rowsAk replaceObjectAtIndex:k withObject:[NSNumber numberWithFloat:n3]];
        });
        
        if (k>0) {
            for(int i=0;i<k;i++){
                NSMutableArray* rowsAi=[matrix.arr objectAtIndex:i];
                NSMutableArray* rowsEi=[B.arr objectAtIndex:i];
                for (int j=0; j<size; j++) {
                    
                    dispatch_group_async(group, mySerialQueue, ^{
                    CGFloat n=[[rowsEi objectAtIndex:j]floatValue];
                    CGFloat n2=[[rowsEk objectAtIndex:j]floatValue];
                    CGFloat n3=[[rowsAi objectAtIndex:k]floatValue];
                    CGFloat n4=n-n2*n3;
                    [rowsEi replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n4]];
                    });
                }
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
                
                for(int j=size-1;j>=k;j--){
                    dispatch_group_async(group, mySerialQueue, ^{
                    CGFloat n=[[rowsAi objectAtIndex:j]floatValue];
                    CGFloat n2=[[rowsAk objectAtIndex:j]floatValue];
                    CGFloat n3=[[rowsAi objectAtIndex:k]floatValue];
                    CGFloat n4=n-n2*n3;
                    [rowsAi replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n4]];
                    });
                }
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            }
        }
        for (int i=k+1; i<size; i++) {
            NSMutableArray* rowsAi=[matrix.arr objectAtIndex:i];
            NSMutableArray* rowsEi=[B.arr objectAtIndex:i];
            for (int j=0; j<size; j++) {
                
                dispatch_group_async(group, mySerialQueue, ^{
                CGFloat n=[[rowsEi objectAtIndex:j]floatValue];
                CGFloat n2=[[rowsEk objectAtIndex:j]floatValue];
                CGFloat n3=[[rowsAi objectAtIndex:k]floatValue];
                CGFloat n4=n-n2*n3;
                [rowsEi replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n4]];
                });
            }
            
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            for(int j=size-1;j>=k;j--){
                
                dispatch_group_async(group, mySerialQueue, ^{
                CGFloat n=[[rowsAi objectAtIndex:j]floatValue];
                CGFloat n2=[[rowsAk objectAtIndex:j]floatValue];
                CGFloat n3=[[rowsAi objectAtIndex:k]floatValue];
                CGFloat n4=n-n2*n3;
                [rowsAi replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:n4]];
                });
            }
            
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        }
    }
        someBlock(B);
    dispatch_release(group);
}


@end
