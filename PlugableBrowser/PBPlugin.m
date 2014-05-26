//
//  PBPlugin.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/24/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBPlugin.h"
#import "PBPluginManager.h"
#import "PBRequestManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface PBPlugin ()

@property (nonatomic) JSContext *context;
@property (nonatomic) JSValue *export;

@end

@implementation PBPlugin

+ (id)pluginWithPath:(NSString *)path {
  return [[self alloc] initWithPath:path];
}

- (id)initWithPath:(NSString *)path {
  
  self.context = [[JSContext alloc] init];
  
  JSValue *console = [JSValue valueWithNewObjectInContext:self.context];
  
  console[@"log"] = ^void(NSString *string) {
    NSLog(@"Plugin: %@", string);
  };
  
  self.context[@"console"] = console;
  self.context[@"App"] = [PBPluginManager sharedManager];
  self.context[@"Http"] = [PBRequestManager manager];
  NSString* js = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding];
  
  [self.context evaluateScript:js];
  
  if (self.context.exception) {
    NSLog(@"%@", self.context.exception);
  }
  
  self.export = self.context[@"Plugin"];
  [self.context setExceptionHandler:^(JSContext *context, JSValue *exception) {
    NSLog(@"%@", exception);
  }];
  
  [self feedEvent: PluginEventLoaded];
  
  return self;
}

- (void)checkExceptions {
}


- (void)feedEvent:(PBJSEvent)event {
  
  [self.export invokeMethod:@"feedEvent" withArguments:@[@(event)]];
  
  
}

@end
