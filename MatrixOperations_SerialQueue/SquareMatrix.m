//
//  SquareMatrix.m
//  MatrixOperationsWithBlocks
//
//  Created by MacBook on 17.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "SquareMatrix.h"

@implementation SquareMatrix

-(instancetype)initWithRowsAndColumns:(NSInteger)N{
    self=[super init];
    if(self){
        self.arr=[[NSMutableArray alloc]initWithCapacity:N];
        for(int i=0;i<N;i++){
            self.arr2=[[NSMutableArray alloc]initWithCapacity:N];
            for(int j=0;j<N;j++){
                int rand=arc4random_uniform(9)+1;
                [self.arr2 insertObject:[NSNumber numberWithInt:rand] atIndex:j];
            }
            [self.arr addObject:self.arr2];
        }
    }
    return self;
}

-(NSString*)description{
    NSMutableArray* stringArray=[NSMutableArray arrayWithCapacity:[[self arr]count]];
    for(int i =0;i<[[self arr]count];i++){
        NSString* arrString=@"";
        for (int j=0; j<[[[self arr]objectAtIndex:i]count]; j++) {
            NSMutableArray* arr=[[self arr]objectAtIndex:i];
            NSString* arr2String=[NSString stringWithFormat:@"%.1f  ",[[arr objectAtIndex:j]floatValue]];
            
            arrString=[arrString stringByAppendingString:arr2String];
        }
        [stringArray addObject:arrString];
    }
    return [stringArray description];
}

-(id)copyWithZone:(NSZone *)zone{
    SquareMatrix* matrix=[[SquareMatrix allocWithZone:zone]initWithRowsAndColumns:[self.arr count]];
    
    for(int i =0;i<[[self arr]count];i++){
        for (int j=0; j<[[[self arr]objectAtIndex:i]count]; j++){
            
            CGFloat newValue=[[[self.arr objectAtIndex:i]objectAtIndex:j]floatValue];
            
            [[matrix.arr objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithFloat:newValue]];
        }
    }
    return matrix;
}

-(BOOL)isEqual:(id)object{
    
    if(self==object){
        return YES;
    }
    
    if (![object isKindOfClass:[SquareMatrix class]]) {
        return NO;
    }
    
    BOOL boolValue=YES;
    
    for (int i=0; i<[[self arr]count]; i++) {
        for (int j=0; j<[[[self arr]objectAtIndex:i]count]; j++) {
            float f1=[[[self.arr objectAtIndex:i]objectAtIndex:j]floatValue];
            float f2=[[[[(SquareMatrix*)object arr]objectAtIndex:i]objectAtIndex:j]floatValue];
            
            if(f1!=f2){
                boolValue=NO;
            break;
            }
        }
        
        if (boolValue==NO) {
            break;
        }
    }
    return boolValue;
}

@end
