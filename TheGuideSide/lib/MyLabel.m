//
//  MyLabel.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextFillRect(contextRef, rect);
    
    [[UIColor redColor] set];
    CGContextAddEllipseInRect(contextRef, CGRectMake(200.0f, 200.0f, 50.0f, 50.0f));
    
    CGContextStrokePath(contextRef);
    
}
+(MyLabel *)initLabelWithImageName:(NSString *)name content:(NSString *)content{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    imageV.image = [UIImage imageNamed:name];
    
    MyLabel *lab = [[MyLabel alloc]init];
    return lab;

}
@end
