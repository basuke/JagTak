//
//  EnteringValue.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/24.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "EnteringValue.h"


@interface EnteringValue()

@end


@implementation EnteringValue

@synthesize active=_active;
@synthesize value=_value;
@synthesize digit=_digit;

- (id)init {
	if (self = [super init]) {
		[self clear];
	}
	
	return self;
}

- (double)doubleValue {
	return [self.value doubleValue];
}

- (void)typeDigit:(NSInteger)digit {
	if ([self.value isEqual:@"0"]) {
		self.value = @"";
	}
	
	self.value = [self.value stringByAppendingFormat:@"%d", digit];
	self.active = YES;
}

- (void)typeDot {
	if (self.digit) {
		return;
	}
	
	self.value = [self.value stringByAppendingString:@"."];
	self.digit = YES;
	self.active = YES;
}

- (void)clear {
	self.value = @"0";
	self.digit = NO;
	self.active = NO;
}

@end
