//
//  Calcurator.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "Calcurator.h"


@interface Calcurator()

@end


@implementation Calcurator

@synthesize result=_result;
@synthesize entering=_entering;

@synthesize digitEntering=_digitEntering;

- (id)init {
	if (self = [super init]) {
		self.result = @"";
		self.entering = @"";
	}
	return self;
}

- (void)dealloc {
	self.result = nil;
	self.entering = nil;
	
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
}

- (void)hitMinus {	
}

- (void)hitMul {
}

- (void)hitDiv {
	
}

- (void)hitEqual {
}

- (void)clear {
	self.entering = @"";
	self.digitEntering = NO;
}

- (void)negative {
}

- (void)digitAssistWithPlaces:(NSInteger)places {
}


@end
