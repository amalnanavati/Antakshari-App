//
//  WebViewController.h
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic) NSString *songTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)stop:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;
- (IBAction)done:(id)sender;
-(void) updateButtons;

@end
