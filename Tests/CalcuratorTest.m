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
    STAssertTrue([calc.display isEqual:@"0"], calc.display);
	
	[typer type:@"0"];
    STAssertTrue([calc.display isEqual:@"0"], calc.display);
	
	[typer type:@"0"];
    STAssertTrue([calc.display isEqual:@"0"], calc.display);
    
	[typer type:@"1"];
    STAssertTrue([calc.display isEqual:@"1"], calc.display);
	
	[typer type:@"0"];
    STAssertTrue([calc.display isEqual:@"10"], calc.display);
    
	[typer type:@"123"];
    STAssertTrue([calc.display isEqual:@"10123"], calc.display);
	
	[calc clear];
    STAssertEquals(calc.display, @"", @"Empty again");
}

/**
 * 小数点の入力をテスト
 */
- (void)testDot {
	[typer type:@"c 1.23"];
    STAssertTrue([calc.display isEqual:@"1.23"], calc.display);
	
	// .で始めたら0が先頭につく
	[typer type:@"c .123"];
    STAssertTrue([calc.display isEqual:@"0.123"], calc.display);
	
	// 最後の.は有効
	[typer type:@"c 123."];
    STAssertTrue([calc.display isEqual:@"123."], calc.display);
	
	// 連続して入力しても一度のみ
	[typer type:@"c 1...23"];
    STAssertTrue([calc.display isEqual:@"1.23"], calc.display);
	
	// 間をおいて二度入れても無効
	[typer type:@"c 12.3.4"];
    STAssertTrue([calc.display isEqual:@"12.34"], calc.display);
	
}

/**
 * + のテスト
 */
- (void)testPlus {
	// 1 + 2 = 3
	[typer type:@"c 1"];
    STAssertTrue([calc.display isEqual:@"1"], calc.display);
	
	[typer type:@"+ 2"];
	STAssertTrue([calc.display isEqual:@"2"], calc.display);
	
	[typer type:@"="];
    STAssertTrue([calc.display isEqual:@"3"], calc.display);
	
	[typer type:@"C 1 + 2 + 3 + 4 ="];
    STAssertTrue([calc.display isEqual:@"10"], calc.display);
}

/**
 * - のテスト
 */
- (void)testMinus {
	[typer type:@"C 3 - 2 ="];
    STAssertTrue([calc.display isEqual:@"1"], calc.display);
	
	[typer type:@"C 10 - 6 - 4 - 3 ="];
    STAssertTrue([calc.display isEqual:@"-3"], calc.display);
}

/**
 * + と - のミックスのテスト
 */
- (void)testPlusAndMinus {
	[typer type:@"C 3 + 4 - 5 = "];
    STAssertTrue([calc.display isEqual:@"2"], calc.display);
	
	[typer type:@"C 10 - 6 + 4 - 3 = "];
    STAssertTrue([calc.display isEqual:@"5"], calc.display);
}

/**
 * 小数の + のテスト
 */
- (void)testFractionalPlus {	// 4.2
	[typer type:@"C 1.5"];
    STAssertTrue([calc.display isEqual:@"1.5"], calc.display);
	
	[typer type:@"+"];
    STAssertTrue([calc.display isEqual:@"1.5"], calc.display);
	
	[typer type:@"2.7"];
    STAssertTrue([calc.display isEqual:@"2.7"], calc.display);
	
	[typer type:@"="];
    STAssertTrue([calc.display isEqual:@"4.2"], calc.display);
}

/**
 * x のテスト
 */
- (void)testMulti {
	[typer type:@"C 3 × 2 = "];
    STAssertTrue([calc.display isEqual:@"6"], calc.display);
	
	[typer type:@"C 10 * 6 * 4 * 3 = "];
    STAssertTrue([calc.display isEqual:@"720"], calc.display);
}

/**
 * ÷ のテスト
 */
- (void)testDiv {
	[typer type:@"C 6 ÷ 2 = "];
    STAssertTrue([calc.display isEqual:@"3"], calc.display);
	
	[typer type:@"C 720 / 6 / 4 / 3 = "];
    STAssertTrue([calc.display isEqual:@"10"], calc.display);
}

@end
