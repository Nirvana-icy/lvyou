//
//  PlaceRecommend.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PlaceRecommend.h"
//#include "CONST.h"
@interface PlaceRecommend ()

@end

@implementation PlaceRecommend

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
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"推荐";
//    self.navigationController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.hidden = YES;
    //webview
    mWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    NSURL * url = [NSURL URLWithString:PLACERECONMMEND_URL];
    NSURL * url = [NSURL URLWithString:@"http://lvyou.baidu.com/event/s/app/qingminglvyou.html"];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [mWebView loadRequest:request];
    [mWebView setUserInteractionEnabled:YES];
    [mWebView setDelegate:self];
    [self.view addSubview:mWebView];
    
    //菊花
    mOpaqueview = [[UIView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    mActivityIndicator.center = mOpaqueview.center;
    mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [mOpaqueview setBackgroundColor:[UIColor blackColor]];
    mOpaqueview.alpha = 0.6 ;
    [self.view addSubview:mOpaqueview];
    [mOpaqueview addSubview:mActivityIndicator];
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = YES;
    [self.view addSubview:mActivityIndicator];

       
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [mActivityIndicator startAnimating];
    mOpaqueview.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [mActivityIndicator stopAnimating];
    mOpaqueview.hidden = YES;
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = NO;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
     mAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示：" message:@"请查看您的网络是否已经连接..." delegate:nil cancelButtonTitle:@"俺知道了" otherButtonTitles:nil, nil];
    [mAlertView show];
}

//可配合javascript使用的代码
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"testapp"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"alert"])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Alert from Cocoa Touch" message:[components objectAtIndex:2]
                                  delegate:self cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
            [alert show];
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
