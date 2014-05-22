//
//  XNViewController.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/22/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "XNViewController.h"
#import "SVModalWebViewController.h"
#import "PBSettingsViewController.h"

@interface XNViewController ()

@property (strong, nonatomic) SVWebViewController *webVC;
@end

@implementation XNViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self) {
    self.webVC = [[SVWebViewController alloc] initWithAddress:@"https://www.google.com.hk"];
    [self setViewControllers:@[self.webVC]];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.webVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                                 UIBarButtonSystemItemOrganize target:nil action:nil];
  
  self.webVC.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    
    PBSettingsViewController *settingsVC = [[PBSettingsViewController alloc] initWithAddress:@"http://www.pku.edu.cn"];
    
    [self pushViewController:settingsVC animated:YES];
    return [RACSignal empty];
  }];

}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:NO];
  self.webVC.title = self.title;
  self.navigationBarHidden = NO;
}

@end
