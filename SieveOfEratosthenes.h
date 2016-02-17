//
//  SieveOfEratosthenes.h
//  EncryptionApp
//
//  Created by Arthur Pan on 2/17/16.
//  Copyright © 2016 Arthur Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SieveOfEratosthenes : NSObject

- (id) initWithSize:(int)maxSize;
+ (BOOL *) returnArrayOfPrimes;
- (int *) returnShortArrayOfPrimes;
- (int) returnSize;
+ (void) testPrime;
- (void) createShortArrayOfPrimes;

@end
