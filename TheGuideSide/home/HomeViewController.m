//
//  HomeViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define Start_X 30.0f           // 第一个按钮的X坐标
#define Start_Y 160.0f           // 第一个按钮的Y坐标
#define Button_Height 70.0f    // 高
#define Button_Width 70.0f      // 宽

#define Width_Space (kScreenWidth -Button_Width*2)*0.5        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距



#import "HomeViewController.h"
#import "ProductButton.h"
#import "LikeViewController.h"
#import "OrderViewController.h"
#import "PraiseViewController.h"
#import "AppointmentViewController.h"
#import "MyhomeViewController.h"
#import "MydataViewController.h"
#import "DownloadViewController.h"
#import "MessageViewController.h"
#import "CWStarRateView.h"

@interface HomeViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIView * bgView ;
@property(nonatomic,strong) UIView * lineV ;
@property(nonatomic,strong) UIImageView * xxImage;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property(nonatomic,strong) UIScrollView *bjScro;
@property(nonatomic,strong) UIButton *xiaoxishuBtn;
@property(nonatomic,strong)UIImageView *IconImage;
@property(nonatomic,strong) NSString * Verification;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)xiaoxishu:(UIButton *)button{
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
-(void)dealloc{
    [YJLYNOTIFICATION removeObserver:self name:@"UpLoadSuccess" object:nil];
   
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIconForNotifacation:) name:@"changeHeadImage" object:nil];

   
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        
        self.edgesForExtendedLayout=UIRectEdgeNone;
        
    }
    
    [MBProgressHUD showMessage:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (kScreenHeight >480) {
        bjScro.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);

    }else{
        bjScro.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+70);

    }
    bjScro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bjScro];
    self.bjScro = bjScro;

    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth ,150 )];
    imageV.image = [UIImage imageNamed:@"bg2"];
    [self.bjScro addSubview:imageV];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    lab.text = @"我的主页";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:16];
    [imageV addSubview:lab];
    
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight)];
    bg.backgroundColor = [UIColor whiteColor];
    self.bgView = bg;
    [self.bjScro addSubview:self.bgView];

    
    //我的预约  右上角消息条数
    UIButton *yuyuebtn=(UIButton *)[self.view viewWithTag:1004];
    self.xiaoxishuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xiaoxishuBtn.frame = CGRectMake(yuyuebtn.bounds.size.width-18, 2, 17, 17);
    //[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.xiaoxishuBtn setTitle:@"1" forState:UIControlStateNormal];
    self.xiaoxishuBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.xiaoxishuBtn.layer.masksToBounds = YES;
    self.xiaoxishuBtn.layer.cornerRadius = 8;
    self.xiaoxishuBtn.backgroundColor = [UIColor redColor];
    [self.xiaoxishuBtn addTarget:self action:@selector(xiaoxishu:) forControlEvents:UIControlEventTouchUpInside];
    [yuyuebtn addSubview:self.xiaoxishuBtn];
    
    _URLPartParamter =[NSMutableDictionary dictionary];
    _URLPartParamter[@"Guid"]=[UserDefaults objectForKey:@"guid"];
    
    [self GetUserInfo];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;

}

/**
 *   景点讲解和排名
 *
 *  @param MyRanking 排名数字
 */
-(void)addcenterBtn:(NSString *)MyRanking{
  
    
    MyRanking=[MyRanking  isEqualToString:@"0"] ? @"":MyRanking;
    NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"排名%@",MyRanking], @"景点讲解",nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"paiming", @"jingdanjiangjiang",nil];

    for (int i = 0; i < 2; i ++) {
        ProductButton *button = [ProductButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-25, 60+(220 *i) , 50, 50);
        [button setImage:[UIImage imageNamed:[arr2 objectAtIndex:i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = 1100+i;
        if(i==1)
        {
        [button addTarget:self action:@selector(rankon:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.bgView addSubview:button];
    }
}


-(void)rankon:(UIButton *)btn{
    
    MyhomeViewController *myhome = [[MyhomeViewController alloc]init];
    
    myhome.selectedTag = 2;//景点讲解被选择
    
    [self.navigationController pushViewController:myhome animated:YES];
    
}
-(void)introduct{
    
}
-(void)addlineView{

    
    int index=1000;
    for (int row=0; row<2; row++)
    {
        for (int col=0; col<2; col++)
        {
            UIView *lineV = [[UIView alloc]init];
            lineV.backgroundColor  = WJColor(241, 241, 241);

            lineV.frame=CGRectMake(20+170*col, 90+row*225, 110, 1);
            [self.bgView addSubview:lineV];
            index++;
        }
    }
    

    
    
    for (int i = 0 ; i < 4; i++) {
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor  = WJColor(241, 241, 241);
        if (i>1) {
            lineV.frame = CGRectMake( kScreenWidth/2, 40 +(100*i)  , 1 , 40 );

        }else{
            lineV.frame = CGRectMake( kScreenWidth/2, 20 +(100*i)  , 1 , 40 );

        }
        [self.bgView addSubview:lineV];
        // }
    }
  
    
    
}

/**
 *  提现操作
 */
-(void)TakeCash:(double)Money{
    
    NSString *showMoney=@"我的余额                             ￥：";
    showMoney=[showMoney stringByAppendingFormat:@"%.2f", Money ];
    UIView *remainV =[[UIView alloc]initWithFrame:CGRectMake(10, 330, kScreenWidth-20 , 50)];
    remainV.backgroundColor  = WJColor(241, 241, 241);
    [self.bjScro addSubview:remainV];
    
    if(Money != 0.0)
    {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 15, 15)];
            imageV.image = [UIImage imageNamed:@"shijian"];
            [remainV addSubview:imageV];
        
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 100, 10)];
            //每月15号提现
            lab1.text = @"三日后可提现";
            lab1.font = [UIFont boldSystemFontOfSize:11];
            [remainV addSubview:lab1];
        
            UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(270, 5, 15, 15)];
            imageV2.image = [UIImage imageNamed:@"fuhao"];
            [remainV addSubview:imageV2];
        
        
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 300, 10)];
            lab2.text =showMoney;
            lab2.font = [UIFont boldSystemFontOfSize:15];
            [remainV addSubview:lab2];
        
        
    }else
    {
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 10)];
        lab2.text = showMoney;
        lab2.font = [UIFont boldSystemFontOfSize:15];
        [remainV addSubview:lab2];
    }
    

}

/**
 *  展示导游的相关信息
 *
 *  @param UserName    导游名称
 *  @param StarLevel   导游的星级
 *  @param Commissions 导游佣金分成
 *  @param AgentLevel  代理类型
 *  @param UserIcon    导游头像地址
 */
-(void)HomeUserInfomation:(NSString*)UserName StarLevel:(double)StarLevel Commissions:(double)Commissions AgentLevel:(NSString*)AgentLevel UserIcon:(NSString*)UserIcon
{
    
    NSURL *IconUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,UserIcon]];
   _IconImage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 60, 80, 80)];
    _IconImage.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:_IconImage action:@selector(pictureBecomeBig)];
    [_IconImage addGestureRecognizer:tap];
    [_IconImage sd_setImageWithURL:IconUrl placeholderImage:[UIImage imageNamed:@"defaultuser"] options:SDWebImageContinueInBackground];
    CALayer * l = [_IconImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:40.0];
    [self.bjScro addSubview:_IconImage];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(110, 80, 70, 30)];
    [nameL setText:UserName];
    [nameL setTextColor:[UIColor whiteColor]];
    nameL.font = [UIFont boldSystemFontOfSize:15];
    [self.bjScro addSubview:nameL];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(nameL.frame.origin.x+100, nameL.frame.origin.y+8, 80, 10)];
    lab1.font = [UIFont fontWithName:@"AmericanTypewriter" size:24];
    lab1.text = @"服务星级";
    lab1.textColor = [UIColor whiteColor];
    
    lab1.font = [UIFont boldSystemFontOfSize:11];
    [self.bjScro addSubview:lab1];
    
    
    //星星
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(lab1.frame.origin.x+50, nameL.frame.origin.y+8, 50, 10) numberOfStars:5 imageName:@"xingxing"];
    self.starRateView.scorePercent = StarLevel/10;
    self.starRateView.allowIncompleteStar = YES;
    [self.bjScro addSubview:self.starRateView];
    
    NSString *str_Agents=AgentLevel;
    str_Agents=[str_Agents stringByAppendingFormat:@"   %.0f%%佣金",Commissions*100];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(nameL.frame.origin.x+100, nameL.frame.origin.y+20, 100, 30)];
    lab2.textColor = [UIColor whiteColor];
    lab2.text = str_Agents;
    lab2.font = [UIFont systemFontOfSize:11];
    [self.bjScro addSubview:lab2];
}



/**
 *  显示用户订单 收藏 好评
 *
 *  @param Favorites   收藏
 *  @param GoodComment 好评
 *  @param OrderCount  订单数量
 */
-(void)HomeOrderPart:(NSString*)Favorites GoodComment:(NSString*)GoodComment OrderNumber:(NSInteger)OrderCount{
    
    
    Favorites =[Favorites isEqualToString:@"0"]?@"":Favorites ;
    GoodComment=[GoodComment isEqualToString:@"0"]?@"":GoodComment;
    NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"收藏我%@",Favorites],[NSString stringWithFormat:@"好评%@",GoodComment],@"订单数",@"推广",@"我的预约",@"我的资料",@"我的主页",@"消息通知", nil];
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"xin",@"haoping",@"dingdanshu",@"tuiguang",@"wodeyvyue",@"wodeziliao",@"wodezhuy",@"wodetongzhi", nil];
    
    
    CGFloat buttonX = (kScreenWidth -Button_Width*2- Width_Space)/2;//起点坐标
    for (int i = 0 ; i < 8; i++) {
        NSInteger index = i % 2;
        NSInteger page = i / 2;
        
        // 圆角按钮
        ProductButton *aBt = [ProductButton buttonWithType:UIButtonTypeCustom];
        if (i >= 4) {
            aBt.frame = CGRectMake(index * (Button_Width + Width_Space) + buttonX, page  * (Button_Height + Height_Space)+Start_Y + 40, Button_Width, Button_Height);
            
//             aBt.frame =CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
        }else{
            aBt.frame = CGRectMake(index * (Button_Width + Width_Space) + buttonX, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
 
        }
        
        
        [aBt addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
         aBt.tag = 1000+i;
        [aBt setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
       [aBt setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        [self.bjScro addSubview:aBt];
    }
}


-(void)doAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1000:
        {
            LikeViewController *like = [[LikeViewController alloc  ]init];
            [self.navigationController pushViewController:like animated:YES];
        }
            break;
        case 1001:
        {
            MyhomeViewController *myhome = [[MyhomeViewController alloc]init];
            myhome.selectedTag = 4;//景点讲解被选择
            [self.navigationController pushViewController:myhome animated:YES];
        }
            
            break;
        case 1002:
        {
            OrderViewController *like = [[OrderViewController alloc  ]init];
            like.navigationItem.title = @"订单数";
            
            [self.navigationController pushViewController:like animated:YES];
            
        }
            
            
            break;
        case 1003:
        {
            DownloadViewController *like = [[DownloadViewController alloc  ]init];
            like.navigationItem.title = @"推广";
            
            [self.navigationController pushViewController:like animated:YES];
        }
            
            break;
        case 1004:
        {
            AppointmentViewController *like = [[AppointmentViewController alloc  ]init];
            like.navigationItem.title = @"我的预约";
            
            [self.navigationController pushViewController:like animated:YES];
            
        }
            
            break;
        case 1005:
        {
            MydataViewController *like = [[MydataViewController alloc  ]init];
            like.navigationItem.title = @"我的资料";
            
            [self.navigationController pushViewController:like animated:YES];
        }
            
            break;
        case 1006:
        {
            MyhomeViewController *like = [[MyhomeViewController alloc  ]init];
            like.seleteSpace=@"space";
            [self.navigationController pushViewController:like animated:YES];
            
        }
            
            break;
        case 1007:
        {
            MessageViewController *like = [[MessageViewController alloc  ]init];
            like.navigationItem.title = @"消息通知";
            
            [self.navigationController pushViewController:like animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

/*
-(void)doAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1000:
        {
           
            if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
                
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
                LikeViewController *like = [[LikeViewController alloc  ]init];
                [self.navigationController pushViewController:like animated:YES];
            }
           
        }
            break;
        case 1001:
        {
            if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
                
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
            
             MyhomeViewController *myhome = [[MyhomeViewController alloc]init];
            myhome.selectedTag = 4;//景点讲解被选择
                [self.navigationController pushViewController:myhome animated:YES];
            }
        }

            break;
        case 1002:
               {
                   if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
                       
                       UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                       [alert show];
                   }else{
                   OrderViewController *like = [[OrderViewController alloc  ]init];
                   like.navigationItem.title = @"订单数";
                   
                   [self.navigationController pushViewController:like animated:YES];
                   }
               }


            break;
        case 1003:
        {
            if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
                
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
            DownloadViewController *like = [[DownloadViewController alloc  ]init];
            like.navigationItem.title = @"推广";
            
                [self.navigationController pushViewController:like animated:YES];}
        }

            break;
        case 1004:
        {if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
            
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            AppointmentViewController *like = [[AppointmentViewController alloc  ]init];
            like.navigationItem.title = @"我的预约";
            
            [self.navigationController pushViewController:like animated:YES];
        }
        }

            break;
        case 1005:
        {
            if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
            
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            MydataViewController *like = [[MydataViewController alloc  ]init];
            like.navigationItem.title = @"我的资料";
            
            [self.navigationController pushViewController:like animated:YES];}
        }

            break;
        case 1006:
        {if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
            
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            MyhomeViewController *like = [[MyhomeViewController alloc  ]init];
            like.seleteSpace=@"space";
            [self.navigationController pushViewController:like animated:YES];}
            
        }

            break;
        case 1007:
        {if ([[NSString stringWithFormat:@"%@",self.Verification] isEqualToString:@"0"]) {
            
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"完善个人信息后方可使用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            MessageViewController *like = [[MessageViewController alloc  ]init];
            like.navigationItem.title = @"消息通知";
            
            [self.navigationController pushViewController:like animated:YES];}
           
        }
            break;
 
        default:
            break;
    }
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  获取导游信息
 *
 *  @param Url 导游信息api
 */
-(void)GetUserInfo{

    NSString *LocationURL=[YjlyRequest UrlParamer:@"Login" CmdName:@"Home" Parameter:_URLPartParamter];
 MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:LocationURL params:nil httpMethod:@"post"];
   // [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [MBProgressHUD hideHUD];
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
           NSDictionary *jsonValue= [YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];

            NSLog(@"22--%@",jsonData);
            
        self.Verification = [jsonValue objectForKey:@"Verification"];
            
            [self HomeOrderPart:[[jsonValue objectForKey:@"LoveCount"] stringValue]  GoodComment:[[jsonValue objectForKey:@"PraiseCount"]stringValue ]  OrderNumber:[[jsonValue objectForKey:@"OrdersCount"] integerValue]];
            
            [self HomeUserInfomation:[jsonValue objectForKey:@"UserName"] StarLevel:[[jsonValue objectForKey:@"Xj"] doubleValue] Commissions:[[jsonValue objectForKey:@"TiCheng"] doubleValue] AgentLevel:@"金牌代理" UserIcon:[jsonValue objectForKey:@"HeadImg"]];
            [self TakeCash: [[jsonValue objectForKey:@"Money"] doubleValue]];
            [self addlineView];
            [self addcenterBtn:[jsonValue objectForKey:@"PaiMing"]];
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];

    }];
    
    [engine enqueueOperation:op];
    
}
-(void)UpdateIconForNotifacation:(NSNotification*) notification
{
    NSString *StrUpdateIcon= [notification object];
    [_IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,StrUpdateIcon]] placeholderImage:[UIImage imageNamed:@"defaultuser"]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            MydataViewController *data = [[MydataViewController alloc]init];
            [self.navigationController pushViewController:data animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
