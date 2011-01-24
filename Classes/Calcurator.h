//
//  Calcurator.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Calculator

- (void)typeDigit:(NSInteger)digit;
- (void)typeDot;
- (void)hitPlus;
- (void)hitMinus;
- (void)hitMul;
- (void)hitDiv;
- (void)hitEqual;
- (void)clear;
- (void)allClear;
- (void)negative;
- (void)digitAssistWithPlaces:(NSInteger)places;

@end

@interface Calcurator : NSObject<Calculator> {
}

@property(nonatomic, retain, readwrite) NSString *display;
@property(nonatomic, retain, readwrite) NSString *currentOperator;

@end
