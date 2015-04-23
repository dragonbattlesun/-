//
//  YjlyRequest.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YjlyRequest : NSObject

/**
 *  将字典转化为json
 *
 *  @param params 字典
 *
 *  @return json串
 */
+ (NSString *)param:(NSMutableDictionary *)params;

/**
 *  返回拼接好的URL api
 *S_AJAX/Guid.ashx?cmd=SetWorkDate&param={"ID":"1","Dates":"2013-02-12,2015-05-23"}
 *  @param PostURl   请求的地址 Guid.ashx
 *  @param CmdName   SetWorkDate
 *  @param Parameter {"ID":"1","Dates":"2013-02-12,2015-05-23"} 的一个字典
 *
 *  @return URL地址
 */
+(NSString*)UrlParamer:(NSString *)PostURl CmdName:(NSString*)CmdName Parameter:(NSMutableDictionary*)Parameter;




/**
 *  将字典转换为json格式
 *
 *  @param params NSMutableDictionary
 *
 *  @return 字符串
 */
+(NSString *)URLSplicing:(NSMutableDictionary *)params;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+(id)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  计算工作时间
 *
 *  @param compareDate 开始工作时间
 *
 *  @return
 */
+(NSString *)compareCurrentTime:(NSString*) compareDate  IsSub:(BOOL)IsSub;


/**
 *  时间类型格式转换
 *
 *  @param compareDate 时间字符串
 *  @param Format      这里可以设置成自己需要的时间格式 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回指定格式的时间
 */
+(NSString *)GetDateTime:(NSString*) compareDate stringFormat:(NSString*)Format;


/**
 *  根据分隔符返回list
 *
 *  @param str_List     字符串
 *  @param SpliteSymbol 分隔符标示
 *
 *  @return nsArray
 */
+(NSArray *)GetArray:(NSString*)str_List SpliteSymbol:(NSString*)SpliteSymbol;


/**
 *  根据字符串返回高度
 *
 *  @param Text 字符串
 *  @param size 控件size
 *  @param font font 字体
 *
 *  @return 计算后的Size大小
 */
+ (CGSize)boundingRectWith:(NSString*)Text Size:(CGSize)size TextFont:(UIFont*)font;


/**
 *  整形转字符串
 *
 *  @param PageIndex NSInteger
 *
 *  @return 返回字符串
 */
+(NSString*)PageIndexToString:(NSInteger)PageIndex;

/**
 * ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 *  设置时区,这个对于时间的处理有时很重要
 *  例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
 *  例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
 *  他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
 *
 *  @param StrDate
 *
 *  @return
 */
+(NSString*)GetTimeSpan:(NSString*)StrDateTime DateFormat:(NSString*)DateFormat;

+(NSString *)decodeString:(NSString*)encodedString;

/**
 *  服务器处理不了  保存图片到app
 *
 *  @param ArrayAsset 数组
 *  @param path       文件路径
 *
 *  @return 返回一个数组
 */
+(NSMutableDictionary*)writeAsset:(NSArray *)ArrayAsset toPath:(NSString *)path;

/**
 *  删除上传的图片
 *
 *  @param ImageList 图片数组
 */
+(void)DeleteImage:(NSMutableDictionary *)ImageList;
/**
 *  保存图片到app
 *
 *  @param ArrayAsset 数组
 *  @param path       文件路径
 *
 *  @return 返回一个数组
 */

/**
 *  将秒转换为时分
 *
 *  @param RecordTime 录入的时间单位是秒
 *
 *  @return 返回 HH:mm:dd 格式的时间
 */
+(NSString*)SecondToTime:(NSString *)RecordTime;

+(NSMutableDictionary*)writeAsset:(NSArray *)ArrayAsset toPath:(NSString *)path rename:(NSString*)fileName;
+(void)DownloadImage:(NSString*)ImageUrl ImageCount:(NSInteger)ImageCount;
/**
 *  设置文本属性
 *
 *  @param MutableParagraph NSMutableParagraphStyle 设置文本的样式
 *  @param AttributeText    文本的内容
 *
 *  @return 加了样式的文本
 */



+(NSMutableAttributedString*)SetTextStyle:(NSMutableParagraphStyle*)MutableParagraph AttributeText:(NSString*)AttributeText;

//下面是个解决应用图片旋转或颠倒的bug：

+ (UIImage *)fixOrientation:(UIImage *)aImage ;
//
+(NSString *)NSURLError:(NSInteger) HttpStatus;

@end
