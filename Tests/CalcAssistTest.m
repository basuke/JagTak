//
//  CalcAssistTest.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/27.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "CalcAssistTest.h"


@implementation CalcAssistTest

- (void)setUp {
	calc = [[Calcurator alloc] init];
	typer = [[CalcTyper alloc] init];
	
	[typer setCalc:calc];
}

- (void)tearDown {
	[typer release];
	[calc release];
}

- (void)testDigitAssist {
	[typer type:@"C 5万"];
    STAssertTrue([calc.display isEqual:@"50000"], [NSString stringWithFormat:@"%@ は 50000", calc.display]);
	
	[typer type:@"123"];
    STAssertTrue([calc.display isEqual:@"50123"], [NSString stringWithFormat:@"%@ は 50123", calc.display]);
	//	
	//	[calc typeDigit:4];
	//    STAssertTrue([calc.display isEqual:@"51234"], [NSString stringWithFormat:@"%@ は 51234", calc.display]);
	//	
	//	[calc typeDigit:5];
	//    STAssertTrue([calc.display isEqual:@"51234"], [NSString stringWithFormat:@"%@ は 51234. これ以上は変わらない", calc.display]);
}

@end
