//
//  CalcEngine.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcEngine.h"


@implementation CalcEngine

- (void)store:(double)value {
	_result = value;
}

- (void)add:(double)value {
	_result += value;
}

- (void)subtract:(double)value {
	_result -= value;
}

- (void)multiply:(double)value {
	_result *= value;
}

- (void)divide:(double)value {
	_result /= value;
}

- (double)result {
	return _result;
}

- (void)clear {
	_result = 0.0;
}

@end
