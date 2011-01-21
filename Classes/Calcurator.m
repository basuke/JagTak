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

- (void)executeOperation;
- (void)updateResult;
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
		self.engine = [[[CalcEngine alloc] init] autorelease];
		
		[self updateResult];
		
		self.entering = @"";
		self.currentOperator = nil;
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
	
	[self.engine clear];
	[self updateResult];
}

- (void)negative {
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}

#pragma mark Logic

- (void)executeOperation {
	double value = [self.entering doubleValue];
	
	if ([self.currentOperator isEqual:@"+"]) {
		[self.engine add:value];
	} else if ([self.currentOperator isEqual:@"-"]) {
		[self.engine subtract:value];
	} else if ([self.currentOperator isEqual:@"*"]) {
		[self.engine multiply:value];
	} else if ([self.currentOperator isEqual:@"/"]) {
		[self.engine divide:value];
	} else {
		[self.engine store:value];
	}
	
	[self updateResult];
	[self clear];
}

- (void)updateResult {
	self.result = [self formatResult:[self.engine result]];;
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
