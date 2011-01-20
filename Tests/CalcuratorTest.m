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

/**
 * 小数点の入力をテスト
 */
- (void)testDot {
	Calcurator *calc = [[[Calcurator alloc] init] autorelease];
	
	[calc clear];
	[calc typeDigit:1];
	[calc typeDot];
	[calc typeDigit:2];
	[calc typeDigit:3];
    STAssertTrue([calc.entering isEqual:@"1.23"], calc.entering);
	
	// .で始めたら0が先頭につく
	[calc clear];
	[calc typeDot];
	[calc typeDigit:1];
	[calc typeDigit:2];
	[calc typeDigit:3];
    STAssertTrue([calc.entering isEqual:@"0.123"], calc.entering);
	
	// 最後の.は有効
	[calc clear];
	[calc typeDigit:1];
	[calc typeDigit:2];
	[calc typeDigit:3];
	[calc typeDot];
    STAssertTrue([calc.entering isEqual:@"123."], calc.entering);
	
	// 連続して入力しても一度のみ
	[calc clear];
	[calc typeDigit:1];
	[calc typeDot];
	[calc typeDot];
	[calc typeDot];
	[calc typeDigit:2];
	[calc typeDigit:3];
    STAssertTrue([calc.entering isEqual:@"1.23"], calc.entering);
	
	// 間をおいて二度入れても無効
	[calc clear];
	[calc typeDigit:1];
	[calc typeDigit:2];
	[calc typeDot];
	[calc typeDigit:3];
	[calc typeDot];
	[calc typeDigit:4];
    STAssertTrue([calc.entering isEqual:@"12.34"], calc.entering);
	
}

/**
 * + のテスト
 */
- (void)testPlus {
	Calcurator *calc = [[[Calcurator alloc] init] autorelease];
	
	// 1 + 2 = 3
	[calc clear];
	[calc typeDigit:1];
    STAssertTrue([calc.entering isEqual:@"1"], calc.entering);
	
	[calc hitPlus];
	
	[calc typeDigit:2];
	STAssertTrue([calc.entering isEqual:@"2"], calc.entering);
	
	[calc hitEqual];
    STAssertTrue([calc.result isEqual:@"3"], calc.result);
	
	// 1 + 2 + 3 + 4 = 10
	[calc allClear];
	[calc typeDigit:1];
	
	[calc hitPlus];
	[calc typeDigit:2];
	
	[calc hitPlus];
	[calc typeDigit:3];
	
	[calc hitPlus];
	[calc typeDigit:4];
	
	[calc hitEqual];
    STAssertTrue([calc.result isEqual:@"10"], calc.result);
}

/**
 * - のテスト
 */
- (void)testMinus {
	Calcurator *calc = [[[Calcurator alloc] init] autorelease];
	
	// 3 - 2 = 1
	[calc clear];
	[calc typeDigit:3];
	[calc hitMinus];
	[calc typeDigit:2];
	[calc hitEqual];
    STAssertTrue([calc.result isEqual:@"1"], calc.result);
	
	// 10 - 6 - 4 - 3 = -3
	[calc allClear];
	[calc typeDigit:1];
	[calc typeDigit:0];
	
	[calc hitMinus];
	[calc typeDigit:6];
	
	[calc hitMinus];
	[calc typeDigit:4];
	
	[calc hitMinus];
	[calc typeDigit:3];
	
	[calc hitEqual];
    STAssertTrue([calc.result isEqual:@"-3"], calc.result);
}

@end
