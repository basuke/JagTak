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
}

- (NSArray *)arrayWithType:(NSString *)types;
- (void)type:(NSString *)types to:(id<Calculator>)calc;

@end
