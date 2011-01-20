//
//  Calcurator.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "Calcurator.h"


@interface Calcurator()

- (void)executeOperation;
- (void)add;
- (void)subtract;
- (NSString *)formatResult:(double)val;

@end


@implementation Calcurator

@synthesize result=_result;
@synthesize entering=_entering;
@synthesize currentOperator=_currentOperator;

@synthesize digitEntering=_digitEntering;

- (id)init {
	if (self = [super init]) {
		self.result = @"";
		self.entering = @"";
		self.currentOperator = nil;
	}
	return self;
}

- (void)dealloc {
	self.result = nil;
	self.entering = nil;
	self.currentOperator = nil;
	
	[super dealloc];
}

- (void)typeDigit:(NSInteger)digit {
	if ([self.entering isEqual:@"0"]) {
		self.entering = @"";
	}
	
	self.entering = [self.entering stringByAppendingFormat:@"%d", digit];
}

- (void)typeDot {
	if (self.digitEntering) {
		return;
	}
	
	if ([self.entering length] == 0) {
		self.entering = @"0";
	}
	
	self.entering = [self.entering stringByAppendingString:@"."];
	self.digitEntering = YES;
}

- (void)hitPlus {
	[self executeOperation];
	self.currentOperator = @"+";
}

- (void)hitMinus {	
	[self executeOperation];
	self.currentOperator = @"-";
}

- (void)hitMul {
}

- (void)hitDiv {
	
}

- (void)hitEqual {
	if ([self.entering length] > 0) {
		[self executeOperation];
	}
}

- (void)clear {
	self.entering = @"";
	self.digitEntering = NO;
	self.currentOperator = nil;
}

- (void)allClear {
	[self clear];
	
	self.result = @"";
}

- (void)negative {
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}

#pragma mark Logic

- (void)executeOperation {
	if ([self.currentOperator isEqual:@"+"]) {
		[self add];
	} else if ([self.currentOperator isEqual:@"-"]) {
		[self subtract];
	} else {
		self.result = self.entering;
	}
	
	[self clear];
}

- (void)add {
	double val1 = [self.result doubleValue];
	double val2 = [self.entering doubleValue];
	double val3 = val1 + val2;
	
	self.result = [self formatResult:val3];;
}

- (void)subtract {
	double val1 = [self.result doubleValue];
	double val2 = [self.entering doubleValue];
	double val3 = val1 - val2;
	
	self.result = [self formatResult:val3];
}

- (NSString *)formatResult:(double)val {
	NSMutableString *str = [NSMutableString stringWithFormat:@"%.12f", val];
	
	while ([str length] > 0) {
		NSInteger pos = [str length] - 1;
		unichar c = [str characterAtIndex:pos];
		if (c != '0' && c != '.') break;
		
		[str deleteCharactersInRange:NSMakeRange(pos, 1)];
		
		if (c == '.') break;
	}
	
	return str;
}

@end
