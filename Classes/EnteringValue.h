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
- (void)clear;

- (double)doubleValue;

@property(nonatomic, assign, readwrite) BOOL active;
@property(nonatomic, retain, readwrite) NSString *value;
@property(nonatomic, assign, readwrite) BOOL digit;

@end
