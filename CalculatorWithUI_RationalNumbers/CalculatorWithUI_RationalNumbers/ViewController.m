//
//  ViewController.m
//  CalculatorWithUI_RationalNumbers
//
//  Created by MacBook on 30.09.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorModel.h"

@interface ViewController ()
@property (strong,nonatomic) CalculatorModel* model;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) BOOL isOperationClicked;
@property (nonatomic) NSUInteger bracketsCounter;


- (IBAction)onOperationClicked:(UIButton *)sender;
- (IBAction)onClearClicked:(UIButton *)sender;
- (IBAction)onEqualClicked:(UIButton *)sender;
- (IBAction)onBackspaceClicked:(UIButton *)sender;

- (IBAction)onBracketsOpened:(UIButton *)sender;
- (IBAction)onBracketsClosed:(UIButton *)sender;


@end

@implementation ViewController
@synthesize label,model;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)onEqualClicked:(UIButton *)sender {
    if(self.bracketsCounter==0){
        self.model=[CalculatorModel new];
        RationalNumbers* i=[self.model getValueFromString:self.label.text];
        if([i denominator]==1){
            self.label.text=[NSString stringWithFormat:@"%i",[i numerator]];
        }else if([i denominator]==0){
            self.label.text=[NSString stringWithFormat:@"Dividing by zero"];
        }else{
            self.label.text=[i description];
        }
    }
}

- (IBAction)onBackspaceClicked:(UIButton *)sender {
    NSString* labelText=self.label.text;
    NSString* lastOperation=[label.text substringFromIndex:[label.text length]-1];
    if ([labelText length]==1){
    
        if ([lastOperation isEqualToString:@"("]){
            self.bracketsCounter--;
        }
        
        self.label.text=@"0";
    }
     else if([lastOperation isEqualToString:@"("]){
        self.label.text=[labelText substringToIndex:[labelText length] -1];
        self.bracketsCounter--;
    }else if([lastOperation isEqualToString:@")"]){
        self.label.text=[labelText substringToIndex:[labelText length] -1];
        self.bracketsCounter++;
    }else 
        self.label.text=[labelText substringToIndex:[labelText length] -1];
    
}

- (IBAction)onBracketsOpened:(UIButton *)sender {
    NSString* lastOperation=[label.text substringFromIndex:[label.text length]-1];
    NSString* operations=@"+-x:(/";
    
    if ([label.text isEqualToString:@"0"]) {
        label.text=@"(";
        self.bracketsCounter++;
        
    }else if ([operations rangeOfString:lastOperation].location != NSNotFound ) {
        
        self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
        self.bracketsCounter++;
    }
    
}

- (IBAction)onBracketsClosed:(UIButton *)sender {
    if (self.bracketsCounter>0) {
        
        NSString* lastOperation=[label.text substringFromIndex:[label.text length]-1];
        NSString* operations=@"+-x:";
        if ([operations rangeOfString:lastOperation].location != NSNotFound ) {
            self.label.text=[self.label.text substringToIndex:[self.label.text length] -1];
            self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
            self.bracketsCounter--;
        }else{
            self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
            self.bracketsCounter--;
        }
    }
}



- (IBAction)onClearClicked:(UIButton *)sender {
    self.bracketsCounter=0;
    [self.label setText:@"0"];
}

- (IBAction)onOperationClicked:(UIButton *)sender {
    NSString* lastOperation=[label.text substringFromIndex:[label.text length]-1];
    NSString* operations=@"+-x:/";
    if ([operations rangeOfString:lastOperation].location == NSNotFound ) {
        self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
    }else{
        self.label.text=[self.label.text substringToIndex:[self.label.text length] -1];
        self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
    }
    self.isOperationClicked=YES;
   }


- (IBAction)onOperandClicked:(UIButton*)sender {
    NSString* lastOperation=[label.text substringFromIndex:[label.text length]-1];
    
    if ([label.text isEqualToString:@"0"]) {
        label.text=@"";
    }
   
    if(!self.isOperationClicked && ![lastOperation isEqualToString:@")"]){
        
        self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
        
    }else  if(self.isOperationClicked &&
              ![lastOperation isEqualToString:@")"]){
        
        self.label.text=[self.label.text stringByAppendingString:sender.titleLabel.text];
        
        self.isOperationClicked=NO;
    }
}




-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
