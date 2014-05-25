//
//  PBPlugin.h
//  PlugableBrowser
//
//  Created by wuhaotian on 5/24/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBPluginManager.h"

@interface PBPlugin : NSObject

+ (id)pluginWithPath:(NSString *)path;
- (void)feedEvent:(PBJSEvent)event;

@end
