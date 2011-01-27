//
//  EnteringValue.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/24.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "EnteringValue.h"

@interface AssistValue : NSObject

@property(nonatomic, assign, readwrite) long long value;
@property(nonatomic, assign, readwrite) long place;

@end


@implementation AssistValue

@synthesize value=_value;
@synthesize place=_place;

+ (AssistValue *)valueWithIntegers:(NSString *)integers places:(NSInteger)places {
	long long val;
	
	if (integers) {
		val = [integers longLongValue];
	} else {
		val = 1;
	}
	
	val *= pow(10, places);
	
	AssistValue *assist = [[AssistValue alloc] init];
	
	assist.value = val;
	assist.place = places;
	
	return [assist autorelease];
}

- (BOOL)isSmallerThan:(AssistValue *)assist {
	return self.place < assist.place;
}

- (void)merge:(AssistValue *)assist {
	self.value *= pow(10.0, assist.place);
	self.value += assist.value;
}

@end


@interface EnteringValue()

@property(nonatomic, retain, readwrite) NSString *integers;
@property(nonatomic, retain, readwrite) NSString *decimals;
@property(nonatomic, retain, readwrite) NSMutableArray *assists;

@end


@implementation EnteringValue

@synthesize active=_active;
@synthesize closed=_closed;

@synthesize integers=_integers;
@synthesize decimals=_decimals;
@synthesize assists=_assists;

- (id)init {
	if (self = [super init]) {
		[self clear];
	}
	
	return self;
}

- (void)dealloc {
	self.integers = nil;
	self.decimals = nil;
	self.assists = nil;
	
	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat:
			@"ACTIVE: %@ CLOSED: %@ INTEGERS: %@ DECIMALS: %@", 
			(self.active ? @"YES" : @"NO"),
			(self.closed ? @"YES" : @"NO"),
			self.integers, 
			self.decimals, 
			nil];
}

- (long long)integerValue {
	long long val = 0;
	
	for (AssistValue *assist in self.assists) {
		val += assist.value;
	}
	
	if (self.integers) {
		val += [self.integers longLongValue];
	}
	
	return val;
}

- (double)doubleValue {
	double val = [self integerValue];
	
	if ([self.decimals length] > 0) {
		double d = [self.decimals longLongValue];
		d /= pow(10, [self.decimals length]);
		val += d;
	}
	
	return val;
}

- (NSString *)displayValue {
	NSMutableString *value = [NSMutableString stringWithCapacity:20];
	
	[value appendFormat:@"%ld", [self integerValue]];
	
	if (self.decimals) {
		[value appendString:@"."];
		[value appendString:self.decimals];
	}
	
	return [NSString stringWithString:value];
}

- (void)typeDigit:(NSInteger)digit {
	if (self.closed) {
		[self clear];
	}
	
	NSString *digitChar = [NSString stringWithFormat:@"%d", digit];
	
	if (self.decimals) {
		self.decimals = [self.decimals stringByAppendingString:digitChar];
	} else {
		if (self.integers) {
			self.integers = [self.integers stringByAppendingString:digitChar];
		} else if (digit) {
			self.integers = digitChar;
		}
	}

	self.active = YES;
}

- (void)typeDot {
	if (self.closed) {
		[self clear];
	}
	
	if (self.decimals) {
		return;
	}
	
	self.decimals = @"";
	self.active = YES;
}

- (void)negative {
	if (! self.integers) {
		return;
	}
	
	if ([self.integers characterAtIndex:0] == '-') {
		self.integers = [self.integers substringFromIndex:1];
	} else {
		self.integers = [@"-" stringByAppendingString:self.integers];
	}
	
	self.closed = YES;
}

- (void)clear {
	self.integers = nil;
	self.decimals = nil;
	self.active = NO;
	self.closed = NO;
	
	self.assists = [NSMutableArray arrayWithCapacity:5];
}

- (void)digitAssistWithPlaces:(NSInteger)places {
	AssistValue *assist = [AssistValue valueWithIntegers:self.integers places:places];
	self.integers = nil;
	
	for (AssistValue *assist2 in self.assists) {
		if ([assist2 isSmallerThan:assist]) {
			[assist2 merge:assist];
			return;
		}
	}
	
	[self.assists addObject:assist];
}

@end
