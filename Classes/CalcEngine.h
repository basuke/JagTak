//
//  CalcEngine.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/21.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalcEngine : NSObject {
	double _result;
}

- (void)store:(double)value;

- (void)add:(double)value;
- (void)subtract:(double)value;
- (void)multiply:(double)value;
- (void)divide:(double)value;

- (double)result;

- (void)clear;

@end
