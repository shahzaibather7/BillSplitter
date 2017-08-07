//
//  ViewController.m
//  BillSplitter2
//
//  Created by Mohammad Shahzaib Ather on 2017-08-06.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic ) UILabel *billAmountLabel;
@property (nonatomic ) UILabel *splitAmountLabel;
@property (nonatomic) UITextField *textField;
@property (nonatomic ,strong) UIGestureRecognizer *backgroundTap;
@property (nonatomic , strong) UISlider *mySlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createBillAmountLabel];
    [self createTextField];
    [self createBackgroundTapGestureRecognizer];
    [self createSlider];
    [self createSplitBillLabel];
}

-(void) createBillAmountLabel {
    
    self.billAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    self.billAmountLabel.text = @"BILL AMOUNT";
    self.billAmountLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:self.billAmountLabel];
}
-(void) createTextField {
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.font = [UIFont boldSystemFontOfSize:25];
    self.textField.tag = 2;
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textField];
}

-(void) createSlider {
    self.mySlider = [[UISlider alloc]initWithFrame:CGRectMake(100, 350, 200, 20)];
    [self.mySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.mySlider.minimumValue = 2.0;
    self.mySlider.maximumValue = 8.0;
    [self.view addSubview:self.mySlider];
   }

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    self.mySlider.value = sender.value;
    float tempFloat = [self.textField.text floatValue];
    float tempFloat2 = self.mySlider.value;
    self.splitAmountLabel.text = [NSString stringWithFormat:@"Split Bill Amount:$ %.2f" ,tempFloat / tempFloat2];
    NSLog(@"%f", tempFloat2);
    
}

-(void) createSplitBillLabel {
    self.splitAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 450, 200, 20)];
  
    [self.view addSubview:self.splitAmountLabel];
}

-(void)createBackgroundTapGestureRecognizer {
    self.backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroudWasTapped)];
    [self.view addGestureRecognizer:self.backgroundTap];
}
-(void)backgroudWasTapped {
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 2){
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return !([newString length] > 3);
    } else{
        return true;
    }
}

@end
