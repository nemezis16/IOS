//
//  RandomArray.h
//  NSOperation_with_RandomArray
//
//  Created by MacBook on 23.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RandomArray : NSOperation

{
    BOOL executing;
    BOOL finished;
}


@property (nonatomic,strong) NSMutableArray* arr;

-(instancetype)initArrayWithCapacity:(NSUInteger)capacity;

@end
