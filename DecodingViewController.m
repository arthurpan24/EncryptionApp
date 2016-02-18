//
//  DecodingViewController.m
//  EncryptionApp
//
//  Created by Arthur Pan on 2/17/16.
//  Copyright © 2016 Arthur Pan. All rights reserved.
//

#import "DecodingViewController.h"
#import "SieveOfEratosthenes.h"

@interface DecodingViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UITextField *key1Input;
@property (weak, nonatomic) IBOutlet UITextField *key2Input;
@property (weak, nonatomic) IBOutlet UITextField *privateKeyInput;
@property (weak, nonatomic) IBOutlet UITextView *decodedText;
- (IBAction)decodeButtonPressed:(id)sender;

@property int e;
@property int d;
@property int n;

@end

@implementation DecodingViewController

//int *arrayOfPrimes;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        //Set the tab bar item's title
        self.tabBarItem.title = @"decodingVC";
        
        
       // arrayOfPrimes = [SieveOfEratosthenes returnArrayOfPrimes];
        
        //Create a UIImage from a file
        //This will use Hypno@2x.png on retina display devices
        //UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        //Put that image on the tab bar item
        //self.tabBarItem.image = image;
    }
    return self;
}

-(void)initializeN:(int)n andE:(int)e andD:(int)d {
    _n = n;
    _e = e;
    _d = d;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _inputText.placeholder = @"Decode this";
    _inputText.returnKeyType = UIReturnKeyDone;
    _inputText.delegate = self;
    
    _key1Input.placeholder = @"key1";
    _key1Input.returnKeyType = UIReturnKeyDone;
    _key1Input.delegate = self;
    
    _key2Input.placeholder = @"key2";
    _key2Input.returnKeyType = UIReturnKeyDone;
    _key2Input.delegate = self;
    
    _decodedText.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@", _inputText.text);
    _decodedText.text = _inputText.text;
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)decode {
    if (![_key1Input isEqual:[NSString stringWithFormat:@"%d", _n]]
        || ![_key2Input isEqual:[NSString stringWithFormat:@"%d", _e]]
        || ![_key1Input isEqual:[NSString stringWithFormat:@"%d", _n]]){
        //this means that the user has entered the wrong public keys
        _decodedText.text = @"WRONG INPUT KEYS";
        return;
    }
    
    else {
        
    }
}

- (IBAction)decodeButtonPressed:(id)sender {
    NSLog(@"decode button pressed");
    [self decode];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
