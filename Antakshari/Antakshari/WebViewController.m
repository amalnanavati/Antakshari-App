//
//  WebViewController.m
//  Antakshari
//
//  Created by Chaya Nanavati on 7/18/14.
//  Copyright (c) 2014 Chaya Nanavati. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize songTitle = _songTitle;
@synthesize webView = _webView;
@synthesize stop = _stop;
@synthesize back = _back;
@synthesize forward = _forward;

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
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSString *modifiedSongTitle = [[self.songTitle stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://hindigeetmala.net/song/%@.htm", modifiedSongTitle]]]];
    [self updateButtons];
    
    // Do any additional setup after loading the view.
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

- (IBAction)stop:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

- (IBAction)done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateButtons
{
    self.forward.enabled = self.webView.canGoForward;
    self.back.enabled = self.webView.canGoBack;
    self.stop.enabled = self.webView.loading;
}

#pragma-mark UIWebViewDelegate Stuff
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

@end
