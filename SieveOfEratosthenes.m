//
//  SieveOfEratosthenes.m
//  EncryptionApp
//
//  Created by Arthur Pan on 2/17/16.
//  Copyright © 2016 Arthur Pan. All rights reserved.
//

#import "SieveOfEratosthenes.h"

@interface SieveOfEratosthenes()

@end

@implementation SieveOfEratosthenes

BOOL *arrayOfPrimes;
int maxNumber;


- (id) initWithSize:(int)maxNumber {
    self = [super init];
    if (self) {
        [self initializeArrayOfPrimes:maxNumber];
        [self createArrayOfPrimes];
    }
    return self;
}

+ (BOOL *) returnArrayOfPrimes {
    return arrayOfPrimes;
}

- (void) testPrime {
    NSLog(@"this works");
    
}

- (void) createArrayOfPrimes {
    NSLog(@"PRIMES UNDER %d: ", maxNumber);
    NSMutableString *testString = [[NSMutableString alloc]init];
    NSString *tempString;
    for (int i =0; i < maxNumber; i++){
        if (arrayOfPrimes[i] == YES){
            tempString = [NSString stringWithFormat:@"%d ", i];
            [testString appendString:tempString];
        }
    }
    NSLog(@"%@", testString);
    return;
}

- (void) initializeArrayOfPrimes:(int)maxSize {
    maxNumber = maxSize;
    arrayOfPrimes = malloc(maxNumber*sizeof(BOOL)); //allocate space for C-style array
    
    for (int i =0; i < maxNumber; i++){
        arrayOfPrimes[i] = YES;
    }
    
    [self sieveOfEratosthenes:maxNumber];
}

- (void)sieveOfEratosthenes:(int)maxNumber {
    //initialize 0 and 1 as false, assume that array is at least 2 ints long
    arrayOfPrimes[0] = NO;
    arrayOfPrimes[1] = NO;
    
    for (int j= 2; j < sqrt((double)maxNumber); j++){
        if (arrayOfPrimes[j]==YES){
            for (int k = 0; j*j + k*j <= maxNumber; k++){
                arrayOfPrimes[j*j + k*j] = NO;
            }
        }
    }
}



@end
