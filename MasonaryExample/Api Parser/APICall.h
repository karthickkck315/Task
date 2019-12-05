//
//  APICall.h
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import "GlobalClass.h"
#import <Foundation/Foundation.h>

@interface APICall : NSObject<NSURLSessionDelegate>
{
    NSMutableData *receivedData;
    NSURLSession *serverConnection;
    id classNameDelegate;
    NSString *keyString;

}
@property(nonatomic,strong) NSMutableData *receivedData;

+ (APICall *)sharedInstance;

-(void)url:(NSString *)url user:(NSString *)user_id  PostBody:(NSDictionary *)body method:(NSString *)Method  completion:(void(^)(NSDictionary* jsonDict))handler error:(void(^)(NSString *errorStr))getError;

@end
