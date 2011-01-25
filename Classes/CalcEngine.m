//
//  CalcEngine.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcEngine.h"

NSString *CalcErrorDivideByZero = @"Calc/Error/DivideByZero";

@implementation CalcEngine

@synthesize error=_error;
@synthesize errorReason=_errorReason;

- (void)dealloc {
	self.errorReason = nil;
	
	[super dealloc];
}

- (void)store:(NSNumber *)value {
	_result = [value doubleValue];
}

- (void)add:(NSNumber *)value {
	_result += [value doubleValue];
}

- (void)subtract:(NSNumber *)value {
	_result -= [value doubleValue];
}

- (void)multiply:(NSNumber *)value {
	_result *= [value doubleValue];
}

- (void)divide:(NSNumber *)value {
	double val = [value doubleValue];
	if (val == 0.0) {
		self.error = YES;
		self.errorReason = CalcErrorDivideByZero;
		return;
	}
	
	_result /= val;
}

- (void)negative {
	if (_result != 0.0) {
		_result = -_result;
	}
}

- (NSNumber *)result {
	return [NSNumber numberWithDouble:_result];
}

- (void)clear {
	_result = 0.0;
	
	self.error = NO;
	self.errorReason = nil;
}

@end
