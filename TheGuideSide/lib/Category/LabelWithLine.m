
//

#import "LabelWithLine.h"

@implementation LabelWithLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor=[UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存上下文状态
    CGContextSaveGState(context);
    {
        
        [self.text drawInRect:self.bounds withFont:[UIFont systemFontOfSize:11.0f] lineBreakMode:(NSLineBreakByCharWrapping)];
        //计算出直线的位置
        int x=self.bounds.origin.x;
        int y=self.bounds.origin.y;
        int weidth=self.bounds.size.width;
        int heighth=self.bounds.size.height;
        //创建贝塞尔曲线，并赋予路径
        self.path=[UIBezierPath bezierPath];
        CGPoint p1=CGPointMake(x,(y+heighth)/2);
        CGPoint p2=CGPointMake(x+weidth-0, (y+heighth)/2);
        [self.path moveToPoint:p1];
        [self.path addLineToPoint:p2];
        //设置画笔颜色
        [[UIColor whiteColor]setStroke];
        [self.path setLineWidth:1.0];
        //画出直线
        [self.path stroke];
//        self.textColor = [UIColor whiteColor];

    }
    CGContextRestoreGState(context);
}
+(LabelWithLine *)initLabelWithLineText:(NSString *)text{
    LabelWithLine *label=[[LabelWithLine alloc]init];
  //  label.frame=CGRectMake(216, 44, 104, 25);
    label.text=text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label setNeedsDisplay];
    return label;
}

@end
