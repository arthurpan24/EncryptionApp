//
//  EncodingViewController.m
//  EncryptionApp
//
//  Created by Arthur Pan on 2/17/16.
//  Copyright © 2016 Arthur Pan. All rights reserved.
//

#import "EncodingViewController.h"
#import "SieveOfEratosthenes.h"
#import "JKBigInteger.h" //Imported Library to handle big integers

#include <stdlib.h>

@interface EncodingViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UILabel *key1;
@property (weak, nonatomic) IBOutlet UILabel *key2;
@property (weak, nonatomic) IBOutlet UILabel *privateKey;
@property (weak, nonatomic) IBOutlet UITextView *encodedText;
@property (weak, nonatomic) IBOutlet UIButton *generateButton;

- (IBAction)handleButtonClick:(id)sender;

@property int p;
@property int q;
@property int n;
@property int totient;
@property int d;
@property int e;

@end

@implementation EncodingViewController

NSMutableArray *inputString;
int *arr; //this might be a bad implementation
int numPrime;

- (void) initArrayOfPrimes:(int *)array withSize:(int)numberPrimes{
    arr = array;
    numPrime = numberPrimes;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        //Set the tab bar item's title
        self.tabBarItem.title = @"encodingVC";
        
        
        //Create a UIImage from a file
        //This will use Hypno@2x.png on retina display devices
        //UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        //Put that image on the tab bar item
        //self.tabBarItem.image = image;
    }
    return self;
}

-(int)getN{
    return _n;
}

-(int)getD{
    return _d;
}

-(int)getE{
    return _e;
}

- (void) generateKeys {
    _p = arc4random_uniform((int)(numPrime-1)/2) + (int)(numPrime-1)/2;
    _q = arc4random_uniform((int)(numPrime-1)/2) + (int)(numPrime-1)/2;
    _n = _p * _q;
    _totient = (_p-1)*(_q-1);
    _d = arr[numPrime-1];
    _e = [self mul_inv:_d withMod:_totient];
    
    NSLog(@"e value: %d", _e);
    NSLog(@"p value: %d", _p);
    NSLog(@"q value: %d", _q);
    NSLog(@"d value: %d", _d);
    NSLog(@"totient value: %d", _totient);
    NSLog(@"n value: %d", _n);
}

//OK, this works, but is this brute force or nah?
-(int) mul_inv:(int) a withMod:(int)b
{
    int b0 = b, t, q;
    int x0 = 0, x1 = 1;
    if (b == 1) return 1;
    while (a > 1) {
        q = a / b;
        t = b, b = a % b, a = t;
        t = x0, x0 = x1 - q * x0, x1 = t;
    }
    if (x1 < 0) x1 += b0;
    return x1;
}

//for if we want to do exponentials fast with smaller numbers
- (int) binaryExponentiationBase:(int)x withPower:(int)n {
    if (n ==0)
        return 1;
    else if (n == 1)
        return x;
    else if (n%2 == 0)
        return [self binaryExponentiationBase:(x*x) withPower:(n/2)];
    else if (n%2 != 0)
        return [self binaryExponentiationBase:(x*x) withPower:((n-1)/2)];
    return -1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_userInput setDelegate:self];
   // NSString* testPrint = [_userInput text];
    //NSLog(@"echo %@", testPrint);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _userInput.placeholder = @"Encode this";
    _userInput.returnKeyType = UIReturnKeyDone;
    
    _encodedText.text = @"";
    _key1.text = @"";
    _key2.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@", _userInput.text);
    _encodedText.text = _userInput.text;

    [self encode];
    [textField resignFirstResponder];
    return YES;
}

- (void)encode {
    if (![_userInput.text isEqual:@""]){
        inputString = [NSMutableArray array];
        
        NSString *str = _userInput.text;
        NSMutableString *returnString = [[NSMutableString alloc]init];
        NSString *tempString;

        JKBigInteger *mod_inverse = [[JKBigInteger alloc] initWithUnsignedLong:(unsigned long)_e];
        JKBigInteger *mod = [[JKBigInteger alloc] initWithUnsignedLong:(unsigned long)_n];
        
        
        for (int i = 0; i < [str length]; i++) {
            NSString *character = [str substringWithRange:NSMakeRange(i, 1)];
            [inputString addObject:character];
            JKBigInteger *item = [[JKBigInteger alloc] initWithUnsignedLong:(unsigned long)inputString[i]];
            tempString = [NSString stringWithFormat:@"%@ ",[item pow:mod_inverse andMod:mod]];
            [returnString appendString:tempString];
        }
        _encodedText.text = returnString;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handleButtonClick:(id)sender {
    _key1.text = [NSString stringWithFormat:@"%d", _n];
    _key2.text = [NSString stringWithFormat:@"%d", _e];
}

@end
