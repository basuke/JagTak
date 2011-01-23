//
//  CalcuratorTest.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcuratorTest.h"


@implementation CalcuratorTest

- (void)setUp {
	calc = [[Calcurator alloc] init];
	typer = [[CalcTyper alloc] init];
	
	[typer setCalc:calc];
}

- (void)tearDown {
	[typer release];
	[calc release];
}

/**
 * 簡単な入力からテスト。
 */
- (void)testSimpleEntryDisplay {
    STAssertEquals(calc.entering, @"", @"Empty" );
	
	[typer type:@"0"];
    STAssertTrue([calc.entering isEqual:@"0"], calc.entering);
	
	[typer type:@"0"];
    STAssertTrue([calc.entering isEqual:@"0"], calc.entering);
    
	[typer type:@"1"];
    STAssertTrue([calc.entering isEqual:@"1"], calc.entering);
	
	[typer type:@"0"];
    STAssertTrue([calc.entering isEqual:@"10"], calc.entering);
    
	[typer type:@"123"];
    STAssertTrue([calc.entering isEqual:@"10123"], calc.entering);
	
	[calc clear];
    STAssertEquals(calc.entering, @"", @"Empty again");
}

/**
 * 小数点の入力をテスト
 */
- (void)testDot {
	[typer type:@"c 1.23"];
    STAssertTrue([calc.entering isEqual:@"1.23"], calc.entering);
	
	// .で始めたら0が先頭につく
	[typer type:@"c .123"];
    STAssertTrue([calc.entering isEqual:@"0.123"], calc.entering);
	
	// 最後の.は有効
	[typer type:@"c 123."];
    STAssertTrue([calc.entering isEqual:@"123."], calc.entering);
	
	// 連続して入力しても一度のみ
	[typer type:@"c 1...23"];
    STAssertTrue([calc.entering isEqual:@"1.23"], calc.entering);
	
	// 間をおいて二度入れても無効
	[typer type:@"c 12.3.4"];
    STAssertTrue([calc.entering isEqual:@"12.34"], calc.entering);
	
}

/**
 * + のテスト
 */
- (void)testPlus {
	// 1 + 2 = 3
	[typer type:@"c 1"];
    STAssertTrue([calc.entering isEqual:@"1"], calc.entering);
	
	[typer type:@"+ 2"];
	STAssertTrue([calc.entering isEqual:@"2"], calc.entering);
	
	[typer type:@"="];
    STAssertTrue([calc.result isEqual:@"3"], calc.result);
	
	[typer type:@"C 1 + 2 + 3 + 4 ="];
    STAssertTrue([calc.result isEqual:@"10"], calc.result);
}

/**
 * - のテスト
 */
- (void)testMinus {
	[typer type:@"C 3 - 2 ="];
    STAssertTrue([calc.result isEqual:@"1"], calc.result);
	
	[typer type:@"C 10 - 6 - 4 - 3 ="];
    STAssertTrue([calc.result isEqual:@"-3"], calc.result);
}

/**
 * + と - のミックスのテスト
 */
- (void)testPlusAndMinus {
	[typer type:@"C 3 + 4 - 5 = "];
    STAssertTrue([calc.result isEqual:@"2"], calc.result);
	
	[typer type:@"C 10 - 6 + 4 - 3 = "];
    STAssertTrue([calc.result isEqual:@"5"], calc.result);
}

/**
 * 小数の + のテスト
 */
- (void)testFractionalPlus {	// 4.2
	[typer type:@"C 1.5"];
    STAssertTrue([calc.entering isEqual:@"1.5"], calc.entering);
	
	[typer type:@"+"];
    STAssertTrue([calc.result isEqual:@"1.5"], calc.result);
	
	[typer type:@"2.7"];
    STAssertTrue([calc.entering isEqual:@"2.7"], calc.entering);
	
	[typer type:@"="];
    STAssertTrue([calc.result isEqual:@"4.2"], calc.result);
}

/**
 * x のテスト
 */
- (void)testMulti {
	[typer type:@"C 3 × 2 = "];
    STAssertTrue([calc.result isEqual:@"6"], calc.result);
	
	[typer type:@"C 10 * 6 * 4 * 3 = "];
    STAssertTrue([calc.result isEqual:@"720"], calc.result);
}

/**
 * ÷ のテスト
 */
- (void)testDiv {
	[typer type:@"C 6 ÷ 2 = "];
    STAssertTrue([calc.result isEqual:@"3"], calc.result);
	
	[typer type:@"C 720 / 6 / 4 / 3 = "];
    STAssertTrue([calc.result isEqual:@"10"], calc.result);
}

@end
