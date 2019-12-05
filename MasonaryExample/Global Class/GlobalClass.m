//
//  GlobalClass.m
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import "GlobalClass.h"
#import "UIColor+custom.h"


#define IS_IOS_GREATER_EQUAL8     ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
@interface GlobalClass () <UITextFieldDelegate>
{
    
}
@end

@implementation GlobalClass

+ (GlobalClass *)sharedInstance
{
    static GlobalClass *sharedInstance;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


# pragma mark - Alert
+(void)showAlertwithtitle:(NSString *)title message:(NSString *)Message view:(UIViewController *)View
{
    if (IS_IOS_GREATER_EQUAL8)
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:Message
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
        [alertController addAction:okAction];
        [View presentViewController:alertController animated:YES completion:nil];
    }

    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:title message:Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        
        [alert1 show];
    }
    
}

# pragma mark - Toast
//toast
+(void)showToast:(NSString *)title message:(NSString *)Message view:(UIViewController *)View
{
    if (IS_IOS_GREATER_EQUAL8)
    {
        UIAlertController * alert=   [UIAlertController alertControllerWithTitle:nil message:Message preferredStyle:UIAlertControllerStyleAlert];
      [View presentViewController:alert animated:YES completion:nil];
        int duration = 1; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [View dismissViewControllerAnimated:YES completion:nil];
        });
    }
    else
    {
        UIAlertView *toast= [[UIAlertView alloc] initWithTitle:nil message:Message delegate:View cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}

# pragma mark - Check network connection
//Network Availablity
+(BOOL)networkConnectAvailable
{
    
    Reachability *reach=[Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus internetStatus= [reach currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


# pragma mark - Validation
// is string or textfield empty validation
+(BOOL)isEmptyString:(NSString *)string
{
    if ((NSNull *)string == [NSNull null] || (string == nil) || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"])
    {
        return  YES;
    }
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

// IsData is empty
+(BOOL)isEmptyData:(NSData *)string
{
    if ((NSNull *)string == [NSNull null] || (string == nil))
    {
        return  YES;
    }
    return NO;
}

# pragma Mark - activity progress
// progress view start
+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title controller:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
   hud.labelText = @"Please wait...";
    hud.labelFont = [UIFont customEnglishTitleFont];
    hud.labelColor = [UIColor whiteColor];
    return hud;
}
// progress view dismiss
+ (void)dismissGlobalHUD:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}

+(UIImage *)changeImageColor:(UIImage *)image color:(UIColor*)newColor
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [newColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}

+(CGRect)dynamicHeight:(NSString *)string font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect;
}
+(CGFloat)heightForLabel:(UIFont *)labelFont withText:(NSString *)text{
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:labelFont}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){[UIScreen mainScreen].bounds.size.width-80, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return ceil(rect.size.height);
}


@end
