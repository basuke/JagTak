//
//  CalcAssistTest.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/27.
//  Copyright 2011 バスケ. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#import <SenTestingKit/SenTestingKit.h>

#import "Calcurator.h"
#import "CalcTyper.h"


@interface CalcAssistTest : SenTestCase {
	Calcurator *calc;
	CalcTyper *typer;
}

@end
