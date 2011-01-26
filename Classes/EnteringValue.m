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

@end


@implementation EnteringValue

@synthesize active=_active;
@synthesize value=_value;
@synthesize digit=_digit;
@synthesize closed=_closed;

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
	return [self.value doubleValue];
}

- (NSString *)displayValue {
	return self.value;
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
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}

@end
