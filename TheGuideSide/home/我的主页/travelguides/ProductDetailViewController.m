//
//  ProductDetailViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "LabelWithLine.h"
#import "NSString+AutoHeight.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *bjscro;
@property(nonatomic,strong) UILabel *priceV;
@property(nonatomic,strong) UIView *middlebjV;
@property(nonatomic,strong) UIView *lineV;
@property(nonatomic,strong) UIButton *selectedBtn;
@property(nonatomic,strong) UIView *feature;
@property(nonatomic,strong)UIView *charge; //费用须知
@property(nonatomic,strong)UIView *detail; //行程详情
@property(nonatomic,strong) UIView *contentBjV; // 线路特色

@end

@implementation ProductDetailViewController
-(UIView *)feature{
    if (!_feature) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth , 600)];
        //view.backgroundColor = [UIColor redColor];
        _feature = view;
        [self.contentBjV addSubview:_feature];
    }
    return _feature;
}
-(UIView *)charge{
    if (!_charge) {
        _charge = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth , 600)];
        [self.contentBjV addSubview:_charge];
    }
    return _charge;
}
-(UIView *)detail{
    if (!_detail) {
        _detail = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth , 600) ];
        [self.contentBjV addSubview:_detail];
    }
    return _detail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品详情";
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 900)];
    bjScro.contentSize = CGSizeMake(kScreenWidth, 1000);
    bjScro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bjScro];
    self.bjscro = bjScro;
    
    
    
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 150)];
    imageV.image = [UIImage imageNamed:@"banner"];
    [self.bjscro addSubview:imageV];
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 110, kScreenWidth, 40)];
    bjV.backgroundColor = [UIColor grayColor];
    bjV.alpha = 0.5;
    [imageV addSubview:bjV];
    
    
    
    
    double imageSize = 50;
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-60, 80, 50, 50)];
    imageV2.image = [UIImage imageNamed:@"bg2"];
    [imageV addSubview:imageV2];
//    self.priceV = imageV2;
    //设置uiimageView为圆
    imageV2.layer.masksToBounds = YES;
    // 其實就是設定圓角，只是圓角的弧度剛好就是圖片尺寸的一半
    imageV2.layer.cornerRadius = imageSize / 2.0;
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 50, 25)];
    lab4.text = @"￥1599起";
    lab4.textColor =[UIColor whiteColor];
    lab4.font = [UIFont systemFontOfSize:11];
    [imageV2 addSubview:lab4];
    UIView *bjV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 25, 50, 0.5)];
    bjV2.backgroundColor = [UIColor whiteColor];
    [imageV2 addSubview:bjV2];
    
    LabelWithLine *lab3 = [LabelWithLine initLabelWithLineText:@"￥6300"];
    //WithFrame:CGRectMake(0, imageV2.height/2, 50, 20)];
    lab3.font = [UIFont systemFontOfSize:9];
    lab3.frame = CGRectMake(5, imageV2.height/2-0, 40, 15);
    //    lab3.text = @"￥6000";
    lab3.textColor = [UIColor whiteColor];
    lab3.textAlignment = NSTextAlignmentCenter;
    //    lab3.backgroundColor = [UIColor clearColor];
    //    lab3.textColor =[UIColor whiteColor];
    [imageV2 addSubview:lab3];
    
    
    
    
    
    UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 120, 20, 20)];
    imageV3.image = [UIImage imageNamed:@"renzheng"];
    [imageV addSubview:imageV3];
    
    UIImageView *imageV4 = [[UIImageView alloc]initWithFrame:CGRectMake(150, 120, 20, 20)];
    imageV4.image = [UIImage imageNamed:@"renzheng"];
    [imageV addSubview:imageV4];

    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, bjV.width-10, 20)];
    lab.text = @"国外跟团游";
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:13];
    [imageV addSubview:lab];
//    self.title = lab;
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(170, 120, bjV.width-10, 20)];
    lab2.text = @"北京出发";
    lab2.textColor =[UIColor whiteColor];
    lab2.font = [UIFont systemFontOfSize:13];
    [imageV addSubview:lab2];
//    self.introduce = lab2;

  //------------------------------------------
    
    UIView *bjV3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), kScreenWidth, 165)];
    bjV3.backgroundColor = [UIColor whiteColor];
    [self.bjscro addSubview:bjV3];
     self.middlebjV = bjV3;
    
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 30)];
    lab5.text = @"希腊超生之绿蓝顶教堂";
    //lab.textColor =[UIColor <#lab#>];
    lab5.font = [UIFont systemFontOfSize:15];
    [bjV3 addSubview:lab5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, kScreenWidth-20, 30)];
    lab6.text = @"国外跟团游系列，8晚国际五星，国航";
    lab6.textColor =[UIColor grayColor];
    lab6.font = [UIFont systemFontOfSize:14];
    [bjV3 addSubview:lab6];
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, kScreenWidth-20, 30)];
    lab7.text = @"出发地：北京       目的地：希腊     出行人数：40人";
    lab7.textColor =[UIColor grayColor];
    lab7.font = [UIFont systemFontOfSize:14];
    [bjV3 addSubview:lab7];
    
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 20)];
    lab8.text = @"燕京价：￥1999起";
    lab8.textColor =[UIColor redColor];
    lab8.font = [UIFont systemFontOfSize:15];
    [bjV3 addSubview:lab8];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 125, kScreenWidth, 1)];
    line.backgroundColor = WJColor(242, 242, 242);
    [bjV3 addSubview:line];
    
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 126, kScreenWidth-20, 30)];
    lab9.text = @"行程时间：2015.05.12 - 2015.05.23    产品编号：12233333";
    lab9.textColor =[UIColor grayColor];
    lab9.font = [UIFont systemFontOfSize:14];
    [bjV3 addSubview:lab9];
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 156, kScreenWidth, 9)];
    line2.backgroundColor = WJColor(242, 242, 242);
    [bjV3 addSubview:line2];
    
   
    
    
    
    //-------------------
    
    UIView *bjV4 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(bjV3.frame), kScreenWidth, 600)];
//    bjV4.backgroundColor = [UIColor blueColor];
    [self.bjscro addSubview:bjV4];
    self.contentBjV = bjV4;
    
    NSArray *arr = [NSArray arrayWithObjects:@"线路特色",@"费用须知",@"行程详情", nil];
    CGFloat btnH =  30;
    CGFloat btnY = 0;
    CGFloat btnW = kScreenWidth /3;
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*btnW, btnY, btnW, btnH);
        [button setTitle:  [arr objectAtIndex:i] forState:UIControlStateNormal];
        // button.backgroundColor = WJColor(241, 241, 241);
        // [button setBackgroundImage:[UIImage imageNamed:@"buttonbj1"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [button setTitleColor:WJColor(0, 144, 242) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 1030+i;
        button.selected = NO;
        //button.titleLabel.textColor = [UIColor whiteColor];
        //button.backgroundColor = [UIColor orangeColor];
        //    button.layer.borderColor = [[UIColor grayColor] CGColor];
        //    button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(thireBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bjV4 addSubview:button];
        
    }
   
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth/3, 2)];
    lineV.backgroundColor = WJColor(0, 144, 242);
    [bjV4 addSubview:lineV];
    self.lineV = lineV;
    UIView *line21 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 1)];
    line21.backgroundColor = WJColor(242, 242, 242);
    [bjV4 addSubview:line21];
    
    
    
    
    
    
    
    UIButton *button=(UIButton *)[self.view viewWithTag:1030];
    [self thireBtn: button];
    
}

-(void)thireBtn:(UIButton *)button{
    self.selectedBtn.selected  = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    switch (button.tag) {
        case 1030:  //线路特色
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.lineV.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
            
            
            self.feature.hidden = NO;
            self.charge.hidden = YES;
            self.detail.hidden = YES;
//            [self.contentBjV addSubview:self.feature];
            
            [self  loadFeature];
            
        }
            break;
        case 1031:  //费用须知
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.lineV.transform = CGAffineTransformMakeTranslation( self.lineV.width , 0);
            } completion:^(BOOL finished) {
            }];
            self.feature.hidden = YES;
            self.charge.hidden = NO;
            self.detail.hidden =YES;
            [self loadCharge];
            
        }
            
            break;
        case 1032:  //行程详情
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.lineV.transform = CGAffineTransformMakeTranslation( self.lineV.width*2 , 0);
            } completion:^(BOOL finished) {
            }];
            
            self.feature.hidden = YES;
            self.charge.hidden = YES;
            self.detail.hidden =NO;
            [self loadDetail];
            
        }
            break;
            
            break;
    }

}
-(void)loadFeature{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
    imageV.image = [UIImage imageNamed:@"xx-1"];
    [self.feature addSubview:imageV];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
    lab.text = @"品牌故事";
   // lab.textColor =[UIColor blackColor];
    lab.font = [UIFont boldSystemFontOfSize:14];
    [self.feature addSubview:lab];
    
    
    NSString *str = @"ddddddddddd";
    
   CGFloat height =  [NSString getHeightOfLabelText:str lableWidth:kScreenWidth-20 textFontSize:14];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-20, height)];
    lab2.text = str;
    lab2.textColor =[UIColor grayColor];
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.numberOfLines = 0;
    lab2.lineBreakMode = NSLineBreakByWordWrapping;
    [self.feature addSubview:lab2];
    
    
    
    
    //------------------
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab2.frame)+30, 10, 10)];
    imageV2.image = [UIImage imageNamed:@"xx-1"];
    [self.feature addSubview:imageV2];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab2.frame)+30, 100, 20)];
    lab3.text = @"设计灵感";
    //lab3.textColor =[UIColor redColor];
    lab3.font = [UIFont boldSystemFontOfSize:14];
    [self.feature addSubview:lab3];
    
    
    NSString *str2 = @"标记你对应的文本框tag，在将要编辑文本框的方法中判断tag值。- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;根据对应的tag设置不同的键盘类型~如果你认可我的回答，请及时点击【采纳为满意回答】按钮~手机提问的朋友在客户端右上角评价点【满意】即可。你的采纳是我前进的动力";
    
    CGFloat height2 =  [NSString getHeightOfLabelText:str2 lableWidth:kScreenWidth-20 textFontSize:14];
    
    UILabel *lab22 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab3.frame), kScreenWidth-20, height2)];
    lab22.text = str2;
    lab22.textColor =[UIColor grayColor];
    lab22.font = [UIFont systemFontOfSize:14];
    lab22.numberOfLines = 0;
    lab22.lineBreakMode = NSLineBreakByWordWrapping;
    [self.feature addSubview:lab22];

    //--------------------
    UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab22.frame)+30, 10, 10)];
    imageV3.image = [UIImage imageNamed:@"xx-1"];
    [self.feature addSubview:imageV3];
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab22.frame)+30, 100, 20)];
    lab4.text = @"我们承诺";
    //lab4.textColor =[UIColor redColor];
    lab4.font = [UIFont boldSystemFontOfSize:14];
    [self.feature addSubview:lab4];
    
    
    NSString *str4 = @"ddddddddddd";
    
    CGFloat height4 =  [NSString getHeightOfLabelText:str4 lableWidth:kScreenWidth-20 textFontSize:14];
    
    UILabel *lab25 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab4.frame), kScreenWidth-20, height4)];
    lab25.text = str4;
    lab25.textColor =[UIColor grayColor];
    lab25.font = [UIFont systemFontOfSize:14];
    lab25.numberOfLines = 0;
    lab25.lineBreakMode = NSLineBreakByWordWrapping;
    [self.feature addSubview:lab25];

    
}
-(void)loadCharge{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    lab.text = @"费用包含";
    //lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    [self.charge addSubview:lab];
      NSString *str = @"1.交通：的顶顶顶顶顶,\r\n2.在将要编辑文本框的方法中判断tag值.\r\n3.在将要编辑文本框的方法中判断tag值.\r\n4.在将要编辑文本框的方法中判断tag值.\r\n5.在将要编辑文本框的方法中判断tag值.\r\n6.在将要编辑文本框的方法中判断tag值.\r\n7.在将要编辑文本框的方法中判断tag值";
    CGFloat height = [NSString getHeightOfLabelText:str lableWidth:kScreenWidth-20 textFontSize:14];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-20, height)];
    lab2.text = str;
    lab2.textColor =[UIColor grayColor];
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.numberOfLines = 0;
    lab2.lineBreakMode = NSLineBreakByWordWrapping;
    [self.charge addSubview:lab2];
    
    
}
-(void)loadDetail{
    
   //-------
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20)];
    lab.text = @"第一天";
     // lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    [self.detail addSubview:lab];
    
    
NSString *str = @"交通：的顶顶顶顶顶,\r\n2.在将要编辑文本框的方法中判断tag值.\r\n3.在将要编辑文本框的方法中判断tag值.\r\n4.在将要编辑文本框的方法中判断tag值.\r\n5.在将要编辑文本框的方法中判断tag值.\r\n6.在将要编辑文本框的方法中判断tag值.\r\n7.在将要编辑文本框";
    CGFloat height =[NSString getHeightOfLabelText:str lableWidth:kScreenWidth-20 textFontSize:14];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab.frame), kScreenWidth-20, height)];
    lab2.text = str;
    lab2.numberOfLines = 0;
    lab2.lineBreakMode = NSLineBreakByWordWrapping;
    // lab.textColor =[UIColor <#lab#>];
    lab2.font = [UIFont systemFontOfSize:15];
    [self.detail addSubview:lab2];
    
    
   //------------------------
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab2.frame)+30, kScreenWidth-20, 20)];
    lab3.text = @"第二天";
    // lab.textColor =[UIColor <#lab#>];
    lab3.font = [UIFont systemFontOfSize:15];
    [self.detail addSubview:lab3];

    NSString *str2 = @"交通：的顶顶顶顶顶,\r\n2.在将要编辑文本框的方法中判断tag值.\r\n3.在将要编辑文本框的方法中判断tag值.\r\n4.在将要编辑文本框的方法中判断tag值.\r\n5.在将要编辑文本框的方法中判断tag值.\r\n6.在将要编辑文本框的方法中判断tag值.\r\n7.在将要编辑文本框";
    CGFloat height2 =[NSString getHeightOfLabelText:str lableWidth:kScreenWidth-20 textFontSize:14];

    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab3.frame), kScreenWidth-20, height2)];
    lab4.text = str2;
    lab4.numberOfLines = 0;
    lab4.lineBreakMode = NSLineBreakByWordWrapping;
    // lab.textColor =[UIColor <#lab#>];
    lab4.font = [UIFont systemFontOfSize:15];
    [self.detail addSubview:lab4];

    
    
    CGRect rc = [lab4.superview convertRect:lab4.frame toView:self.view];
    NSLog(@"---11111---%@",NSStringFromCGRect(rc));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
