//
//  CONSNT.h
//  税务影响
//
//  Created by xingjichao on 14-9-12.
//  Copyright (c) 2014年 Jehovah. All rights reserved.
//

#ifndef _____CONSNT_h
#define _____CONSNT_h

#define PageSize @"20"

#define  MJDuration 2.0
//////主域名
#define DomainURL @"http://app.yanjinglvyou.com"
////MKNetwork请求的host
#define AppHostName @"app.yanjinglvyou.com"

//#define DomainURL @"http://192.168.1.77"
//# define AppHostName @"192.168.1.77"
#define AppPort 2200

#define MKNetWorkPort [[MKNetworkEngine alloc]initWithHostName:AppHostName portNumber:AppPort apiPath:nil customHeaderFields:nil]


#define YJLY_MKNetWorkPort [[MKNetworkEngine alloc]initWithHostName:AppHostName customHeaderFields:headerFields]

//不加端口
#define  YJLY_MKNetWork [[MKNetworkEngine alloc]initWithHostName:AppHostName customHeaderFields:nil]
//加端口的
//#define YJLY_MKNetWork [[MKNetworkEngine alloc]initWithHostName:AppHostName portNumber:AppPort apiPath:nil customHeaderFields:nil]

////主域名
//#define DomainURL @"http://192.168.1.96:2200"
////MKNetwork请求的host
//#define AppHostName @"192.168.1.96"
//#define AppPort 2200
//#define DomainURL @"app.yanjinglvyou.com"

//设置userDefault
#define UserDefaults [NSUserDefaults standardUserDefaults]

#define VisitURL(url) [NSString stringWithFormat:@"%@",url];
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#pragma  定义字体部分 Begin

///我的主页 四个字的字体设置
#define MyHomeFont [UIFont systemFontOfSize:20 weight:20]
#define Font_15 [UIFont systemFontOfSize:15]
#define Font_15_Weight [UIFont systemFontOfSize:15 weight:20]

#define yjlyseleted WJColor(36, 143, 244)
#define yjlynormal WJColor(147, 147, 147)

//硬件大小
#define kScreenBounds                      [UIScreen mainScreen] bounds]
//获取设备的物理高度
#define kScreenHeight                      [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define kScreenWidth                       ([UIScreen mainScreen].bounds.size.width)
#define TimeZoneWithName @"Asia/Shanghai"
#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//http://tp.053498.com
#endif
