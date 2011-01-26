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
    STAssertTrue([calc.display isEqual:@"0"], calc.display);
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

/**
 *	+/- ボタンのテスト
 */
- (void)testNegative {
	[typer type:@"C 10 ±"];
    STAssertTrue([calc.display isEqual:@"-10"], @"10 ±");
	
	[typer type:@"±"];
    STAssertTrue([calc.display isEqual:@"10"], @"もう一度");
	
	[typer type:@"C"];
    STAssertTrue([calc.display isEqual:@"0"], @"clear");
	
	[typer type:@"±"];
    STAssertTrue([calc.display isEqual:@"0"], @"0には-はない");
	
	[typer type:@"C 1 + 2 ± ="];
    STAssertTrue([calc.display isEqual:@"-1"], @"C 1 + 2 ± =");
	
	[typer type:@"C 1 + 2 ±± ="];
    STAssertTrue([calc.display isEqual:@"3"], @"C 1 + 2 ±± =");
	
	[typer type:@"C 1 ±  3 + 3="];
    STAssertTrue([calc.display isEqual:@"6"], @"最初の 1 ± は次の入力で無効に");
	
}

- (void)testClear {
	[typer type:@"C 1"];
    STAssertTrue(calc.entering.active, @"入力中");
    STAssertTrue([calc.display isEqual:@"1"], @"1のはず");
	
	[typer type:@"c"];
    STAssertFalse(calc.entering.active, @"入力中じゃない");
    STAssertTrue([calc.display isEqual:@"0"], @"0のはず");
	
	[typer type:@"C 1 + 2"];
    STAssertTrue(calc.entering.active, @"入力中");
    STAssertTrue([calc.display isEqual:@"2"], @"2のはず");
	
	[typer type:@"c"];
    STAssertFalse(calc.entering.active, @"入力中じゃない");
    STAssertTrue([calc.display isEqual:@"1"], @"1のはず");
	
	[typer type:@"c"];
    STAssertFalse(calc.entering.active, @"入力中じゃない");
    STAssertTrue([calc.display isEqual:@"0"], @"0のはず");
}

- (void)testError {
	/*
	 エラーは Calculatorのステータスであるべきだが、displayとは
	 結びつくべきでない。エラーになったときにどういう表記にするかは
	 使う側の実装にゆだねるべき。
	 */
	[typer type:@"C"];
    STAssertFalse(calc.engine.error, @"エラーじゃない");
	
	[typer type:@"1 / 0 ="];
    STAssertTrue(calc.engine.error, @"エラー!");
    STAssertEquals(calc.engine.errorReason, CalcErrorDivideByZero, @"エラーはゼロ除算");
	
	[typer type:@"1 ="];
    STAssertTrue(calc.engine.error, @"クリアしない限りエラー!");
	
	[typer type:@"c"];
    STAssertFalse(calc.engine.error, @"クリアで解除");
	
	// クリアで解除されるのは最後の入力値とエラーであるべき
	
	[typer type:@"C 10 / 0 = c"];
    STAssertFalse(calc.engine.error, @"エラーは解除される");
    STAssertTrue([calc.display isEqual:@"10"], @"最初の入力値、10が有効である");
	
	[typer type:@"5"];
    STAssertTrue([calc.display isEqual:@"5"], @"入力しなおして5");
	
	[typer type:@"="];
    STAssertTrue([calc.display isEqual:@"2"], @"10 / 5 = 10");
}

- (void)testTricky {
	/*
	 最後の演算を覚えておくロジックを実装
	 */
	[typer type:@"C 1 + 2 ="];
    STAssertTrue([calc.display isEqual:@"3"], @"これは3");
	[typer type:@"="];
    STAssertTrue([calc.display isEqual:@"5"], @"続けて= を押すと最後の演算を繰り返すので 3+2=5");
	
	[typer type:@"= = = = ="];
    STAssertTrue([calc.display isEqual:@"15"], @"さらに続けて５回= を押すと5+2*5=15");
	
	[typer type:@"C 5 + 5 ="];
	[typer type:@"    + 3 ="];
    STAssertTrue([calc.display isEqual:@"13"], @"10 + 3 = 13");
}

@end
