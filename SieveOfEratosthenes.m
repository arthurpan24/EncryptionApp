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
int *shortArrayOfPrimes;
int numberOfPrimes;


- (id) initWithSize:(int)maxNumber {
    self = [super init];
    if (self) {
        [self initializeArrayOfPrimes:maxNumber];
    }
    return self;
}

- (int) returnSize {
    return numberOfPrimes;
}

+ (BOOL *) returnArrayOfPrimes {
    return arrayOfPrimes;
}

- (int *) returnShortArrayOfPrimes {
    return shortArrayOfPrimes;
}

+ (void) testPrime {
    NSLog(@"this works");
    
}

- (void) createShortArrayOfPrimes {
    for (int i =0; i < maxNumber; i++){
        if (arrayOfPrimes[i] == YES){
            numberOfPrimes++;
        }
    }

    shortArrayOfPrimes = malloc(numberOfPrimes*sizeof(int));
    int z = 0;
    for (int j=0; j < maxNumber; j++) {
        if (arrayOfPrimes[j] == YES){
            shortArrayOfPrimes[z] = j;
            z++;
        }
    }
    
    NSLog(@"PRIMES UNDER %d: ", maxNumber);
    NSMutableString *testString2 = [[NSMutableString alloc]init];
    NSString *tempString2;
    for (int i =0; i < numberOfPrimes; i++){
        tempString2 = [NSString stringWithFormat:@"%d ", shortArrayOfPrimes[i]];
        [testString2 appendString:tempString2];
        
    }
    NSLog(@"%@", testString2);
    NSLog(@"number of primes: %d", numberOfPrimes);
    return;
}

- (void) initializeArrayOfPrimes:(int)maxSize {
    maxNumber = maxSize;
    arrayOfPrimes = malloc(maxNumber*sizeof(BOOL)); //allocate space for C-style array
    
    for (int i =0; i < maxNumber; i++){
        arrayOfPrimes[i] = YES;
    }
    
    [self sieveOfEratosthenes:maxNumber];
    [self createShortArrayOfPrimes];
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
