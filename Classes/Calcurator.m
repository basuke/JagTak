//
//  Calcurator.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "Calcurator.h"


@interface Calcurator()

@property(nonatomic, retain, readwrite) NSDictionary *operations;
@property(nonatomic, assign, readwrite) double value;

- (void)readEnteringValue;
- (void)executeOperation;
- (void)applyResult;
- (NSString *)formatResult:(double)val;

@end


#define CalcOpPlus @"+"
#define CalcOpMinus @"-"
#define CalcOpMul @"*"
#define CalcOpDiv @"/"

@implementation Calcurator

@synthesize display=_display;

@synthesize entering=_entering;
@synthesize value=_value;
@synthesize currentOperator=_currentOperator;

@synthesize engine=_engine;
@synthesize operations=_operations;

- (id)init {
	if (self = [super init]) {
		self.engine = [[[CalcEngine alloc] init] autorelease];
		self.entering = [[[EnteringValue alloc] init] autorelease];
		
		[self applyResult];
		
		self.currentOperator = @"";
		
		self.operations = [NSDictionary dictionaryWithObjectsAndKeys:
						   @"add:", CalcOpPlus, 
						   @"subtract:", CalcOpMinus, 
						   @"multiply:", CalcOpMul, 
						   @"divide:", CalcOpDiv, 
						   @"store:", @"", 
						   nil];
	}
	
	return self;
}

- (void)dealloc {
	self.display = nil;
	
	self.entering = nil;
	self.currentOperator = nil;
	
	self.engine = nil;
	self.operations = nil;
	
	[super dealloc];
}

- (void)typeDigit:(NSInteger)digit {
	[self.entering typeDigit:digit];
	
	self.display = self.entering.value;
}

- (void)typeDot {
	[self.entering typeDot];
	
	self.display = self.entering.value;
}

- (void)hitPlus {
	[self readEnteringValue];
	[self executeOperation];
	self.currentOperator = CalcOpPlus;
}

- (void)hitMinus {	
	[self readEnteringValue];
	[self executeOperation];
	self.currentOperator = CalcOpMinus;
}

- (void)hitMul {
	[self readEnteringValue];
	[self executeOperation];
	self.currentOperator = CalcOpMul;
}

- (void)hitDiv {
	[self readEnteringValue];
	[self executeOperation];
	self.currentOperator = CalcOpDiv;
}

- (void)hitEqual {
	if (self.entering.active) {
		[self readEnteringValue];
	}
	[self executeOperation];
}

- (void)clear {
	if (self.entering.active) {
		[self.entering clear];
	} else {
		[self.engine clearResult];
	}
	
	[self.engine clearError];
	[self applyResult];
}

- (void)allClear {
	[self.entering clear];
	self.currentOperator = @"";
	[self.engine clearResult];
	[self.engine clearError];
	
	[self applyResult];
}

- (void)negative {
	if (self.entering.active) {
		[self.entering negative];
		
		self.display = self.entering.value;
	} else {
		[self.engine negative];
		
		[self applyResult];
	}
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}

#pragma mark Logic

- (void)readEnteringValue {
	self.value = [self.entering doubleValue];
}

- (void)executeOperation {
	NSString *op = [self.operations objectForKey:self.currentOperator];
	SEL opSel= NSSelectorFromString(op);
	
	[self.engine performSelector:opSel withObject:[NSNumber numberWithDouble:self.value]];
	if (self.engine.error) {
		return;
	}
	
	if (self.entering.active) {
		[self.entering clear];
	}
	
	[self applyResult];
}

- (void)applyResult {
	self.display = [self formatResult:[[self.engine result] doubleValue]];;
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
