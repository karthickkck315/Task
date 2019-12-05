//
//  GlobalClass.h
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Constant.h"
#import "NSString+validation.h"
#import "STHTTPRequest.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD.h"

@interface GlobalClass : NSObject <UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
}

+(void)showToast:(NSString *)title message:(NSString *)Message view:(UIViewController *)View;

+(void)showAlertwithtitle:(NSString *)title message:(NSString *)Message view:(UIViewController *)View;

+ (GlobalClass *)sharedInstance;

+(BOOL)networkConnectAvailable;

+(BOOL)isEmptyString:(NSString *)string;

+(BOOL)isEmptyData:(NSData *)string;

- (id)init;

+(MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title controller:(UIView *)view;

+(void)dismissGlobalHUD:(UIView *)view;

+(UIImage *)changeImageColor:(UIImage *)image color:(UIColor*)newColor;

+(CGRect)dynamicHeight:(NSString *)string font:(UIFont *)font size:(CGSize)size;

+(CGFloat)heightForLabel:(UIFont *)labelFont withText:(NSString *)text;
@end
