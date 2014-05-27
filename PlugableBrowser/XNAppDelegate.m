//
//  XNAppDelegate.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/22/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "XNAppDelegate.h"
#import "PBPluginManager.h"

@implementation XNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  NSFileManager *fm = [NSFileManager defaultManager];
  NSError *error;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
  
  
  NSString *directory = [paths[0] stringByAppendingPathComponent:@"Plugins"];
  if (![fm fileExistsAtPath:directory isDirectory:NULL]) {
    if (![fm createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error])
      NSLog(@"%@", error);
  }
  
//  NSString *path = [[NSBundle mainBundle] pathForResource:@"IPGate" ofType:@"js"];
  NSString *toPath = [directory stringByAppendingPathComponent:@"IPGate.js"];
  
  if ([fm fileExistsAtPath:toPath isDirectory:NULL]) {
//    [fm removeItemAtPath:toPath error:NULL];
  }
//  [fm copyItemAtPath:path toPath:toPath error:&error];
  if (error) {
    NSLog(@"%@", error);
  }
  
  return YES;
}
							
@end
