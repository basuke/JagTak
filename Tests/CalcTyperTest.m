//
//  CalcTyperTest.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcTyperTest.h"


@implementation CalcTyperTest

- (void)setUp {
	calc = [[Calcurator alloc] init];
	typer = [[CalcTyper alloc] init];
}

- (void)tearDown {
	[typer release];
	[calc release];
}

- (void)testType {
	NSString *typeKeys = @"123+456=";
	
    NSArray *types = [typer arrayWithType:typeKeys];
	NSArray *bingo = [NSArray arrayWithObjects:@"1", @"2", @"3", @"+", @"4", @"5", @"6", @"=", nil];
	STAssertEqualObjects(types, bingo, @"123+456=");
    
}

@end
