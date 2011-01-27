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
			case 0x2212: // −
				[calc hitMinus];
				break;
			case '*':
			case 'x':
			case 0x00D7: // ×
				[calc hitMul];
				break;
			case '/':
			case 0x00F7: // ÷
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
			case 0x00B1: // ±
				[calc negative];
				break;
			case 0x4EBF: // 亿
			case 0x5104: // 億
				[calc digitAssistWithPlaces:8];
				break;
			case 0x4E07: // 万
			case 0x842C: // 萬
				[calc digitAssistWithPlaces:4];
				break;
			case 0x5343: // 千
			case 0x4EDF: // 仟
				[calc digitAssistWithPlaces:3];
				break;
			case 'B':
				[calc digitAssistWithPlaces:6];
				break;
			case 'M':
				[calc digitAssistWithPlaces:3];
				break;
			case 'H':
				[calc digitAssistWithPlaces:2];
				break;
			case ' ':
				break;
			default:
				NSAssert1(NO, @"INVALID CHARACTER '%@", key);
				break;
		}
	}
}

- (void)setCalc:(id<Calculator>)calc {
	_calc = calc;
}

- (void)type:(NSString *)types {
	[self type:types to:_calc];
}

@end
