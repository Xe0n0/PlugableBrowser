//
//  PBSettingsViewController.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/22/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBSettingsViewController.h"
#import "XNAppDelegate.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface PBSettingsViewController ()

@end

@implementation PBSettingsViewController

- (id)initWithURL:(NSURL *)URL {
  
  self = [super initWithURL:URL];
  
  return self;

}

- (void)viewWillAppear:(BOOL)animated {
  self.navigationController.navigationBarHidden = YES;
  self.navigationItem.title = @"Browser Store";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  
  [super webViewDidFinishLoad:webView];
  self.navigationItem.title = @"Browser Store";
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if ([request.URL.scheme  isEqualToString: @"pb-plugin"]) {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *real_path = [NSString stringWithFormat:@"http://127.0.0.1:8000%@", request.URL.path];
    NSURL *URL = [NSURL URLWithString:real_path];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
      
//      NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
      
      NSFileManager *fm = [NSFileManager defaultManager];
      NSError *error;
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
      
      
      NSString *directory = [paths[0] stringByAppendingPathComponent:@"Plugins"];
      NSURL *plugin_directory = [NSURL fileURLWithPath:directory];
      if (![fm fileExistsAtPath:directory isDirectory:NULL]) {
        if (![fm createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error])
          NSLog(@"%@", error);
      }
      
      return [plugin_directory URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
      
      [SVProgressHUD showSuccessWithStatus:@"插件已下载"];
      NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    return NO;
  }
  return YES;
}
@end
