//
//  Calcurator.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calcurator : NSObject {
}

@property(nonatomic, retain, readwrite) NSString *result;
@property(nonatomic, retain, readwrite) NSString *entering;

- (void)typeDigit:(NSInteger)digit;
- (void)typeDot;
- (void)hitPlus;
- (void)hitMinus;
- (void)hitMul;
- (void)hitDiv;
- (void)hitEqual;
- (void)clear;
- (void)negative;
- (void)digitAssistWithPlaces:(NSInteger)places;

@end
