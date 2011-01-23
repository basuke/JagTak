//
//  CalcTyperTest.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcTyperTest.h"
#import "MockCalculator.h"

@implementation CalcTyperTest

- (void)setUp {
	typer = [[CalcTyper alloc] init];
}

- (void)tearDown {
	[typer release];
}

- (void)testType {
	NSString *typeKeys = @"123+456=";
	
    NSArray *types = [typer arrayWithType:typeKeys];
	NSArray *bingo = [NSArray arrayWithObjects:@"1", @"2", @"3", @"+", @"4", @"5", @"6", @"=", nil];
	STAssertEqualObjects(types, bingo, @"123+456=");
    
	MockCalculator *calc = [[[MockCalculator alloc] init] autorelease];
	
	[typer type:typeKeys to:calc];
	STAssertEquals([calc sentCount:@"1"], 1, @"1 is once");
	STAssertEquals([calc sentCount:@"5"], 1, @"5 is once");
	STAssertEquals([calc sentCount:@"+"], 1, @"+ is once");
	STAssertEquals([calc sentCount:@"="], 1, @"= is once");
	
	STAssertEquals([calc sentCount:@"7"], 0, @"7 was to typed.");
	
	[calc resetCounts];
	
	[typer type:@"123456789+-*/=.cCN" to:calc];
    for (NSString *c in [typer arrayWithType:typeKeys]) {
		STAssertEquals([calc sentCount:c], 1, c);
	}
}

@end

