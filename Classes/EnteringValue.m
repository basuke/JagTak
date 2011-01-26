//
//  EnteringValue.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/24.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "EnteringValue.h"


@interface EnteringValue()

@property(nonatomic, retain, readwrite) NSString *value;
@property(nonatomic, assign, readwrite) double assistingValue;

@end


@implementation EnteringValue

@synthesize active=_active;
@synthesize digit=_digit;
@synthesize closed=_closed;

@synthesize value=_value;
@synthesize assistingValue=_assistingValue;

- (id)init {
	if (self = [super init]) {
		[self clear];
	}
	
	return self;
}

- (void)dealloc {
	self.value = nil;
	
	[super dealloc];
}

- (double)doubleValue {
	double val = [self.value doubleValue];
	
	if (self.assistingValue) {
		val += self.assistingValue;
	}
	
	return val;
}

- (NSString *)displayValue {
	NSString *value;
	
	if (self.assistingValue) {
		double val = [self.value doubleValue];
		val += self.assistingValue;
		value = [NSString stringWithFormat:@"%d", (int)val];
	} else {
		value = self.value;
	}
	
	return value;
}

- (void)typeDigit:(NSInteger)digit {
	if (self.closed) {
		[self clear];
	}
	
	if ([self.value isEqual:@"0"]) {
		self.value = @"";
	}
	
	self.value = [self.value stringByAppendingFormat:@"%d", digit];
	self.active = YES;
}

- (void)typeDot {
	if (self.closed) {
		[self clear];
	}
	
	if (self.digit) {
		return;
	}
	
	self.value = [self.value stringByAppendingString:@"."];
	self.digit = YES;
	self.active = YES;
}

- (void)negative {
	if ([self.value isEqual:@"0"]) {
		return;
	}
	
	if ([self.value characterAtIndex:0] == '-') {
		self.value = [self.value substringFromIndex:1];
	} else {
		self.value = [@"-" stringByAppendingString:self.value];
	}
	self.closed = YES;
}

- (void)clear {
	self.value = @"0";
	self.digit = NO;
	self.active = NO;
	self.closed = NO;
	self.assistingValue = 0;
}

- (void)digitAssistWithPlaces:(NSInteger)places {
	double val = [self.value doubleValue];
	for (int i = 0; i < places; i++) {
		val *= 10;
	}
	
	self.assistingValue = val;
	self.value = @"";
}

@end
