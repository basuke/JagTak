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
    STAssertTrue([calc.display isEqual:@"50000"], calc.display);
	
	[typer type:@"123"];
    STAssertTrue([calc.display isEqual:@"50123"], calc.display);
	/*
	 
	 type 5
						5	=>	5
	 type 億
				5OOOOOOOO	=>	5OOOOOOOO + 0
	 type 3
				5OOOOOOO3	=>	5OOOOOOOO + 3
	 type 千
				5OOOO3OOO	=>	5OOOOOOOO + 3OOO + 0
	 type 2 0
				5OOOO3O20	=>	5OOOOOOOO + 3OOO + 20
	 type 万
				53020OOOO	=>	5OOOOOOOO + 3020OOOO + 0
	 type 8
				53O20OOO8	=>	5OOOOOOOO + 3020OOOO + 8
	 type 千
				53O208OOO	=>	5OOOOOOOO + 3020OOOO + 8OOO + 0
	 
	 */
	
	[typer type:@"C"];
	[typer type:@"5"];
    STAssertTrue([calc.display isEqual:@"5"], @"5 buf %@", calc.display);
	[typer type:@"億"];
    STAssertTrue([calc.display isEqual:@"500000000"], @"5OOOOOOOO buf %@", calc.display);
	[typer type:@"3"];
    STAssertTrue([calc.display isEqual:@"500000003"], @"5OOOOOOOO + 3 buf %@", calc.display);
	[typer type:@"千"];
    STAssertTrue([calc.display isEqual:@"500003000"], @"5OOOOOOOO + 3OOO buf %@", calc.display);
	[typer type:@"2 0"];
    STAssertTrue([calc.display isEqual:@"500003020"], @"5OOOOOOOO + 3OOO + 20 buf %@", calc.display);
	[typer type:@"万"];
    STAssertTrue([calc.display isEqual:@"530200000"], @"5OOOOOOOO + 3020OOOO buf %@", calc.display);
	[typer type:@"8"];
    STAssertTrue([calc.display isEqual:@"530200008"], @"5OOOOOOOO + 3020OOOO + 8 buf %@", calc.display);
	[typer type:@"千"];
    STAssertTrue([calc.display isEqual:@"530208000"], @"5OOOOOOOO + 3020OOOO + 8OOO buf %@", calc.display);
	
	[typer type:@"C 億"];
    STAssertTrue([calc.display isEqual:@"100000000"], calc.display);
	
	[typer type:@"C 億千"];
	// C 0
	// 億 0 100000000
	// 千 0 100000000 1000
    STAssertTrue([calc.display isEqual:@"100001000"], calc.display);
	// 万 0 100000000 1000 10000 => 100000000 10000000
	[typer type:@"万"];
    STAssertTrue([calc.display isEqual:@"110000000"], calc.display);
	
	[typer type:@"C 千億千万千11"];
    STAssertTrue([calc.display isEqual:@"110000001011"], calc.display);
	
	[typer type:@"C 千万"];
    STAssertTrue([calc.display isEqual:@"10000000"], calc.display);
	
	[typer type:@"C 1000万"];
    STAssertTrue([calc.display isEqual:@"10000000"], calc.display);
	
	[typer type:@"C 2千万"];
    STAssertTrue([calc.display isEqual:@"20000000"], calc.display);
	
	[typer type:@"C 1千200万"];
    STAssertTrue([calc.display isEqual:@"12000000"], calc.display);
	
	[typer type:@"C 1千2万"];
    STAssertTrue([calc.display isEqual:@"10020000"], calc.display);
	
	[typer type:@"C 1千1万"];
    STAssertTrue([calc.display isEqual:@"10010000"], calc.display);
}

@end
