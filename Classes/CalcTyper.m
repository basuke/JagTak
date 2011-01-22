//
//  CalcTester.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcTyper.h"


@implementation CalcTyper

- (NSArray *)arrayWithType:(NSString *)types {
	NSMutableArray *components = [NSMutableArray array];
	
	for (int i = 0; i < [types length]; i++) {
		unichar c = [types characterAtIndex:i];
		[components addObject:[NSString stringWithCharacters:&c length:1]];
	}
	
	return [NSArray arrayWithArray:components];
}

@end
