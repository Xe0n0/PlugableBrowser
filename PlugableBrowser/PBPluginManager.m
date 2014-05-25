//
//  PBPluginManager.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/23/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBPluginManager.h"
#import "PBPlugin.h"

@interface PBPluginManager ()

@property (nonatomic) JSContext *context;
@property (nonatomic) JSValue *export;
@property (strong, nonatomic) NSString* rootPath;
@property (nonatomic, strong) NSMutableArray *arrayPlugins;
@end

@implementation PBPluginManager

+ (id)sharedManager {
  
  static dispatch_once_t onceToken;
  static PBPluginManager *sharedInstance;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}

- (id)init {
  
  self = [super init];
  if (self) {
    self.arrayPlugins = [NSMutableArray array];
  }
  return self;
}

- (void)loadAllPlugins
{
  if (!self.rootPath) {
    self.rootPath = @"Plugins";
  }
  
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
  
  NSString *directory = [paths[0] stringByAppendingPathComponent:self.rootPath];
  
  NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
  
  for (NSString *filename in fileArray)  {
    
    NSString *path = [directory stringByAppendingPathComponent:filename];
    
    [self loadPluginAtPath:path];
    
  }

}

- (void)loadPluginAtPath:(NSString *)path
{
  
  PBPlugin *plugin = [PBPlugin pluginWithPath:path];
  
  if (plugin) {
    [self.arrayPlugins addObject:plugin];
  }
  else
    NSLog(@"failed to load plugin");
  
}

- (BOOL)feedEvent:(PBJSEvent)event {
  
  for (PBPlugin *plugin in self.arrayPlugins) {
    [plugin feedEvent:event];
  }
  
  return YES;
}

@end
