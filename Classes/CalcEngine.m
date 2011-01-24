//
//  CalcEngine.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcEngine.h"


@implementation CalcEngine

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
	_result /= [value doubleValue];
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
}

@end
