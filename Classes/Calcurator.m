//
//  Calcurator.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "Calcurator.h"
#import "CalcEngine.h"


@interface Calcurator()

@property(nonatomic, retain, readwrite) CalcEngine *engine;

- (double)add:(double)value;
- (double)subtract:(double)value;
- (double)multiply:(double)value;
- (double)divide:(double)value;

- (void)executeOperation;
- (NSString *)formatResult:(double)val;

@end


@implementation Calcurator

@synthesize result=_result;
@synthesize entering=_entering;
@synthesize currentOperator=_currentOperator;

@synthesize digitEntering=_digitEntering;

@synthesize engine=_engine;

- (id)init {
	if (self = [super init]) {
		self.result = @"";
		self.entering = @"";
		self.currentOperator = nil;
		
		self.engine = [[[CalcEngine alloc] init] autorelease];
	}
	return self;
}

- (void)dealloc {
	self.result = nil;
	self.entering = nil;
	self.currentOperator = nil;
	
	self.engine = nil;
	
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
	[self executeOperation];
	self.currentOperator = @"*";
}

- (void)hitDiv {
	[self executeOperation];
	self.currentOperator = @"/";
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
	double value = [self.entering doubleValue];
	
	if ([self.currentOperator isEqual:@"+"]) {
		value = [self add:value];
	} else if ([self.currentOperator isEqual:@"-"]) {
		value = [self subtract:value];
	} else if ([self.currentOperator isEqual:@"*"]) {
		value = [self multiply:value];
	} else if ([self.currentOperator isEqual:@"/"]) {
		value = [self divide:value];
	} else {
		value = value;
	}
	
	self.result = [self formatResult:value];;
	[self clear];
}

- (double)add:(double)vallue {
	double val1 = [self.result doubleValue];
	return val1 + vallue;
}

- (double)subtract:(double)vallue {
	double val1 = [self.result doubleValue];
	return val1 - vallue;
}

- (double)multiply:(double)vallue {
	double val1 = [self.result doubleValue];
	return val1 * vallue;
}

- (double)divide:(double)vallue {
	double val1 = [self.result doubleValue];
	return val1 / vallue;
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
