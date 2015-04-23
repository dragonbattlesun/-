//
//  NSString+AutoHeight.h
//  定制Cell的自适应
//
//  Created by Joel on 14-3-24.
//  Copyright (c) 2014年 Joel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AutoHeight)

+ (CGFloat)getHeightOfLabelText:(NSString *)text lableWidth:(CGFloat)width textFontSize:(CGFloat)fontSize;
+(CGSize)get:(NSString *)string andFont:(CGFloat)font;
@end
