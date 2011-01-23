//
//  MockCalculator.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/23.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calcurator.h"

@interface MockCalculator : NSObject<Calculator> {
	NSMutableDictionary *counts;
}

- (NSInteger)sentCount:(NSString *)key;
- (void)resetCounts;

@end

