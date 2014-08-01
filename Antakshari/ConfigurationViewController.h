//
//  ConfigurationViewController.h
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameplayViewController.h"

typedef enum {
    GameModeCategories = 0,
    GameModeLastLetter
} GameMode;

@interface ConfigurationViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *scoring;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *nextPlayer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, readwrite) GameMode modeOfGame;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPlayers;
@property (weak, nonatomic) IBOutlet UITextField *numberOfTeams;
@property CGRect keyboardFrame;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property BOOL configureKeyboardFrame;
@property (nonatomic) NSString *playersBeforeText;
@property (nonatomic) NSString *teamsBeforeText;

- (IBAction)numberOfPlayersBefore:(id)sender;
- (IBAction)numberOfTeamsBefore:(id)sender;
- (IBAction)numberOfPlayers:(id)sender;
- (IBAction)numberOfTeams:(id)sender;
- (IBAction)continueAction:(id)sender;
- (IBAction)scoringInfo:(id)sender;
- (IBAction)modeInfo:(id)sender;
- (IBAction)nextPlayerInfo:(id)sender;
- (void) continuePartTwo;
-(void)keyboardOnScreen:(NSNotification *)notification;
-(void)keyboardOffScreen:(NSNotification *)notification;



@end
