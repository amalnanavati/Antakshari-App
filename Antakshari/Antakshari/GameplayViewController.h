//
//  GameplayViewController.h
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
//#import <iAd/ADInterstitialAd.h>
#import <iAd/iAd.h>

@interface GameplayViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate/*, ADInterstitialAdDelegate*/, UIAlertViewDelegate> {
    /*ADInterstitialAd *interstitial;
    BOOL requestingAd;*/
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *verify;
@property (weak, nonatomic) IBOutlet UILabel *startingLetterLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *endingLetterLabel;
@property (weak, nonatomic) IBOutlet UITextField *endingLetterTextField;
@property (weak, nonatomic) IBOutlet UITextField *lyricsTextField;
@property (weak, nonatomic) IBOutlet UILabel *teamNumber;
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;
@property (nonatomic) NSMutableArray *teamsArray;
@property (nonatomic) NSDictionary *categoriesDictionary;
@property (weak, nonatomic) IBOutlet UIButton *hint;
@property (nonatomic) NSMutableArray *scoresArray;
@property (weak, nonatomic) IBOutlet UIButton *score;
@property (nonatomic) NSTimer *spinTimer;
@property int scoring;
@property int mode;
@property int nextPlayer;
@property int teamWhoseTurnItIs;
@property BOOL pickerHasSpun;
@property int multiplier;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property int turn;
@property BOOL configureKeyboardFrame;
@property CGRect keyboardFrame;
//@property int playerWhoseTurnItIsForOrderedMode;


- (IBAction)endGame:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)hint:(id)sender;
- (IBAction)score:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)go:(id)sender;
- (IBAction)skip:(id)sender;
-(void) startSpinning;
-(void) endSpinning:(NSTimer *)timer;
-(void) movePicker;
-(void)keyboardOnScreen:(NSNotification *)notification;
-(void)keyboardOffScreen:(NSNotification *)notification;


//-(void)showFullScreenAd;


@end
