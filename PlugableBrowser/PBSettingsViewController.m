//
//  PBSettingsViewController.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/22/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBSettingsViewController.h"

@interface PBSettingsViewController ()

@end

@implementation PBSettingsViewController

- (id)initWithURL:(NSURL *)URL {
  
  self = [super initWithURL:URL];
  
  return self;

}

- (void)viewWillAppear:(BOOL)animated {
//  self.navigationController.navigationBarHidden = YES;
  self.navigationItem.title = @"Browser Store";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  
  [super webViewDidFinishLoad:webView];
  self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"Browser Store"];
}
@end
