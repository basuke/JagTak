//
//  MainViewController.h
//  Jagtaku-iPhoneApp
//
//  Created by Yosuke Suzuki on 11/01/20.
//  Copyright 2011 バスケ. All rights reserved.
//

@class Calcurator;

@interface MainViewController : UIViewController {
	Calcurator *_calc;
	
	IBOutlet UILabel *resultDisplay;
	IBOutlet UILabel *enteringDisplay;
}

- (IBAction)showInfo:(id)sender;

- (IBAction)digit0;
- (IBAction)digit1;
- (IBAction)digit2;
- (IBAction)digit3;
- (IBAction)digit4;
- (IBAction)digit5;
- (IBAction)digit6;
- (IBAction)digit7;
- (IBAction)digit8;
- (IBAction)digit9;

- (IBAction)period;
- (IBAction)plusMinus;

- (IBAction)ouku;
- (IBAction)man;
- (IBAction)sen;
- (IBAction)hyaku;

- (IBAction)plus;
- (IBAction)minus;
- (IBAction)mul;
- (IBAction)div;

- (IBAction)result;
- (IBAction)clear;

@end
