//
//  EnteringValue.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/24.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EnteringValue : NSObject {
}

- (void)typeDigit:(NSInteger)digit;
- (void)typeDot;

- (void)negative;

- (void)clear;

- (double)doubleValue;
- (NSString *)displayValue;

- (void)digitAssistWithPlaces:(NSInteger)places;

@property(nonatomic, assign, readwrite) BOOL active;
@property(nonatomic, assign, readwrite) BOOL digit;
@property(nonatomic, assign, readwrite) BOOL closed;

@end
