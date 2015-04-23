//
//  YjlyRequest.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "YjlyRequest.h"
#import "JSONKit.h"
#import "UzysAssetsViewCell.h"
@implementation YjlyRequest

/**
 *  将字典转化为json
 *
 *  @param params 字典
 *
 *  @return json串
 */
+ (NSString *)param:(NSMutableDictionary *)params {
 return [params JSONString];
}

/**
 *  返回拼接好的URL api
 *S_AJAX/Guid.ashx?cmd=SetWorkDate&param={"ID":"1","Dates":"2013-02-12,2015-05-23"}
 *  @param PostURl   请求的地址 Guid
 *  @param CmdName   SetWorkDate
 *  @param Parameter {"ID":"1","Dates":"2013-02-12,2015-05-23"} 的一个字典
 *
 *  @return <#return value description#>
 */
+(NSString*)UrlParamer:(NSString *)PostURl CmdName:(NSString*)CmdName Parameter:(NSMutableDictionary*)Parameter
{
    
    NSMutableDictionary *dic_Parameter = [NSMutableDictionary dictionary];
    dic_Parameter[@"cmd"] = CmdName;
    dic_Parameter[@"param"] = [YjlyRequest param:Parameter];
    
    NSString *urlString = [NSString stringWithFormat:@"/S_AJAX/%@.ashx?%@", PostURl, [self URLSplicing:dic_Parameter]];
    
    //对url进行utf8编码
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlString;
}


/**
 *  URL 地址JSON格式拼接
 *
 *  @param params 字典形式的参数
 *
 *  @return 返回string 字符串
 */
+(NSString *)URLSplicing:(NSMutableDictionary *)params
{
    NSString *postString=@"";
    
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+(id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



/**
 *  计算工作时间
 *
 *  @param compareDate 开始工作时间
 *
 *  @return
 */
+(NSString *)compareCurrentTime:(NSString*) compareDate IsSub:(BOOL)IsSub
{
    if(IsSub)
    {
        compareDate =[compareDate substringWithRange:NSMakeRange(6, 10)];
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[compareDate longLongValue]];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


/**
 *  时间类型格式转换
 *
 *  @param compareDate 时间字符串
 *  @param Format      这里可以设置成自己需要的时间格式 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回指定格式的时间
 */
+(NSString *)GetDateTime:(NSString*) compareDate stringFormat:(NSString*)Format
{
    @try {
        
        compareDate=[compareDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
        compareDate=[compareDate stringByReplacingOccurrencesOfString:@"Date(" withString:@""];
        compareDate=[compareDate stringByReplacingOccurrencesOfString:@"+0800)" withString:@""];
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[compareDate longLongValue]/1000];
        /**
         初始化 一个时间格式的类 NSDateFormatter
         */
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:Format];
        
        NSString *currentDateStr = [dateFormatter stringFromDate:confromTimesp];
        
        return  currentDateStr;
    }
    @catch (NSException *exception) {
        
        return  @"--";
    }
    @finally {
        
    }
}
/**
 *  根据分隔符返回list
 *
 *  @param str_List     字符串
 *  @param SpliteSymbol 分隔符标示
 *
 *  @return nsArray
 */
+(NSArray *)GetArray:(NSString*)str_List SpliteSymbol:(NSString*)SpliteSymbol
{
    @try {
        
        NSArray *returnArray=[str_List componentsSeparatedByString:SpliteSymbol];
        
        return returnArray;
        
    }
    @catch (NSException *exception) {
        
        return  nil  ;
    }
    @finally {
        
    }
}


/**
 *  根据字符串返回高度
 *
 *  @param Text 字符串
 *  @param size 控件size
 *  @param font font 字体
 *
 *  @return 计算后的Size大小
 */
+ (CGSize)boundingRectWith:(NSString*)Text Size:(CGSize)size TextFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [Text boundingRectWithSize:size
                                                      options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                   attributes:attribute
                                                      context:nil].size;
    
    return retSize;
}


/**
 *  整形转字符串
 *
 *  @param PageIndex NSInteger
 *
 *  @return 返回字符串
 */
+(NSString*)PageIndexToString:(NSInteger)PageIndex
{
    return  [NSString stringWithFormat:@"%zd",PageIndex];
}


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
+(NSString*)GetTimeSpan:(NSString*)StrDateTime DateFormat:(NSString*)DateFormat
{
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:DateFormat];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:TimeZoneWithName];
    [formatter setTimeZone:timeZone];
    
    NSDate* StrToDate = [formatter dateFromString:StrDateTime]; //------------将字符串按formatter转成nsdate
   
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[StrToDate timeIntervalSince1970]];
 
    return [self compareCurrentTime:timeSp IsSub:NO];
}


//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


/**
 *  保存图片到app
 *
 *  @param ArrayAsset 数组
 *  @param path       文件路径
 *
 *  @return 返回一个数组
 */
+(NSMutableDictionary*)writeAsset:(NSArray *)ArrayAsset toPath:(NSString *)path
{
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc] init];
    for (ALAsset *asset in ArrayAsset) {
        
        ALAssetRepresentation *representation = asset.defaultRepresentation;
       NSString *ImagePath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",representation.filename]];
        
       UIImage * appleImage =[UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage
                                   scale:asset.defaultRepresentation.scale
                             orientation:(UIImageOrientation)asset.defaultRepresentation.orientation];
//        UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:ImagePath];
         appleImage = [YjlyRequest  fixOrientation:appleImage];
        
//        unsigned long size =(unsigned long) representation.size;
//        NSMutableData *rawData = [[NSMutableData alloc] initWithCapacity:size];
//        void *buffer = [rawData mutableBytes];
//        [representation getBytes:buffer fromOffset:0 length:size error:nil];
//        NSData *assetData = [[NSData alloc] initWithBytes:buffer length:size];
//        
//        
        
        
            NSData*assetData = UIImageJPEGRepresentation(appleImage, 0.3);

        [assetData writeToFile:ImagePath atomically:YES];
        
        [dictionary setValue:ImagePath forKey:representation.filename];
    }
    
    return dictionary;
}


/**
 *  删除上传的图片
 *
 *  @param ImageList 图片数组
 */
+(void)DeleteImage:(NSMutableDictionary *)ImageList
{
    NSFileManager *manager =[NSFileManager defaultManager];
    for (NSString *KeyFile in ImageList) {
        
        if ([manager fileExistsAtPath:[ImageList objectForKey:KeyFile] isDirectory:NO]) {
            [manager removeItemAtPath:[ImageList objectForKey:KeyFile] error:nil];
        }
    }
    
}


-(NSString *)NSURLError:(NSInteger) HttpStatus
{
//    kCFURLErrorUnknown = -998,
//    kCFURLErrorCancelled = -999,
//    kCFURLErrorBadURL = -1000,
//    kCFURLErrorTimedOut = -1001,
//    kCFURLErrorUnsupportedURL = -1002,
//    kCFURLErrorCannotFindHost = -1003,
//    kCFURLErrorCannotConnectToHost = -1004,
//    kCFURLErrorNetworkConnectionLost = -1005,
//    kCFURLErrorDNSLookupFailed  = -1006,
//    kCFURLErrorHTTPTooManyRedirects = -1007,
//    kCFURLErrorResourceUnavailable = -1008,
//    kCFURLErrorNotConnectedToInternet = -1009,
//    kCFURLErrorRedirectToNonExistentLocation = -1010,
//    kCFURLErrorBadServerResponse    = -1011,
//    kCFURLErrorUserCancelledAuthentication = -1012,
//    kCFURLErrorUserAuthenticationRequired = -1013,
//    kCFURLErrorZeroByteResource  = -1014,
//    kCFURLErrorCannotDecodeRawData  = -1015,
//    kCFURLErrorCannotDecodeContentData = -1016,
//    kCFURLErrorCannotParseResponse  = -1017,
//    kCFURLErrorInternationalRoamingOff = -1018,
//    kCFURLErrorCallIsActive    = -1019,
//    kCFURLErrorDataNotAllowed    = -1020,
//    kCFURLErrorRequestBodyStreamExhausted = -1021,
//    kCFURLErrorFileDoesNotExist   = -1100,
//    kCFURLErrorFileIsDirectory   = -1101,
//    kCFURLErrorNoPermissionsToReadFile = -1102,
//    kCFURLErrorDataLengthExceedsMaximum = -1103,
    
    return  @"";
}
/**
 *  保存图片到app
 *
 *  @param ArrayAsset 数组
 *  @param path       文件路径
 *  @param fileName 重命名的文件名称
 *  @return 返回一个数组
 */
+(NSMutableDictionary*)writeAsset:(NSArray *)ArrayAsset toPath:(NSString *)path rename:(NSString*)fileName
{
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc] init];
    for (ALAsset *asset in ArrayAsset) {
        
        ALAssetRepresentation *representation = asset.defaultRepresentation;
 NSString *ImagePath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",fileName]];
        unsigned long size =(unsigned long) representation.size;
        NSMutableData *rawData = [[NSMutableData alloc] initWithCapacity:size];
        void *buffer = [rawData mutableBytes];
        [representation getBytes:buffer fromOffset:0 length:size error:nil];
        NSData *assetData = [[NSData alloc] initWithBytes:buffer length:size];
        [assetData writeToFile:ImagePath atomically:YES];
        
        [dictionary setValue:ImagePath forKey:fileName];
    } 
    
    return dictionary;
}

+(void)DownloadImage:(NSString*)ImageUrl ImageCount:(NSInteger)ImageCount
{
    @try {
        
        NSArray *ImageList=[YjlyRequest GetArray:ImageUrl SpliteSymbol:@","];
        
        if (ImageCount == 0) {
            
            ImageCount = [ImageList count];
        }
        
        if(ImageCount > 0)
        {
            for (int i=0; i< ImageCount; i++) {
                
                NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:i ]];
                NSURL *ImageUrl= [NSURL URLWithString:url];
                
                SDWebImageManager *ImageManager=[SDWebImageManager sharedManager];
                BOOL IsCache= [[SDImageCache sharedImageCache]diskImageExistsWithKey:url];
                
                if (!IsCache) {
                    
                    [ImageManager downloadImageWithURL:ImageUrl options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                        [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
                    }];
                }
            }
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        
    }
}
/**
 *  将秒转换为时分
 *
 *  @param RecordTime 录入的时间单位是秒
 *
 *  @return 返回 HH:mm:dd 格式的时间
 */
+(NSString*)SecondToTime:(NSString *)RecordTime
{
    NSString *tmphh = [NSString stringWithFormat:@"%d",[RecordTime intValue]/3600];
    if ([tmphh length] == 1)
    {
        tmphh = [NSString stringWithFormat:@"0%@",tmphh];
    }
    NSString *tmpmm = [NSString stringWithFormat:@"%d",([RecordTime intValue]/60)%60];
    if ([tmpmm length] == 1)
    {
        tmpmm = [NSString stringWithFormat:@"0%@",tmpmm];
    }
    NSString *tmpss = [NSString stringWithFormat:@"%d",[RecordTime intValue]%60];
    if ([tmpss length] == 1)
    {
        tmpss = [NSString stringWithFormat:@"0%@",tmpss];
    }
    if (![tmphh isEqualToString:@"00"]) {
        
        RecordTime = [NSString stringWithFormat:@"%@:%@:%@",tmphh,tmpmm,tmpss];
    }else
    {
        RecordTime = [NSString stringWithFormat:@"%@:%@",tmpmm,tmpss];
    }
    
    return RecordTime;
}


/**
 *  设置文本属性
 *
 *  @param MutableParagraph NSMutableParagraphStyle 设置文本的样式
 *  @param AttributeText    文本的内容
 *
 *  @return 加了样式的文本
 */
+(NSMutableAttributedString*)SetTextStyle:(NSMutableParagraphStyle*)MutableParagraph AttributeText:(NSString*)AttributeText
{
    NSMutableAttributedString *MutableAttributed = [[NSMutableAttributedString alloc] initWithString:AttributeText];
    
    [MutableAttributed addAttribute:NSParagraphStyleAttributeName value:MutableParagraph range:NSMakeRange(0, MutableAttributed.length)];
    
    return MutableAttributed;
}



//下面是个解决应用图片旋转或颠倒的bug：

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+(NSString *)NSURLError:(NSInteger) HttpStatus
{
    
    
    switch (HttpStatus) {
        case -998:
            return  @"未知的错误,请联系开发者";
            break;
        case -999:
            return  @"URL地址被取消了";
            break;
        case -1001:
            return  @"链接服务器超时";
            break;
        case -1002:
            return  @"非法的链接地址";
            break;
        case -1003:
            return  @"未识别的服务器地址";
            break;
        case -1004:
            return  @"无法连接到主机";
            break;
        case -1005:
            return  @"网络连接丢失";
            break;
        case -1006:
            return  @"DNS查找失败";
            break;
        case -1007:
            return  @"HTTP的重定向次数太多";
            break;
        case -1008:
            return  @"资源不可用";
            break;
        case -1009:
            return  @"无法连接到互联网";
            break;
        case -1010:
            return  @"重定向到不存在的位置";
            break;
        case -1011:
            return  @"服务器暂无响应";
            break;
        case -1100:
            return  @"您访问的连接不正确";
            break;
        case -1102:
            return  @"您没有访问权限";
            break;
        default:
            return  @"未知错误";
            break;
    }
    
    
    
    //    kCFURLErrorUnknown = -998,
    //    kCFURLErrorCancelled = -999,
    //    kCFURLErrorBadURL = -1000,
    //    kCFURLErrorTimedOut = -1001,
    //    kCFURLErrorUnsupportedURL = -1002,
    //    kCFURLErrorCannotFindHost = -1003,
    //    kCFURLErrorCannotConnectToHost = -1004,
    //    kCFURLErrorNetworkConnectionLost = -1005,
    //    kCFURLErrorDNSLookupFailed  = -1006,
    //    kCFURLErrorHTTPTooManyRedirects = -1007,
    //    kCFURLErrorResourceUnavailable = -1008,
    //    kCFURLErrorNotConnectedToInternet = -1009,
    //    kCFURLErrorRedirectToNonExistentLocation = -1010,
    //    kCFURLErrorBadServerResponse    = -1011,
    //    kCFURLErrorUserCancelledAuthentication = -1012,
    //    kCFURLErrorUserAuthenticationRequired = -1013,
    //    kCFURLErrorZeroByteResource  = -1014,
    //    kCFURLErrorCannotDecodeRawData  = -1015,
    //    kCFURLErrorCannotDecodeContentData = -1016,
    //    kCFURLErrorCannotParseResponse  = -1017,
    //    kCFURLErrorInternationalRoamingOff = -1018,
    //    kCFURLErrorCallIsActive    = -1019,
    //    kCFURLErrorDataNotAllowed    = -1020,
    //    kCFURLErrorRequestBodyStreamExhausted = -1021,
    //    kCFURLErrorFileDoesNotExist   = -1100,
    //    kCFURLErrorFileIsDirectory   = -1101,
    //    kCFURLErrorNoPermissionsToReadFile = -1102,
    //    kCFURLErrorDataLengthExceedsMaximum = -1103,
    
    return  @"";
}
@end
