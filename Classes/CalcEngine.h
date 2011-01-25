//
//  CalcEngine.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *CalcErrorDivideByZero;

@interface CalcEngine : NSObject {
	double _result;
}

- (void)store:(NSNumber *)value;

- (void)add:(NSNumber *)value;
- (void)subtract:(NSNumber *)value;
- (void)multiply:(NSNumber *)value;
- (void)divide:(NSNumber *)value;

- (void)negative;

- (NSNumber *)result;

- (void)clear;
- (void)clearError;

@property(nonatomic, assign, readwrite) BOOL error;
@property(nonatomic, retain, readwrite) NSString *errorReason;

@end
