//
//  GameplayViewController.m
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import "GameplayViewController.h"

@interface GameplayViewController ()

@end

@implementation GameplayViewController
@synthesize verify = _verify;
@synthesize startingLetterLabel = _startingLetterLabel;
@synthesize picker = _picker;
@synthesize hintLabel = _hintLabel;
@synthesize endingLetterLabel = _endingLetterLabel;
@synthesize endingLetterTextField = _endingLetterTextField;
@synthesize lyricsTextField = _lyricsTextField;
@synthesize teamNumber = _teamNumber;
@synthesize teamsArray = _teamsArray;
@synthesize scoring = _scoring;
@synthesize mode = _mode;
@synthesize nextPlayer = _nextPlayer;
@synthesize categoriesDictionary = _categoriesDictionary;
@synthesize scoresArray = _scoresArray;
//teamWhoseTurnItIs goes from 0 to (number of teams - 1)
@synthesize teamWhoseTurnItIs = _teamWhoseTurnItIs;
@synthesize pickerHasSpun = _pickerHasSpun;
@synthesize multiplier = _multiplier;
@synthesize spinTimer = _spinTimer;
@synthesize turn = _turn;
@synthesize hint = _hint;
@synthesize verifyLabel = _verifyLabel;
//player whose turnitis goes from 0 to (number of players - 1)
//@synthesize playerWhoseTurnItIsForOrderedMode = _playerWhoseTurnItIsForOrderedMode;
@synthesize configureKeyboardFrame = _configureKeyboardFrame;
@synthesize keyboardFrame = _keyboardFrame;
@synthesize score = _score;

- (NSMutableArray *)teamsArray {
    //lazy instantiation of teamsArray
    if (_teamsArray == nil) _teamsArray = [[NSMutableArray alloc] init];
    return _teamsArray;
}

- (NSMutableArray *)scoresArray {
    //lazy instantiation of scoresArray
    if (_scoresArray == nil && self.scoring == 1) {
        _scoresArray = [[NSMutableArray alloc] initWithCapacity:[self.teamsArray count]];
        
        for (int i = 0; i < [self.teamsArray count]; i++) {
            [_scoresArray addObject:[NSNumber numberWithInt:0]];
        }
    }
    NSLog(@"scoresArray = %@", _scoresArray);
    return _scoresArray;
}

- (NSDictionary *)categoriesDictionary {
    //lazy instantiation of categoriesDictionary
    if (_categoriesDictionary == nil) _categoriesDictionary = @{@"With Word: 'Piya'":@[@"From movie Tere Naal Love Ho Gaya", @"Famous song by Ustad Sultan Khan", @"Cabaret dance by Helen, from film Caravan"], @"With Word: 'Ladka'/'Ladki'":@[@"Song from Kuch Kuch Hota Hai", @"Yeh Ladka Hai...", @"Song from Chalti Ka Naam Gadi"], @"With Word: 'Des'/'Desh'":@[@"Swades", @"Song from a Kajol / Aamir Khan film", @"'This is what my country is like...'"], @"With Word: Krishna/Radha/Shrinathji/Ram/Mahadev":@[@"Film that the song 'Dum Maaro Dum' is from", @"2001 cricket film nominated for the Oscars by India", @"2013 Romeo-Juliet type love story with Priyanka Chopra"], @"With Word: 'Ghar'":@[@"DDLJ", @"Kati Patand", @"The bride came home drunk today"], @"With Word: 'Bagh' (garden)":@[@"Famous Sharmila Tagore movie with Rajesh Khanna in a double role"], @"With Word: 'Hum'":@[@"Famous song from Bobby", @"Salman Khan Madhuri Dixit movie", @"Amitabh-Dharmendra friendship song"], @"Bhajan":@[@"Mahatma Gandhi's favorite song", @"Sung at the end of all poojas", @"Please God, give us the strength to..."], @"Song from before you were born.":@[@"My name is joker...", @"Where does the Ganges come from, where does it go", @"Jaise khilta gulaab jaise, shaayar ka khwab jaise"], @"Lata Mangeshkar":@[@"I have nine bangles on my hand...", @"Epic Shahrukh Khan Preiti Zinta love story", @"Song from Parichay"], @"Song from a remake movie.":@[@"___ ko pakarna mushkil nahin, namunkin hai", @"Movie based on a poem bu Amitabh Bhachcan's father", @"This 2008 remake was about two men that pretend to be gay"], @"Item Song":@[@"My name is _______, _________ ki jawaani", @"Song from Agneepath", @"Bollywood song sung by Akon"], @"Rajesh Khanna":@[@"Yahaan kal kya ho kisne jaana", @"Film about a fun-loving man with terminal cancer", @"I am an infamous poet, I say goodbye", @"Lamps are lit, flowers bloom"], @"Shah Rukh Khan":@[@"No way, you need a hint for SRK?", @"Never say goodbye", @"Famous 90s song, set in a mustard field in Punjab", @"Film about a national women's hockey team"], @"Hindi song that starts with English word":@[@"I know you want it but you're never going to get it...", @"'Dance with me baby, won't you...' -- KANK", @"John Abraham Akshay Kumar film about Indian men"], @"Manna Dey":@[@"Oh brother, look where you're going", @"Patriotistic song from Kabuliwala, about missing one's country", @"Old song, reused in DDLJ at the end of Mehndi Laga Ke Rakhna"], @"Asha Bhosle":@[@"Don't insist on leaving tonight...", @"Song from Dil To Pagal Hai", @"You have stolen my heart from me"], @"Song from a movie about sports.":@[@"Run, Forrest, Run (think of the Hindi equivalent)", @"Akshay Kumar film about cricket", @"Aamir Khan film about the British Raj"], @"Talat Mehmood":@[@"Even if I go, where shall I go?", @"From Sujata, song about burning in love", @"Oh innocent heart, what has happebned to you?"], @"Jagjit Singh":@[@"Childhood song about paper boats", @"I saw you and got this idea...", @"This is my house, this is your house"], @"Shankar Mahadevan":@[@"Aamir Khan film about dyslexia", @"Famous friendship movie, Farhan Khan's directorial debut", @"Har ghari badal rahi hai..."], @"Mohammed Rafi":@[@"My heart is the moon, you are moonlight", @"Husband-wife duo from Abhimaan", @"Now that I have found you, it feels like..."], @"Madhubala":@[@"Mughal-e-Azam", @"Chalti Ka Naam Gadi"], @"Hindi song that has foreign words other than English":@[@"Hrithik Roshan, Farhan Akthar, Abhay Deol film set in Spain", @"From Love in Tokyo", @"Any song with Punjabi"], @"Aamir Khan":@[@"Phunsukh Wangdu", @"Tu Meri Adhuri Pyas Pyas", @"Tongue-twister song from an Aamir Khan Kajol film"], @"2013 song":@[@"Meri aashiqui ab tum hi ho", @"Third installment of an epic Abhishek Bachchan series", @"To Sidhi Saadhi Chori Sharaabi Ho Gayi"], @"Amitabh Bachhan":@[@"Gonzalves", @"Amitabh Bachchan sung this Rabrinath Tagore in Kahaani", @"____________, Tere Bina "], @"2014 song":@[@"", @""], @"Nutan":@[@"", @""], @"Dream sequence song":@[@"", @""], @"Dev Anand":@[@"", @""], @"Shammi Kapoor":@[@"", @""], @"Song that you sing the whole song":@[@"", @""], @"Song from a movie with sequel(s)":@[@"", @""], @"Theme: Love":@[@"", @""], @"Theme: Friendship":@[@"", @""], @"Theme: Patriotism":@[@"", @""], @"Theme: Farewell":@[@"", @""], @"Theme: Diwali":@[@"", @""], @"Theme: Holi":@[@"", @""], @"Theme: Janmashtami":@[@"", @""], @"Theme: Rakhi":@[@"", @""], @"Theme: Dandiya":@[@"", @""], @"Theme: Bhangra":@[@"", @""], @"Theme: Time":@[@"", @""], @"Theme: Memories":@[@"", @""], @"Theme: Life":@[@"", @""], @"Theme: God/ Bhakti":@[@"", @""], @"Theme: Wedding":@[@"", @""], @"Theme: Bidai":@[@"", @""], @"Theme: Immigration (Indians missing country)":@[@"", @""], @"Theme: Rona-Dhona":@[@"Rona Dhona = any sad song", @""], @"Theme: Parents":@[@"", @""], @"Theme: Prayer/Prarthna/Stuti":@[@"", @""], @"Theme: Qawali":@[@"", @""], @"Anything you want!":@[@"", @""], @"Song About: Morning, Evening, or Night":@[@"", @""], @"Song About: Rivers, Oceans, Lakes, or Water":@[@"", @""], @"Kishore Kumar":@[@"", @""], @"Song About: Sun, Moon, or Stars":@[@"", @""], @"Song About: Mind, Heart, or Soul":@[@"", @""], @"Song About: Plants or Animals":@[@"", @""], @"Song that starts with a number.":@[@"", @""], @"Song About: Seeing, Listening, or Speaking":@[@"", @""], @"Song About: Air, Earth, or Fire":@[@"", @""], @"Song About: Days, Weeks, Months, Years":@[@"", @""], @"Song from a movie about friendship":@[@"", @""], @"Fusion of two songs":@[@"", @""], @"Fusion of Indian and American song":@[@"", @""]};
    return _categoriesDictionary;
}

- (int)teamWhoseTurnItIs {
    return _teamWhoseTurnItIs;
}

- (void) setTeamWhoseTurnItIs:(int)teamWhoseTurnItIs {
    _teamWhoseTurnItIs = (teamWhoseTurnItIs%[self.teamsArray count]);
    self.teamNumber.text = [NSString stringWithFormat:@"Team %d", _teamWhoseTurnItIs + 1];
}

/*- (int) playerWhoseTurnItIsForOrderedMode {
    return _playerWhoseTurnItIsForOrderedMode;
}

- (void) setPlayerWhoseTurnItIsForOrderedMode:(int)playerWhoseTurnItIsForOrderedMode {
    _playerWhoseTurnItIsForOrderedMode = (playerWhoseTurnItIsForOrderedMode%[[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]);
    self.teamNumber.text = [NSString stringWithFormat:@"Team %d", _teamWhoseTurnItIs + 1];
}*/

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
    self.endingLetterTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    for (UIView *view in self.backgroundScrollView.subviews) {
        if ([view isKindOfClass:[UITextField class]] == YES) {
            [(UITextField *)view setDelegate:self];
            [(UITextField *)view setReturnKeyType:UIReturnKeyDone];
        }
    }
    [self.lyricsTextField setReturnKeyType:UIReturnKeyGo];
    
    [self.hintLabel setText:@""];
    
    if (self.mode == 1) {
        [self.hint setHidden:YES];
        [self.hint setEnabled:NO];
    }
    
    if (self.scoring == 0) {
        [self.score setHidden:YES];
        [self.score setEnabled:NO];
    }
    
    self.hintLabel.adjustsFontSizeToFitWidth = YES;
    
    self.configureKeyboardFrame = NO;
    
    [self.lyricsTextField becomeFirstResponder];
    
    [self.backgroundScrollView setContentSize:CGSizeMake(self.backgroundScrollView.frame.size.width, (self.backgroundScrollView.frame.size.height + 264 + 20 + 15))];
    //[self.backgroundScrollView setScrollEnabled:YES];
    [self.backgroundScrollView setBounces:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardOffScreen:) name:UIKeyboardDidHideNotification object:nil];
    
    if (self.mode == 1) {
        //self.playerWhoseTurnItIsForOrderedMode = 0;
    }
    
    [super viewDidLoad];
    
    self.teamWhoseTurnItIs = 0;
    self.multiplier = 400;
    [self becomeFirstResponder];
    [self.picker setUserInteractionEnabled:NO];
    
    if (self.mode == 0 && self.nextPlayer != 2) {
        [self.picker selectRow:[[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2 inComponent:0 animated:NO];
        [self.picker selectRow:[self.categoriesDictionary count]*2 inComponent:1 animated:NO];
    } else if (self.mode == 1 && self.nextPlayer == 2) {
        [self.picker setHidden:YES];
    } else if (self.mode == 1 && self.nextPlayer != 2) {
        [self.picker selectRow:[[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2 inComponent:0 animated:NO];
    } else if (self.mode == 0 && self.nextPlayer == 2) {
        [self.picker selectRow:[self.categoriesDictionary count]*2 inComponent:0 animated:NO];
    }
    
    if (self.mode != 1) {
        [self.startingLetterLabel setHidden:YES];
        [self.endingLetterLabel setHidden:YES];
        [self.endingLetterTextField setHidden:YES];
        [self.startingLetterLabel setEnabled:NO];
        [self.endingLetterLabel setEnabled:NO];
        [self.endingLetterTextField setEnabled:NO];
    }
    
    self.turn = 1;
    [self.verify setHidden:YES];
    [self.verify setEnabled:NO];
    [self.verifyLabel setHidden:YES];
    [self.verifyLabel setEnabled:NO];
    
    
    //[self.picker setFrame:CGRectMake(0, 0, 320, 162)];
    [self.picker reloadAllComponents];
    // Do any additional setup after loading the view.
    
    //[self showFullScreenAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endGame:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sure?" message:@"Are you sure you would like to end the game?  You will not be able to undo this action." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (IBAction)settings:(id)sender {
}

- (IBAction)hint:(id)sender {
    if (self.pickerHasSpun == YES) {
    if (self.mode == 0) {
        
        NSString *title;
        if (self.nextPlayer == 2) {
            title = [[self.categoriesDictionary allKeys] objectAtIndex:([self.picker selectedRowInComponent:0]%[[self.categoriesDictionary allKeys] count])];
        } else {
            title = [[self.categoriesDictionary allKeys] objectAtIndex:([self.picker selectedRowInComponent:1]%[[self.categoriesDictionary allKeys] count])];
        }
        
        if ([self.hintLabel.text isEqualToString:@""]) {
            [self.hintLabel setText:[[self.categoriesDictionary objectForKey:title] objectAtIndex:0]];
        } else {
        
            for (int i = 0; i < [[self.categoriesDictionary objectForKey:title] count]; i++) {
                if ([self.hintLabel.text isEqualToString:[[self.categoriesDictionary objectForKey:title] objectAtIndex:i]] == YES) {
                    [self.hintLabel setText:[[self.categoriesDictionary objectForKey:title] objectAtIndex:((i+1)%[[self.categoriesDictionary objectForKey:title] count])]];
                    break;
                }
            }
        }
    }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please spin the picker before continuing." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)score:(id)sender {
    if (self.scoring == 1) {
        NSString *scoreString = @"";
        for (int i = 0; i < [self.teamsArray count]; i++) {
            if ([scoreString isEqualToString:@""]) {
                scoreString = [scoreString stringByAppendingFormat:@"Team %d: %d points", (i+1), [[self.scoresArray objectAtIndex:i] intValue]];
            } else {
                scoreString = [scoreString stringByAppendingFormat:@"\nTeam %d: %d points", (i+1), [[self.scoresArray objectAtIndex:i] intValue]];
            }
        }
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Scores" message:scoreString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)next:(id)sender {
    if (self.mode == 0) {
        if (self.pickerHasSpun == YES) {
        
            if (self.turn == 1) {
                [self.verify setHidden:NO];
                [self.verify setEnabled:YES];
                [self.verifyLabel setHidden:NO];
                [self.verifyLabel setEnabled:YES];
                [self.verify setSelectedSegmentIndex:1];
            } else if (self.scoring == 1) {
                int oldScore;
                if (self.verify.selectedSegmentIndex == 1) {
                    if (self.teamWhoseTurnItIs == 0) {
                        oldScore = [[self.scoresArray objectAtIndex:([self.scoresArray count]-1)] intValue];
                        [self.scoresArray removeObjectAtIndex:([self.scoresArray count]-1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 10)] atIndex:([self.scoresArray count])];
                    } else {
                        oldScore = [[self.scoresArray objectAtIndex:(self.teamWhoseTurnItIs - 1)] intValue];
                        [self.scoresArray removeObjectAtIndex:(self.teamWhoseTurnItIs - 1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 10)] atIndex:(self.teamWhoseTurnItIs - 1)];
                    }
                } else {
                    if (self.teamWhoseTurnItIs == 0) {
                        oldScore = [[self.scoresArray objectAtIndex:([self.scoresArray count]-1)] intValue];
                        [self.scoresArray removeObjectAtIndex:([self.scoresArray count]-1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 5)] atIndex:([self.scoresArray count])];
                    } else {
                        oldScore = [[self.scoresArray objectAtIndex:(self.teamWhoseTurnItIs - 1)] intValue];
                        [self.scoresArray removeObjectAtIndex:(self.teamWhoseTurnItIs - 1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 5)] atIndex:(self.teamWhoseTurnItIs - 1)];
                    }
                }
            }
            self.turn++;
            self.pickerHasSpun = NO;
            self.teamWhoseTurnItIs++;
            self.verify.selectedSegmentIndex = 1;
            self.hintLabel.text = @"";
            
            if (self.nextPlayer == 0) {
                [self.picker selectRow:[[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2 inComponent:0 animated:NO];
                [self.picker selectRow:[self.categoriesDictionary count]*2 inComponent:1 animated:NO];
            } else if (self.nextPlayer == 2) {
                [self.picker selectRow:[self.categoriesDictionary count]*2 inComponent:0 animated:NO];
            } else if (self.nextPlayer == 1){
                if (self.teamWhoseTurnItIs == 0) [self.picker selectRow:([self.picker selectedRowInComponent:0]+1) inComponent:0 animated:NO];
                [self.picker selectRow:[self.categoriesDictionary count]*2 inComponent:1 animated:NO];
            }
            

            
            [self.picker reloadAllComponents];
        
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please spin the picker before continuing." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    } else {
        if (self.pickerHasSpun == YES || self.nextPlayer == 2 || self.nextPlayer == 1) {
        if ([self.endingLetterTextField.text length] > 0 && self.endingLetterTextField.text != nil && [[self.endingLetterTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] length] == 0) {
            
            if (self.turn == 1) {
                [self.verify setHidden:NO];
                [self.verify setEnabled:YES];
                [self.verifyLabel setHidden:NO];
                [self.verifyLabel setEnabled:YES];
                [self.verify setSelectedSegmentIndex:1];
            } else if (self.scoring == 1) {
                int oldScore;
                if (self.verify.selectedSegmentIndex == 1) {
                    if (self.teamWhoseTurnItIs == 0) {
                        oldScore = [[self.scoresArray objectAtIndex:([self.scoresArray count]-1)] intValue];
                        [self.scoresArray removeObjectAtIndex:([self.scoresArray count]-1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 10)] atIndex:([self.scoresArray count])];
                    } else {
                        oldScore = [[self.scoresArray objectAtIndex:(self.teamWhoseTurnItIs - 1)] intValue];
                        [self.scoresArray removeObjectAtIndex:(self.teamWhoseTurnItIs - 1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 10)] atIndex:(self.teamWhoseTurnItIs - 1)];
                    }
                } else {
                    if (self.teamWhoseTurnItIs == 0) {
                        oldScore = [[self.scoresArray objectAtIndex:([self.scoresArray count]-1)] intValue];
                        [self.scoresArray removeObjectAtIndex:([self.scoresArray count]-1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 5)] atIndex:([self.scoresArray count])];
                    } else {
                        oldScore = [[self.scoresArray objectAtIndex:(self.teamWhoseTurnItIs - 1)] intValue];
                        [self.scoresArray removeObjectAtIndex:(self.teamWhoseTurnItIs - 1)];
                        [self.scoresArray insertObject:[NSNumber numberWithInt:(oldScore + 5)] atIndex:(self.teamWhoseTurnItIs - 1)];
                    }
                }
            }
            
            self.turn++;
            self.pickerHasSpun = NO;
            self.teamWhoseTurnItIs++;
            self.verify.selectedSegmentIndex = 1;
            
            if (self.nextPlayer == 2) {
                [self.picker setHidden:YES];
            } else if (self.nextPlayer == 0) {
                [self.picker selectRow:[[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2    inComponent:0 animated:NO];
            } else if (self.nextPlayer == 1){
                if (self.teamWhoseTurnItIs == 0) [self.picker selectRow:([self.picker selectedRowInComponent:0]+1) inComponent:0 animated:NO];
            }
            
            [self.picker reloadAllComponents];
            
            [self.startingLetterLabel setText:[NSString stringWithFormat:@"Starting Letter: %@", self.endingLetterTextField.text]];
            [self.endingLetterTextField setText:@""];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please type the ending letter of the song." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please spin the picker before continuing." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
    
}

- (IBAction)go:(id)sender {
    if (self.pickerHasSpun) {
        if ([self.lyricsTextField.text length] > 0 && self.lyricsTextField.text != nil) {
        
            WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        
            webViewController.songTitle = self.lyricsTextField.text;
            self.lyricsTextField.text = @"";
            [self.view endEditing:YES];
            [self.backgroundScrollView setContentOffset:CGPointZero animated:NO];
            [self.navigationController pushViewController:webViewController animated:YES];
        
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please type the name of your song." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Please spin the picker before searching lyrics." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)skip:(id)sender {
    //skip category, or pass on turn???
}

-(void) startSpinning {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(endSpinning:) userInfo:nil repeats:NO];
    self.spinTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(movePicker) userInfo:nil repeats:YES];
    //[self.spinTimer fire];
}

-(void) endSpinning:(NSTimer *)timer {
    [timer invalidate];
    [self.spinTimer invalidate];
    for (int i = 0; i < [self.picker numberOfComponents]; i++) {
        if (!(self.nextPlayer == 1 && i == 0)) {
            [self.picker selectRow:([self.picker selectedRowInComponent:i]+(arc4random()%([self.picker numberOfRowsInComponent:i]/self.multiplier))) inComponent:i animated:YES];
        }
    }
    self.pickerHasSpun = YES;
}

-(void) movePicker {
    for (int i = 0; i < [self.picker numberOfComponents]; i++) {
        if (!(self.nextPlayer == 1 && i == 0)) {
            [self.picker selectRow:([self.picker selectedRowInComponent:i]+([self.picker numberOfRowsInComponent:i]/self.multiplier)) inComponent:i animated:YES];
        }
    }
    
    /*if ([self.picker numberOfComponents] == 1) {
        [self.picker selectRow:([self.picker selectedRowInComponent:0]+5) inComponent:0 animated:YES];
    } else {
        [self.picker selectRow:([self.picker selectedRowInComponent:0]+5) inComponent:0 animated:YES];
        [self.picker selectRow:([self.picker selectedRowInComponent:1]+5) inComponent:1 animated:YES];
    }*/
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

#pragma-mark UIPickerViewDelegate, UIPickerViewDataSource, Shake Motion Stuff

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    //if it is categories
    if (self.mode == 0 && self.nextPlayer != 2) {
        return 2;
    } else if (self.mode == 1 && self.nextPlayer == 2) {
        //if it is last letter & team ordering
        return 0;
    } else {
        //if it is last letter w/ choose player or categories w/ team effort
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.multiplier*[[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] count];
    } else {
        return self.multiplier*[self.categoriesDictionary count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    
    
    if (self.mode == 0 && self.nextPlayer != 2) {
        if (component == 0) {
            if (row == [[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2 && self.nextPlayer != 1) {
                return @"Shake";
            } else {
                return [[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] objectAtIndex:(row%[[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] count])];
            }
        } else {
            if (row == [self.categoriesDictionary count]*2) {
                if (self.nextPlayer != 1) {
                    return @"To Start!!!";
                } else {
                    return @"Shake To Start!!!";
                }
            } else {
                //Check this line -- bcuz dicionaries are not ordered, this may cause repeats of some categories...
                return [[self.categoriesDictionary allKeys] objectAtIndex:(row%[self.categoriesDictionary count])];
            }
        }
    } else if (self.mode == 1 && self.nextPlayer == 2) {
        return @"";
    } else if (self.mode == 1 && self.nextPlayer == 0) {
        if (row == [[self.teamsArray objectAtIndex:self.teamWhoseTurnItIs] count]*2) {
            return @"Shake To Start!!!";
        } else {
            return [[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] objectAtIndex:(row%[[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] count])];
        }
    } else if (self.mode == 1 && self.nextPlayer == 1) {
        return [[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] objectAtIndex:(row%[[self.teamsArray objectAtIndex:(self.teamWhoseTurnItIs)] count])];
    } else if (self.mode == 0 && self.nextPlayer == 2) {
        if (row == [self.categoriesDictionary count]*2) {
            return @"Shake To Start!!!";
        } else {
            return [[self.categoriesDictionary allKeys] objectAtIndex:(row%[self.categoriesDictionary count])];
        }
    } else {
        return @"";
    }
    
}

-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    [pickerView reloadAllComponents];
    if ([pickerView numberOfComponents] == 2) {
        if (component == 0) {
            return 70.0f;
        } else {
            return 230.0f;
        }
    } else {
        return 300.0f;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        if ([pickerView numberOfComponents] == 2) {
            if (component == 0) {
                tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 32)];
            } else {
                tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 32)];
            }
        } else {
            tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 32)];
        }
        
        // Setup label properties - frame, font, colors etc
        tView.adjustsFontSizeToFitWidth = YES;
        [tView setBackgroundColor:[UIColor clearColor]];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    // Fill the label text here
    
    [tView setText:[self pickerView:self.picker titleForRow:row forComponent:component]];
    
    if ([tView.text isEqualToString:@"Shake"] || [tView.text isEqualToString:@"To Start!!!"] || [tView.text isEqualToString:@"Shake To Start!!!"]) {
        [tView setTextColor:[UIColor redColor]];
    }
    
    return tView;
}

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake && [self.picker isHidden] == NO && self.pickerHasSpun == NO && !(self.mode == 1 && self.nextPlayer == 1)) {
        [self startSpinning];
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqual:@"\n"]) {
        if ([textField isEqual:self.lyricsTextField]) {
            [self go:nil];
        } else {
            [textField resignFirstResponder];
        }
        return NO;
    } else {
        return YES;
    }
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (self.keyboardFrame.origin.y != 0) {
        NSLog(@"contentOffsetBefore = %@", NSStringFromCGPoint(self.backgroundScrollView.contentOffset));
        
        CGRect frameInSuperView = [self.backgroundScrollView convertRect:textField.frame toView:self.view];
        
        NSLog(@"%f, %f, %f, %f, %f", frameInSuperView.origin.y, [[UIScreen mainScreen] bounds].size.height, self.keyboardFrame.origin.y, frameInSuperView.size.height, (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15));
        if (frameInSuperView.origin.y > (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15)) {
            [self.backgroundScrollView setContentOffset:CGPointMake(0, (self.backgroundScrollView.contentOffset.y + frameInSuperView.origin.y - (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15))) animated:YES];
            NSLog(@"contentOffsetAfter = %@", NSStringFromCGPoint(CGPointMake(0, (self.backgroundScrollView.contentOffset.y + frameInSuperView.origin.y - (self.keyboardFrame.origin.y - frameInSuperView.size.height - 15)))));
        }
        
    }
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    self.keyboardFrame = keyboardFrame;
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    if ([self.lyricsTextField isFirstResponder] == YES && self.configureKeyboardFrame == NO) {
        [self.lyricsTextField resignFirstResponder];
    }
}

-(void)keyboardOffScreen:(NSNotification *)notification
{
    if (self.configureKeyboardFrame == NO) {
        self.configureKeyboardFrame = YES;
    } else {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}




/*
//Interstitial iAd
-(void)showFullScreenAd {
    //Check if already requesting ad
    if (requestingAd == NO) {
        //[ADInterstitialAd release];
        interstitial = [[ADInterstitialAd alloc] init];
        interstitial.delegate = self;
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
        [self requestInterstitialAdPresentation];
        NSLog(@"interstitialAdREQUEST");
        requestingAd = YES;
    }//end if
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    interstitial = nil;
    //[interstitialAd release];
    //[ADInterstitialAd release];
    requestingAd = NO;
    NSLog(@"interstitialAd didFailWithERROR");
    NSLog(@"%@", error);
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidLOAD");
    if (interstitialAd != nil && interstitial != nil && requestingAd == YES) {
        [self requestInterstitialAdPresentation];
        //[interstitial presentFromViewController:self];
        NSLog(@"interstitialAdDidPRESENT");
    }//end if
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    interstitial = nil;
    //[interstitialAd release];
    //[ADInterstitialAd release];
     requestingAd = NO;
    NSLog(@"interstitialAdDidUNLOAD");
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
    interstitial = nil;
    //[interstitialAd release];
    //[ADInterstitialAd release];
    requestingAd = NO;
    NSLog(@"interstitialAdDidFINISH");
}
 
 */

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //if they press "Yes" they want to quit, display the score and move back to the main menu.
    if (buttonIndex == 1) {
        if (self.scoring == 1) {
            NSString *scoreString = @"";
            for (int i = 0; i < [self.teamsArray count]; i++) {
                if ([scoreString isEqualToString:@""]) {
                    scoreString = [scoreString stringByAppendingFormat:@"Team %d: %d points", (i+1), [[self.scoresArray objectAtIndex:i] intValue]];
                } else {
                    scoreString = [scoreString stringByAppendingFormat:@"\nTeam %d: %d points", (i+1), [[self.scoresArray objectAtIndex:i] intValue]];
                }
            }
            int maxScore = -1;
            int maxPlayer = -1;
            for (int i = 0; i < self.scoresArray.count; i++) {
                if ([[self.scoresArray objectAtIndex:i] intValue] > maxScore) {
                    maxScore = [[self.scoresArray objectAtIndex:i] intValue];
                    maxPlayer = i;
                }
            }
            
            NSLog(@"score = %d, player = %d", maxScore, maxPlayer);
            
            int numberOfTimesMaxScoreAppears = 0;
            for (NSNumber *tempNumber in self.scoresArray) {
                if (tempNumber.intValue == maxScore) numberOfTimesMaxScoreAppears++;
            }
            
            if (numberOfTimesMaxScoreAppears > 1) {
                scoreString = [scoreString stringByAppendingFormat:@"\nIt is a tie!"];
            } else {
                scoreString = [scoreString stringByAppendingFormat:@"\nTeam %d Wins!", (maxPlayer+1)];
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:scoreString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}





@end
