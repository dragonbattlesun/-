//
//  UserComment.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "UserComment.h"

@implementation UserComment
-(instancetype)initWithDataImage:(NSString *)image andName:(NSString *)name andTime:(NSString *)time andContent:(NSString *)content andSocre:(NSString *)socre andNumber:(NSString *)number andConment:(NSString *)conment{
    self = [super init];
    if (self) {
        self.imagename =image;
        self.name = name;
        self.time =time;
        self.content = content;
        self.score =socre;
        self.number =number;
        self.conment =conment;
    }
    return self;
}
-(NSString *)name{
    return @"用户名";
}
-(NSString *)time{
 return    @"23113";
}
-(NSString *)score{
    return @"好评";
}
-(NSString *)number{
    return @"订单编号：111111";
}
-(NSString *)content{
    return @"滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答eeeeeeef滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答的";

}
-(NSString *)imagename{
    return @"tou_03";
}
-(NSString *)conment{
    return @"万晓:哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥哥";
   // return @"";
}
@end
