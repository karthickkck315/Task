//
//  UIFont+CustomFont.m
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//


#import "UIFont+CustomFont.h"


@implementation UIFont (CustomFont)

// English title font
+(UIFont*)customEnglishTitleFont
{
    return [UIFont systemFontOfSize:18.0f];
}

// medium regular font
+(UIFont*)customEnglishFontRegular16
{
    return [UIFont systemFontOfSize:16.0f];
}

// medium regular font
+(UIFont*)customEnglishFontRegular14
{
    return [UIFont systemFontOfSize:14.0f];
}

// medium bold font
+(UIFont*)customEnglishFontBold14
{
    return [UIFont boldSystemFontOfSize:14.0f];
}

// small regular font
+(UIFont*)customEnglishFontRegular10
{
    return [UIFont systemFontOfSize:12.0f];
}

// small bold font
+(UIFont*)customEnglishFontBold10
{
    return [UIFont boldSystemFontOfSize:12.0f];
}

+(UIFont*)customEnglishFontBold8
{
    return [UIFont boldSystemFontOfSize:10.0f];
}


@end
