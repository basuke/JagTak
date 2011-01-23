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

- (void)type:(NSString *)types to:(id<Calculator>)calc {
	for (NSString *key in [self arrayWithType:types]) {
		unichar c = [key characterAtIndex:0];
		
		switch (c) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				[calc typeDigit:(c - '0')];
				break;
			case '.':
				[calc typeDot];
				break;
			case '+':
				[calc hitPlus];
				break;
			case '-':
				[calc hitMinus];
				break;
			case '*':
				[calc hitMul];
				break;
			case '/':
				[calc hitDiv];
				break;
			case '=':
				[calc hitEqual];
				break;
			case 'c':
				[calc clear];
				break;
			case 'C':
				[calc allClear];
				break;
			case 'N':
				[calc negative];
				break;
			default:
				break;
		}
	}
}

@end
