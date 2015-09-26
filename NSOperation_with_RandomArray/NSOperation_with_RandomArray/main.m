//
//  main.m
//  NSOperation_with_RandomArray
//
//  Created by MacBook on 23.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomArray.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        RandomArray* array=[[RandomArray alloc]initArrayWithCapacity:50];
        RandomArray* array2=[[RandomArray alloc]initArrayWithCapacity:100];
        
        NSOperationQueue* operationQueue=[NSOperationQueue new];
        [array addDependency:array2];
        [operationQueue addOperation:array];
        [operationQueue addOperation:array2];
        
//      [array start];
//      [array2 start];
        
        sleep(1);
        
       // NSLog(@"%@",[array.arr description]);
        
        
    }
    return 0;
}

