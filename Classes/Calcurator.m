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
@property(nonatomic, retain, readwrite) NSDictionary *operations;

@property(nonatomic, retain, readwrite) NSString *entering;

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
@synthesize currentOperator=_currentOperator;

@synthesize digitEntering=_digitEntering;

@synthesize engine=_engine;
@synthesize operations=_operations;

- (id)init {
	if (self = [super init]) {
		self.engine = [[[CalcEngine alloc] init] autorelease];
		
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
	if (self.entering == nil || [self.entering isEqual:@"0"]) {
		self.entering = @"";
	}
	
	self.entering = [self.entering stringByAppendingFormat:@"%d", digit];
	self.display = self.entering;
}

- (void)typeDot {
	if (self.digitEntering) {
		return;
	}
	
	if (self.entering == nil) {
		self.entering = @"0";
	}
	
	self.entering = [self.entering stringByAppendingString:@"."];
	self.display = self.entering;
	self.digitEntering = YES;
}

- (void)hitPlus {
	[self executeOperation];
	self.currentOperator = CalcOpPlus;
}

- (void)hitMinus {	
	[self executeOperation];
	self.currentOperator = CalcOpMinus;
}

- (void)hitMul {
	[self executeOperation];
	self.currentOperator = CalcOpMul;
}

- (void)hitDiv {
	[self executeOperation];
	self.currentOperator = CalcOpDiv;
}

- (void)hitEqual {
	if (self.entering) {
		[self executeOperation];
	}
}

- (void)clear {
	self.entering = nil;
	self.digitEntering = NO;
	self.currentOperator = @"";
	
	[self applyResult];
}

- (void)allClear {
	[self clear];
	
	[self.engine clear];
}

- (void)negative {
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}

#pragma mark Logic

- (void)executeOperation {
	double value = [self.entering doubleValue];
	
	NSString *op = [self.operations objectForKey:self.currentOperator];
	SEL opSel= NSSelectorFromString(op);
	
	[self.engine performSelector:opSel withObject:[NSNumber numberWithDouble:value]];
	
	[self clear];
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
