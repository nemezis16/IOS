//
//  CalculatorModel.m
//  CalculatorWithUI_RationalNumbers
//
//  Created by MacBook on 01.10.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "CalculatorModel.h"


@implementation CalculatorModel
//@synthesize operands=_operands,operations=_operations;

-(RationalNumbers*)getValueFromString:(NSString*)string{
    
    //operations with string in brackets
    while ( [string rangeOfString:@")"].location != NSNotFound ) {
        string=[self resultInBarcketsFrom:string];
    }
    
    RationalNumbers* rf =[self parse:string];
    
    return [RationalNumbers reducingFraction:rf];

}

-(RationalNumbers* )parse:(NSString *)stringToParse{
    NSString* string=stringToParse;
    NSString* maxStrign=@"";
    NSString* partOfString=@"";
    NSString* resultString=@"";
    NSMutableArray* operands=[NSMutableArray new];
    NSMutableArray* operations=[NSMutableArray new];
    
    if ([stringToParse isEqualToString:@""]) {
        return 0;
    }
    
    NSString* operationsToCompare=@"+-x:";
    for(int i=0;i<[string length];i++){
        NSString* character=[string substringWithRange:NSMakeRange(i, 1)];
        
        // get operations from string to array
        if( [operationsToCompare rangeOfString:character].location != NSNotFound ){
            
            partOfString=maxStrign;
            maxStrign=[string substringWithRange:NSMakeRange(0, i+1)];
            resultString=[maxStrign substringFromIndex:[partOfString length]];
            
            [operands addObject:[self convertToRationalFrom:resultString]];
            [operations addObject:character];
        }
        
        else if(i==[string length]-1){ //&& ([character isEqualToString:[string substringFromIndex:[maxStrign length]]])){
            resultString=[string substringFromIndex:[maxStrign length]];
            
            [operands addObject:[self convertToRationalFrom:resultString]];
        }
        
    }
    RationalNumbers* result=[self operationsAccordingToPriorityWithOperands:operands Operations:operations];
   
    return result;
    
}

-(RationalNumbers*)convertToRationalFrom:(NSString*)string{
    NSString* character;
    
    for (int i=0; i<[string length]; i++) {
         character=[string substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"/"]) {
            NSInteger numerator=[[string substringToIndex:i]integerValue];
            NSInteger denominator=[[string substringFromIndex:i+1]integerValue];
            RationalNumbers* rationalNumber=[[RationalNumbers alloc]initWith:numerator and:denominator];
            return rationalNumber;
        }else if(i==[string length]-1){
            
            RationalNumbers* rationalNumber=[[RationalNumbers alloc]initWith:[string integerValue] and:1];
            return rationalNumber;
        }
    }
    return [[RationalNumbers alloc]initWith:0 and:0];;
}

-(NSString*)resultInBarcketsFrom:(NSString*)string{
 
    for(int i=0;i<[string length];i++){
        NSString* character=[string substringWithRange:NSMakeRange(i, 1)];
        if([character isEqualToString:@")"]){
            
            for(int j=i;j>=0;j--){
                NSString* character2=[string substringWithRange:NSMakeRange(j, 1)];
                if([character2 isEqualToString:@"("]){
                    NSString* stringInBrackets=[string substringWithRange:NSMakeRange(j+1, i-j-1)];
                    NSString* stringWithBrackets=[string substringWithRange:NSMakeRange(j, i-j+1)];
                    
                    RationalNumbers* val=[self parse:stringInBrackets];
                    
                    
                    string=[string stringByReplacingOccurrencesOfString:stringWithBrackets withString:[val description]];
                    break;
                    }
            }
            break;
        }
    }
    return string;
    
}


-(RationalNumbers*)operationsAccordingToPriorityWithOperands:(NSMutableArray*)operands Operations:(NSMutableArray*) operations{
    while ([operands count]!=1) {
        for(int i=0;i< [operations count];i++){
            
            if (([operations[i] isEqualToString:@"x"]||
                 [operations[i] isEqualToString:@":"])&&
                i!=[operands count]-1) {
                
                if ([operations[i] isEqualToString:@"x"]){
                    
                    RationalNumbers* val=[RationalNumbers multiply:operands[i] and:operands[i+1]];
                    
                    [operands replaceObjectAtIndex:i withObject:val];
                    [operands removeObjectAtIndex:i+1];
                    [operations removeObjectAtIndex:i];
                    
                }else if ([operations[i] isEqualToString:@":"]){
                    
                    
                    RationalNumbers* val=[RationalNumbers divide:operands[i] and:operands[i+1]];
                    [operands replaceObjectAtIndex:i withObject:val];
                    [operands removeObjectAtIndex:i+1];
                    [operations removeObjectAtIndex:i];
                }
            }
        }
        for(int i=0;i< [operations count];i++){
            
            if (([operations[i] isEqualToString:@"+"]||
                 [operations[i] isEqualToString:@"-"]) &&
                (i!=[operands count]-1)) {
                
                if ([operations[i] isEqualToString:@"+"]){
                    NSLog(@"%@",[operands[i]description]);
                    NSLog(@"%@",[operands[i+1]description]);
                    
                    RationalNumbers* val=[RationalNumbers add:operands[i] and:operands[i+1]];
                    [operands replaceObjectAtIndex:i withObject:val];
                    [operands removeObjectAtIndex:i+1];
                    [operations removeObjectAtIndex:i];
                    
                }else if ([operations[i] isEqualToString:@"-"]){
                    
                    RationalNumbers* val=[RationalNumbers subtract:operands[i] and:operands[i+1]];
                    [operands replaceObjectAtIndex:i withObject:val];
                    [operands removeObjectAtIndex:i+1];
                    [operations removeObjectAtIndex:i];
                }
            }
            
            
        }
    }
    return operands[0];
}



@end
