//
//  APICall.m
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import "APICall.h"

#define IS_IOS_GREATER_EQUAL8     ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)


@implementation APICall
@synthesize receivedData;

+ (APICall *)sharedInstance {
    static APICall *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init {
    self = [super init];
    if (self){
    }
    return self;
}


-(void)url:(NSString *)url user:(NSString *)user_id  PostBody:(NSDictionary *)body method:(NSString *)Method completion:(void(^)(NSDictionary* jsonDict))handler error:(void(^)(NSString *errorStr))getError
{
    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __block STHTTPRequest *request = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@",encodedUrl]];
    if ([Method isEqualToString:@"POST"]) {
         request.HTTPMethod = @"POST";
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString = %@",jsonString);
        [request setHeaderWithName:@"Access-Control-Allow-Origin" value:@"*"];
        [request setHeaderWithName:@"Content-Type" value:@"application/json"];
        request.rawPOSTData = jsonData;
    } else if ([Method isEqualToString:@"FORM"]) {
         request.HTTPMethod = @"POST";
        request.POSTDictionary = body;
    } else if ([Method isEqualToString:@"GET"]) {
        request.HTTPMethod = @"GET";
        request.POSTDictionary = body;
    }
    request.completionBlock=^(NSDictionary *headers, NSString *body) {
      NSDictionary *jsonDict  = [NSJSONSerialization JSONObjectWithData:[body dataUsingEncoding:NSUTF8StringEncoding]options:0 error:NULL];
            handler(jsonDict);
    };
    request.errorBlock=^(NSError *error) {
        getError(@"error");
        NSLog(@" %@ ",error);
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
    };
    [request startAsynchronous];
}


@end
