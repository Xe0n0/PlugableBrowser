//
//  PBWebViewController.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/25/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBWebViewController.h"
#import "PBPluginManager.h"

@interface PBWebViewController ()
@property (nonatomic, strong) UITextField *input;

@end

@implementation PBWebViewController

#pragma mark - UIWebViewDelegate

- (void)loadView {
  [super loadView];
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [super webViewDidStartLoad:webView];
  [[PBPluginManager sharedManager] feedEvent:WebViewEventStartLoading];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [super webViewDidFinishLoad:webView];
  [[PBPluginManager sharedManager] feedEvent:WebViewEventFinished];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [super webView:webView didFailLoadWithError:error];
  [[PBPluginManager sharedManager] feedEvent:WebViewEventErrorLoading];
}

- (void)loadURLString:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", path]];
  [(UIWebView *)self.view loadRequest:[NSURLRequest requestWithURL:url]];
}
@end
