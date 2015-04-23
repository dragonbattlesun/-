//
//  Language.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "Language.h"

@implementation Language
-(instancetype)initWithGuide:(NSString *)guide andUser:(NSString *)user andContent:(NSString *)content{
    self = [super init];
    if (self) {
        self.guide =guide;
        self.user =user;
        self.content =content;
    }
    return self;
}
-(NSString *)guide{
    return @"1111";
}
-(NSString *)user{
    return @"33";
}
-(NSString *)content{
    //return @"<settings>用户名</settings> ：说的很饿呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵额呵。";


    return @"<help>导游名</help> 回复 <settings>用户名</settings> ：说的很饿呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵额呵。";
}
@end
