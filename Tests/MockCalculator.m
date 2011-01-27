//
//  MockCalculator.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/23.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "MockCalculator.h"


@implementation MockCalculator

- (id)init {
	if (self = [super init]) {
		counts = [[NSMutableDictionary dictionary] retain];
	}
	return self;
}

- (void)dealloc {
	[counts release];
	
	[super dealloc];
}

- (NSInteger)sentCount:(NSString *)key {
	return [[counts valueForKey:key] intValue];
}

- (void)resetCounts {
	[counts removeAllObjects];
}

- (void)countForKey:(NSString *)key {
	NSInteger count = [self sentCount:key];
	[counts setValue:[NSNumber numberWithInt:count + 1] forKey:key];
}

- (void)typeDigit:(NSInteger)digit {
	[self countForKey:[NSString stringWithFormat:@"%d", digit]];
}

- (void)typeDot {
	[self countForKey:@"."];
}

- (void)hitPlus {
	[self countForKey:@"+"];
}

- (void)hitMinus {	
	[self countForKey:@"-"];
}

- (void)hitMul {
	[self countForKey:@"*"];
}

- (void)hitDiv {
	[self countForKey:@"/"];
}

- (void)hitEqual {
	[self countForKey:@"="];
}

- (void)clear {
	[self countForKey:@"c"];
}

- (void)allClear {
	[self countForKey:@"C"];
}

- (void)negative {
	[self countForKey:@"N"];
}

- (void)digitAssistWithPlaces:(NSInteger)places {
	NSString *key;
	
	switch (places) {
		case 8:
			key = @"億";
			break;
		case 6:
			key = @"B";
			break;
		case 4:
			key = @"万";
			break;
		case 3:
			key = @"千";
			break;
		case 2:
			key = @"H";
			break;
		default:
			key = [NSString stringWithFormat:@"DA%d", places];
			break;
	}
	[self countForKey:key];
}

@end

