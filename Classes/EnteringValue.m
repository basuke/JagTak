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

@synthesize value=_value;
@synthesize digit=_digit;

- (id)init {
	if (self = [super init]) {
		self.value = @"0";
	}
	
	return self;
}

- (double)doubleValue {
	return [self.value doubleValue];
}

- (NSString *)stringValue {
	return self.value;
}

- (void)typeDigit:(NSInteger)digit {
	if ([self.value isEqual:@"0"]) {
		self.value = @"";
	}
	
	self.value = [self.value stringByAppendingFormat:@"%d", digit];
}

- (void)typeDot {
	if (self.digit) {
		return;
	}
	
	self.value = [self.value stringByAppendingString:@"."];
	self.digit = YES;
}

@end
