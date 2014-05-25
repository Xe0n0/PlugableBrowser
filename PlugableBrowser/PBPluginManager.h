//
//  PBPluginManager.h
//  PlugableBrowser
//
//  Created by wuhaotian on 5/23/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef enum {
  PluginEventLoaded = 1,
  
  WebViewEventShouldLoad = 11,
  WebViewEventStartLoading,
  WebViewEventFinished,
  WebViewEventErrorLoading
  
}PBJSEvent;


@protocol PBAppProtocol <JSExport>

- (void)sendNotification:(JSValue *)value;

@end

@interface PBPluginManager : NSObject <PBAppProtocol>

+ (id)sharedManager;
- (void)loadAllPlugins;
- (void)loadPluginAtPath:(NSString *)string;
- (BOOL)feedEvent:(PBJSEvent )event;
@end
