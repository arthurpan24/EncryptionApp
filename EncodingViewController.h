//
//  EncodingViewController.h
//  EncryptionApp
//
//  Created by Arthur Pan on 2/17/16.
//  Copyright © 2016 Arthur Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncodingViewController : UIViewController

- (void) initArrayOfPrimes:(int *)array withSize:(int)numberPrimes;
- (void) encode;

//- (int) gcdExtended:(int)a with:(int) b and:(int)x also:(int)y;
//- (int) modInverse:(int) a withMod:(int) m;
//- (int) bruteModInverse:(int)a withMod:(int)m;

-(int) mul_inv:(int) a withMod:(int)b;
- (int) binaryExponentiationBase:(int)x withPower:(int)n;


@end
