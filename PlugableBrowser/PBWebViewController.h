//
//  PBWebViewController.h
//  PlugableBrowser
//
//  Created by wuhaotian on 5/25/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "SVWebViewController.h"

@interface PBWebViewController : SVWebViewController

- (void)loadURLString:(NSString *)url;
- (void)eval:(NSString *)string;
@end
