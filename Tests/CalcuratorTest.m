//
//  CalcuratorTest.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcuratorTest.h"
#import "Calcurator.h"


@implementation CalcuratorTest

/**
 * 簡単な入力からテスト。
 */
- (void)testSimpleEntryDisplay {
	Calcurator *calc = [[[Calcurator alloc] init] autorelease];
	
    STAssertEquals(calc.entering, @"", @"Empty" );
	
	[calc typeDigit:0];
    STAssertTrue([calc.entering isEqual:@"0"], calc.entering);
	
	[calc typeDigit:0];
    STAssertTrue([calc.entering isEqual:@"0"], calc.entering);
    
	[calc typeDigit:1];
    STAssertTrue([calc.entering isEqual:@"1"], calc.entering);
	
	[calc typeDigit:0];
    STAssertTrue([calc.entering isEqual:@"10"], calc.entering);
    
	[calc typeDigit:1];
	[calc typeDigit:2];
	[calc typeDigit:3];
    STAssertTrue([calc.entering isEqual:@"10123"], calc.entering);
	
	[calc clear];
    STAssertEquals(calc.entering, @"", @"Empty again");
}

@end
