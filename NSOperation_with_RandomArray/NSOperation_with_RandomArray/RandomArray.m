//
//  RandomArray.m
//  NSOperation_with_RandomArray
//
//  Created by MacBook on 23.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "RandomArray.h"

@implementation RandomArray
@synthesize arr;

-(instancetype)initArrayWithCapacity:(NSUInteger)capacity{
    self=[super init];
    if (self) {
        self.arr=[[NSMutableArray alloc]initWithCapacity:capacity];
        for (int i=0;i<capacity;i++) {
            int n=arc4random()%100;
            [self.arr addObject:[NSNumber numberWithInt:n]];
        }
        
        executing=NO;
        finished=NO;
    }
    return self;
}

-(void)start{
    if ([self isCancelled]){
        
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

-(void)main{
    @try{
        finished=NO;
        while (![self isCancelled] && !finished) {
            NSLog(@"%@",[NSThread currentThread]);
            int summ=0;
            int avarage=0;
            int count=0;
            for (NSNumber* numb in self.arr) {
                count++;
                summ+=[numb intValue];
                avarage=summ/count;
                NSLog(@"%i",count);
            }
            NSLog(@"Summ= %i, Avarage= %i",summ,avarage);
            
            [self completeOperation];
        }
        
        
    }@catch (NSException *exception) {
        NSLog(@"Exception %@",[exception description]);
    }
    @finally {
        NSLog(@"Custom Operation - Finally block");
    }
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


-(BOOL)isExecuting{
    return executing;
}

-(BOOL)isFinished{
    return finished;
}

@end
