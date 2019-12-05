//
//  UIColor+custom.m
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//

#import "UIColor+custom.h"

@implementation UIColor (custom)

// set custom theme color
+(UIColor *)customThemeColor
{
    return [UIColor blackColor];
}

+(UIColor *)GrayBtnColor
{
    return [UIColor colorWithRed:52/255.0 green:60/255.0 blue:77/255.0 alpha:1.0];
}

+(UIColor *)lightTextColortxt
{
    return [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1.0];
}

+(UIColor *)darkTextColortxt
{
    return [UIColor darkGrayColor];
}

@end
