//
//  NSString+AutoHeight.m
//  定制Cell的自适应
//
//  Created by Joel on 14-3-24.
//  Copyright (c) 2014年 Joel. All rights reserved.
//

#import "NSString+AutoHeight.h"

@implementation NSString (AutoHeight)

+ (CGFloat)getHeightOfLabelText:(NSString *)text lableWidth:(CGFloat)width textFontSize:(CGFloat)fontSize
{
    //用于接收最终返回的高度
    CGFloat max_height = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue]< 7.0){
        
        // 根据字符串拿到高度 sizeWithFont设置字体 constrainedToSize设置文本绘制的范围
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        //每行最小高度44
       // max_height = MAX(size.height, 60.0f);
        max_height = size.height;
    }else{
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        CGSize size = [text boundingRectWithSize:CGSizeMake(width, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        //每行最小高度44
       // max_height = MAX(size.height, 60.0f);
        max_height = size.height;
    }
    //返回我们需要的高度 允许有20个点的浮动
    return max_height;
}
//计算单行文本的宽度
+(CGSize)get:(NSString *)string andFont:(CGFloat)font{
    
    return  [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}
@end
