//
//  MainViewController.m
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

#import "MainViewController.h"
#import "Calcurator.h"

#import "FlipsideViewController.h"


#define CALC_RESULT_KEY @"result"
#define CALC_ENTERING_KEY @"entering"


@interface MainViewController()<FlipsideViewControllerDelegate>

@property(nonatomic, readonly) Calcurator *calc;

@end

@implementation MainViewController

- (void)dealloc {
	[_calc release];
	[resultDisplay release];
	[enteringDisplay release];
	
    [super dealloc];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.calc addObserver:self forKeyPath:CALC_RESULT_KEY options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
	[self.calc addObserver:self forKeyPath:CALC_ENTERING_KEY options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:CALC_RESULT_KEY]) {
		resultDisplay.text = self.calc.result;
	}
	
	if ([keyPath isEqual:CALC_ENTERING_KEY]) {
		enteringDisplay.text = self.calc.entering;
	}
}

- (void)viewDidUnload {
	[self.calc removeObserver:self forKeyPath:CALC_RESULT_KEY];
	[self.calc removeObserver:self forKeyPath:CALC_ENTERING_KEY];
	
	[super viewDidUnload];
}

- (void)releaseOutlets {
	
}
	 
#pragma mark Accessors

- (Calcurator *)calc {
	if (_calc == nil) {
		_calc = [[Calcurator alloc] init];
	}
	
	return _calc;
}

#pragma mark Actions

- (IBAction)digit0 {
	[self.calc typeDigit:0];
}

- (IBAction)digit1 {
	[self.calc typeDigit:1];
}

- (IBAction)digit2 {
	[self.calc typeDigit:2];
}

- (IBAction)digit3 {
	[self.calc typeDigit:3];
}

- (IBAction)digit4 {
	[self.calc typeDigit:4];
}

- (IBAction)digit5 {
	[self.calc typeDigit:5];
}

- (IBAction)digit6 {
	[self.calc typeDigit:6];
}

- (IBAction)digit7 {
	[self.calc typeDigit:7];
}

- (IBAction)digit8 {
	[self.calc typeDigit:8];
}

- (IBAction)digit9 {
	[self.calc typeDigit:9];
}

- (IBAction)period {
	[self.calc typeDot];
}

- (IBAction)plusMinus {
	[self.calc negative];
}

- (IBAction)ouku {
	[self.calc digitAssistWithPlaces:8];
}

- (IBAction)man {
	[self.calc digitAssistWithPlaces:4];
}

- (IBAction)sen {
	[self.calc digitAssistWithPlaces:3];
}

- (IBAction)hyaku {
	[self.calc digitAssistWithPlaces:2];
}

- (IBAction)plus {
	[self.calc hitPlus];
}

- (IBAction)minus {
	[self.calc hitMinus];
}

- (IBAction)mul {
	[self.calc hitMul];
}

- (IBAction)div {
	[self.calc hitDiv];
}

- (IBAction)result {
	[self.calc hitEqual];
}

- (IBAction)clear {
	[self.calc clear];
}

- (IBAction)showInfo:(id)sender {    
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


@end
