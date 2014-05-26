//
//  PBRequestManager.m
//  PlugableBrowser
//
//  Created by wuhaotian on 5/25/14.
//  Copyright (c) 2014 wuhaotian. All rights reserved.
//

#import "PBRequestManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PBJSRequestProtocol <JSExport>

JSExportAs(get,
- (void)get:(NSString *)url callback:(JSValue *)handler
           );

JSExportAs(post,
- (void)post:(NSString *)url params:(NSDictionary *)params callback:(JSValue *)handler
           );
@end


@interface PBRequestManager () <PBJSRequestProtocol>

@end

@implementation PBRequestManager

+ (instancetype)manager {

  PBRequestManager *manager = [super manager];
  if (manager) {
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  }
  return manager;
}

- (void)get:(NSString *)url callback:(JSValue *)handler {
  [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
    [handler callWithArguments:@[@(operation.response.statusCode), operation.responseString]];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%@", error);
    
  }];
}

- (void)post:(NSString *)url params:(NSDictionary *)params callback:(JSValue *)handler {
  [self POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
  }];
}
@end
