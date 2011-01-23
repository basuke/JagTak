//
//  CalcTester.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calcurator.h"


@interface CalcTyper : NSObject {
	id<Calculator> _calc;
}

- (NSArray *)arrayWithType:(NSString *)types;
- (void)type:(NSString *)types to:(id<Calculator>)calc;

- (void)setCalc:(id<Calculator>)calc;
- (void)type:(NSString *)types;

@end
