//
//  ConfigurationViewController.m
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import "ConfigurationViewController.h"

@interface ConfigurationViewController ()

@end

@implementation ConfigurationViewController
@synthesize scoring = _scoring;
@synthesize mode = _mode;
@synthesize nextPlayer = _nextPlayer;
@synthesize scrollView = _scrollView;
@synthesize modeOfGame = _modeOfGame;
@synthesize numberOfPlayers = _numberOfPlayers;
@synthesize numberOfTeams = _numberOfTeams;
@synthesize keyboardFrame = _keyboardFrame;
@synthesize configureKeyboardFrame = _configureKeyboardFrame;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.configureKeyboardFrame = NO;
    
    [self.numberOfPlayers becomeFirstResponder];
    
    [self.backgroundScrollView setContentSize:CGSizeMake(self.backgroundScrollView.frame.size.width, (self.backgroundScrollView.frame.size.height + 264 + 20 + 15))];
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    //[self.backgroundScrollView setScrollEnabled:YES];
    [self.backgroundScrollView setBounces:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardOffScreen:) name:UIKeyboardDidHideNotification object:nil];
    
    for (UIView *view in self.backgroundScrollView.subviews) {
        if ([view isKindOfClass:[UITextField class]] == YES) {
            [(UITextField *)view setDelegate:self];
        }
        
    }
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UITextField class]] == YES) {
            [(UITextField *)view setDelegate:self];
        }
    }
    [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, 86, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)numberOfPlayersBefore:(id)sender {
    self.playersBeforeText = [(UITextField *)sender text];
}

- (IBAction)numberOfTeamsBefore:(id)sender {
    self.teamsBeforeText = [(UITextField *)sender text];
}

- (IBAction)numberOfPlayers:(id)sender {
    //make sure text has changed
    if ([[(UITextField *)sender text] isEqualToString:self.playersBeforeText] == NO) {
    if ([self.numberOfPlayers.text length] > 0 && self.numberOfPlayers.text != nil && [[self.numberOfPlayers.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
        
        
        //remove old objects in scroll view (in case player changes values, don't ant duplicates)
        //wait, actually removing them is problamatic is they already typed some names, instead ADD text fields
        /*for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UITextField class]] == YES) {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[UISegmentedControl class]] == YES) {
                [view removeFromSuperview];
            }
        }*/
        float maxY = 0;
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UITextField class]] == YES) {
                if (view.frame.origin.y > maxY) {
                    maxY = view.frame.origin.y;
                }
            }
        }
        
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        
        
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 30 + 40*self.numberOfPlayers.text.intValue)];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        if ([self.numberOfTeams.text length] > 0 && self.numberOfTeams.text != nil && [[self.numberOfTeams.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
            for (int i = 1; i <= self.numberOfTeams.text.intValue; i++) {
                [tempArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        } else {
            [tempArray addObject:@"1"];
            [tempArray addObject:@"2"];
        }
        
        if (maxY == 0) {
        for (int i = 0; i < self.numberOfPlayers.text.intValue; i++) {
            [self.scrollView addSubview:[[UITextField alloc] initWithFrame:CGRectMake(20, 15 + 40*i, 132, 30)]];
            //[self.scrollView addSubview:[[UISegmentedControl alloc] initWithFrame:CGRectMake(190, 15 + 38*i, 70, 29)]];
            UISegmentedControl *temp = [[UISegmentedControl alloc] initWithItems:tempArray];
            [temp setFrame:CGRectMake(190, 15 + 40*i, 70, 29)];
            temp.selectedSegmentIndex = 0;
            [self.scrollView addSubview:temp];
        }
        
        //NSLog(@"%@", self.scrollView.subviews);
        
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UITextField class]] == YES) {
                [(UITextField *)view setPlaceholder:@"Name"];
                [(UITextField *)view setBorderStyle:UITextBorderStyleRoundedRect];
                [(UITextField *)view setFont:[UIFont systemFontOfSize:15]];
                [(UITextField *)view setAutocorrectionType:UITextAutocorrectionTypeNo];
                [(UITextField *)view setKeyboardType:UIKeyboardTypeDefault];
                [(UITextField *)view setReturnKeyType:UIReturnKeyDone];
                [(UITextField *)view setClearButtonMode:UITextFieldViewModeWhileEditing];
                [(UITextField *)view setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [(UITextField *)view setDelegate:self];
            }
            
        }
        } else if (maxY < 15 + 40*self.numberOfPlayers.text.intValue) {
            int numberOfPreExistingTextFields = 0;
            
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    numberOfPreExistingTextFields++;
                }
            }
            
            for (int i = 0; i < self.numberOfPlayers.text.intValue - numberOfPreExistingTextFields; i++) {
                [self.scrollView addSubview:[[UITextField alloc] initWithFrame:CGRectMake(20, maxY + 40, 132, 30)]];
                //[self.scrollView addSubview:[[UISegmentedControl alloc] initWithFrame:CGRectMake(190, 15 + 38*i, 70, 29)]];
                UISegmentedControl *temp = [[UISegmentedControl alloc] initWithItems:tempArray];
                [temp setFrame:CGRectMake(190, maxY + 40, 70, 29)];
                temp.selectedSegmentIndex = 0;
                [self.scrollView addSubview:temp];
                maxY += 40;
            }
            
            //NSLog(@"%@", self.scrollView.subviews);
            
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UITextField class]] == YES) {
                    [(UITextField *)view setPlaceholder:@"Name"];
                    [(UITextField *)view setBorderStyle:UITextBorderStyleRoundedRect];
                    [(UITextField *)view setFont:[UIFont systemFontOfSize:15]];
                    [(UITextField *)view setAutocorrectionType:UITextAutocorrectionTypeNo];
                    [(UITextField *)view setKeyboardType:UIKeyboardTypeDefault];
                    [(UITextField *)view setReturnKeyType:UIReturnKeyDone];
                    [(UITextField *)view setClearButtonMode:UITextFieldViewModeWhileEditing];
                    [(UITextField *)view setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [(UITextField *)view setDelegate:self];
                }
                
            }
        } else if (maxY >= 15 + 40*self.numberOfPlayers.text.intValue) {
            int numberOfPreExistingTextFields = 0;
            
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    numberOfPreExistingTextFields++;
                }
            }
            
            while (numberOfPreExistingTextFields > self.numberOfPlayers.text.intValue) {
                for (UIView *view in self.scrollView.subviews) {
                    if (view.frame.origin.y == maxY) {
                        [view removeFromSuperview];
                    }
                }
                numberOfPreExistingTextFields--;
                maxY -= 40;
            }
        }

    } else {
        [self.numberOfPlayers setText:@""];
        [self.numberOfPlayers becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter only a number 1 or greater for \"Number of Players.\"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    }
    
}

- (IBAction)numberOfTeams:(id)sender {
    //make sure text has changed
    if ([[(UITextField *)sender text] isEqualToString:self.teamsBeforeText] == NO) {
    if ([self.numberOfTeams.text length] > 0 && self.numberOfTeams.text != nil && [[self.numberOfTeams.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0 && self.numberOfTeams.text.intValue > 1) {
        
        int numberOfTextFieldsInScrollView = 0;
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UISegmentedControl class]] == YES) {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[UITextField class]] == YES) {
                numberOfTextFieldsInScrollView++;
            }
        }
        
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 1; i <= self.numberOfTeams.text.intValue; i++) {
            [tempArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        for (int i = 0; i < numberOfTextFieldsInScrollView; i++) {
            UISegmentedControl *temp = [[UISegmentedControl alloc] initWithItems:tempArray];
            [temp setFrame:CGRectMake(190, 15 + 40*i, 70, 29)];
            temp.selectedSegmentIndex = 0;
            [self.scrollView addSubview:temp];
        }
        
    } else {
        [self.numberOfTeams setText:@""];
        [self.numberOfTeams becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter only a number 2 or greater for \"Number of Teams.\"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    }

}

- (IBAction)continueAction:(id)sender {
    if ([self.numberOfPlayers.text length] > 0 && self.numberOfPlayers.text != nil && [[self.numberOfPlayers.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
        
        if ([self.numberOfTeams.text length] > 0 && self.numberOfTeams.text != nil && [[self.numberOfTeams.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0 && self.numberOfTeams.text.intValue > 1) {
            
            if (self.numberOfPlayers.text.intValue >= self.numberOfTeams.text.intValue) {
            
            NSMutableArray *peopleOnEachTeam = [[NSMutableArray alloc] initWithCapacity:self.numberOfTeams.text.integerValue];
            
            for (int i = 1; i <= self.numberOfTeams.text.integerValue; i++) {
                [peopleOnEachTeam addObject:[NSNumber numberWithInt:0]];
            }
            
            int numberOfTextFieldsWithoutText = 0;
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UITextField class]] == YES) {
                    if ([[(UITextField *)view text] length] == 0 || [(UITextField *)view text] == nil) {
                        numberOfTextFieldsWithoutText++;
                    }
                }
                //keeps track of which player is on which team
                if ([view isKindOfClass:[UISegmentedControl class]] == YES) {
                    int index = [(UISegmentedControl *)view selectedSegmentIndex];
                    int count = [[peopleOnEachTeam objectAtIndex:index] intValue] + 1;
                    [peopleOnEachTeam removeObjectAtIndex:index];
                    [peopleOnEachTeam insertObject:[NSNumber numberWithInt:count] atIndex:index];
                }
            }
            
            if (numberOfTextFieldsWithoutText == 0) {
            
            int numberOfTeamsWithNoPeople = 0;
            BOOL doAllTeamsHaveEqualPeople = YES;
            if (numberOfTextFieldsWithoutText == 0) {
                
                int firstTeamNumberOfPeople = [[peopleOnEachTeam objectAtIndex:0] intValue];
                for (NSNumber *number in peopleOnEachTeam) {
                    if ([number intValue] == 0) {
                        numberOfTeamsWithNoPeople++;
                    }
                    if (number.intValue != firstTeamNumberOfPeople) {
                        doAllTeamsHaveEqualPeople = NO;
                    }
                }
            }
            
            if (numberOfTeamsWithNoPeople == 0) {
                
                if (doAllTeamsHaveEqualPeople == YES) {
                    
                    [self continuePartTwo];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Not all teams have an equal number of players. Continue?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
                    [alert setDelegate:self];
                    [alert show];
                }
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please make sure every team has at least one player." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
            }
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter a name for every player" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
            }
            
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You need at least as many players as you have teams." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alert show];
            }
        } else {
            [self.numberOfTeams setText:@""];
            [self.numberOfTeams becomeFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter  a number 2 or greater for \"Number of Teams.\"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
        
    } else {
        [self.numberOfPlayers setText:@""];
        [self.numberOfPlayers becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please enter  a number 1 or greater for \"Number of Players.\"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void) continuePartTwo {
    //numberOfplayers, numberOfTeams, player names, and players per team is good.
    NSMutableArray *teamsArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfTeams.text.intValue];
        
        for (int i = 0; i < self.numberOfTeams.text.intValue; i++) {
            [teamsArray addObject:[[NSMutableArray alloc] init]];
        }
        
        NSString *playerName;
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UISegmentedControl class]] == YES) {
                
                for (UIView *secondView in self.scrollView.subviews) {
                    if ([secondView isKindOfClass:[UITextField class]] == YES && secondView.frame.origin.y == view.frame.origin.y) {
                        playerName = [(UITextField *)secondView text];
                    }
                }
                
                [(NSMutableArray *)[teamsArray objectAtIndex:[(UISegmentedControl *)view selectedSegmentIndex]] addObject:playerName];
                
            }
        }
        
        NSLog(@"teamsArray = %@", teamsArray);
    
        
        GameplayViewController *gameplayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"gameplayViewController"];
        
        gameplayViewController.teamsArray = teamsArray;
        NSLog(@"gameplay = %@", gameplayViewController.teamsArray);
        gameplayViewController.scoring = self.scoring.selectedSegmentIndex;
        gameplayViewController.mode = self.mode.selectedSegmentIndex;
        gameplayViewController.nextPlayer = self.nextPlayer.selectedSegmentIndex;
        
        //[self presentViewController:gameplayViewController animated:YES completion:nil];
        
        [self.view endEditing:YES];
        [self.navigationController pushViewController:gameplayViewController animated:YES];
        
}

- (IBAction)scoringInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Scoring:" message:@"If you choose to play with scoring, the team after you will be asked to verify your song (whether it matches the category and/or started with the letter.)  If they do, you get 10 points, else you get 5 point." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)modeInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mode:" message:@"Categories: Each team gets a randomly assigned category (e.g. Shahrukh Khan Song) and must sing a song within that category. \nLastLetter: Traditional Antakshari, the next team must sing a song beginning with the last letter of the previous team's song." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)nextPlayerInfo:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nest Player:" message:@"Random: Randomly select one person from within the team to sing a song. \nOrder: Alternate which person sings by going in order. \nTeam: Do not designate one person to sing a song; rather, the whole team works together to decide on and sing a song." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}


#pragma-mark Delegate Stuff

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //NSLog(@"contentOffset = %@", NSStringFromCGPoint(self.backgroundScrollView.contentOffset));
    if ([string isEqual:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (self.keyboardFrame.origin.y != 0) {
    NSLog(@"contentOffsetBefore = %@", NSStringFromCGPoint(self.backgroundScrollView.contentOffset));
    
    CGRect frameInSuperView;
    if (textField.superview == self.backgroundScrollView) {
        frameInSuperView = [self.backgroundScrollView convertRect:textField.frame toView:self.view];
    } else if (textField.superview == self.scrollView) {
        frameInSuperView = [self.backgroundScrollView convertRect:self.scrollView.frame toView:self.view];
    }
    
    NSLog(@"%f, %f, %f, %f, %f", frameInSuperView.origin.y, [[UIScreen mainScreen] bounds].size.height, self.keyboardFrame.origin.y, frameInSuperView.size.height, (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15));
    if (frameInSuperView.origin.y > (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15)) {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, (self.backgroundScrollView.contentOffset.y + frameInSuperView.origin.y - (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15))) animated:YES];
        NSLog(@"contentOffsetAfter = %@", NSStringFromCGPoint(CGPointMake(0, (self.backgroundScrollView.contentOffset.y + frameInSuperView.origin.y - (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15)))));
    }
        
    }
}

/*-(void) textFieldDidEndEditing:(UITextField *)textField {
    if (self.isKeyboardOnScreen == NO) {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}*/

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //if they press "continue," move on.
    if (buttonIndex == 1) {
        [self continuePartTwo];
    }
}

/*- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"continueSegue"]) {
        return NO;
    } else {
        return YES;
    }
}*/

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    self.keyboardFrame = keyboardFrame;
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    if ([self.numberOfPlayers isFirstResponder] == YES && self.configureKeyboardFrame == NO) {
        [self.numberOfPlayers resignFirstResponder];
    }
}

-(void)keyboardOffScreen:(NSNotification *)notification
{
    if (self.configureKeyboardFrame == NO) {
        self.configureKeyboardFrame = YES;
    } else {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }
}


@end
