//
//  MyhomeViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define YJMaxSeccion 100
#define narBar 64
#import "MyhomeViewController.h"
#import "UserCommentsViewController.h"
#import "GuideStatus.h"
#import "UIView+Frame.h"
#import "GuideCell.h"
#import "MyLabel.h"
#import "MySpace/MySpaceTable.h"
#import "DDPageControl.h"
#import "ScenicIntroduceViewController.h"
#import "TravelGuidesViewController.h"
#import "RecordViewController.h"
#import "CWStarRateView.h"
#import "TravelEditViewController.h"
#import "SpaceEditViewController.h"
#import "BWMCoverView.h"
#import "UMSocial.h"

#import "MydataViewController.h"
#import "WebViewViewController.h"
@interface MyhomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *whiteV;
@property (strong, nonatomic) NSMutableArray *news;
@property (weak, nonatomic) UIScrollView *bgScrollView;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) UICollectionView *collectionView;
@property(nonatomic,strong) CWStarRateView * starRateView ;
@property(nonatomic,strong) RecordViewController *recordVC;
@property(nonatomic,strong)UIButton *RecommandLine;
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *sharebjv ;
@property(nonatomic,strong) BWMCoverView *coverView;
@property(nonatomic,strong) UIButton *topBtn;


@property(nonatomic,strong) NSString  * name ;
@property(nonatomic,strong) NSString * gender ;
@property(nonatomic,strong) NSString * signature ;
@property(nonatomic,strong) NSString * level ;
@property(nonatomic,strong) NSString * certificate ;
@property(nonatomic,strong) NSString * language ;
@property(nonatomic,strong) NSString * region ;
@property(nonatomic,strong) NSString * cost ;
@property(nonatomic,strong) NSString * popularValue ;
@property(nonatomic,strong) NSString * workNumber ;
@property(nonatomic,strong) UIView  * myspace ;
@property(nonatomic,strong) UIView  * user ;
@property(nonatomic,strong) UIView  * introdution ;
@property(nonatomic,strong) UIView  * method ;
@property (weak, nonatomic) UIButton *seletedBtn;
@property (strong, nonatomic) DDPageControl *pageCon;
@property(nonatomic,strong) UIScrollView * bjScrol ;
@property(nonatomic,strong) UIView * barView ;
@property(nonatomic,strong) UIButton * recordBtn ;//景点讲解中录音
@property(nonatomic,strong) UIButton * spaceBtn ;//空间编辑
@property(nonatomic,strong) UIButton * travelBtn ;//旅游攻略
@property(nonatomic,strong) UIView *recordView;
@property(nonatomic,strong)UIImageView *IconImage;
@property(nonatomic,strong) UILabel *signa;
//@property(nonatomic,strong) UIView *bottomV;

@end

@implementation MyhomeViewController
static NSString * const GuideCollectionCell = @"GuideCollectionCell";
-(UIView *)sharebjv{
    if (!_sharebjv) {
        self.sharebjv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.sharebjv.backgroundColor = [UIColor blackColor];
        self.sharebjv.tag =2100;
        self.sharebjv.alpha  = 0.6;
    }
    return _sharebjv;
}


-(UIView *)whiteV{
    if (!_whiteV) {
        _whiteV = [[UIView alloc]init];
        _whiteV.backgroundColor = [UIColor whiteColor];
    }
    return _whiteV;
}
- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.bjScrol addSubview:bgScrollView];
        self.bgScrollView = bgScrollView;
    }
    return _bgScrollView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // self.navigationController.navigationBarHidden = YES;
//    switch (self.selectedTag) {
//        case 2:
//        {
//            UIButton *btn =  (UIButton *)[self.view viewWithTag:1001];
//            btn.selected = YES;
//            [self doAction:btn];
//            
//            
//        }
//            break;
//        case 4:
//        {
//            UIButton *btn =  (UIButton *)[self.view viewWithTag:1003];
//            btn.selected = YES;
//            [self doAction:btn];
//        }
//            break;
//            
//        default:
//            break;
//    }
    
}
-(void)gohome{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadView{
    [super loadView];
    
    _news =[NSMutableArray array];
    //http://192.168.1.77/S_AJAX/Guid.ashx?cmd=GuidModel&param={%22ID%22:%2217%22}
    
    _Parameters=[NSMutableDictionary dictionary];
    NSString* users= [UserDefaults objectForKey:@"guid"];
    [_Parameters setValue:users forKey:@"Guid"];
    _GuiderURL=[YjlyRequest UrlParamer:@"Guid" CmdName:@"GuidModel" Parameter:_Parameters];
    
    self.navigationItem.title = @"导游详情";
    //self.navigationController.navigationBarHidden  = YES;
    UIScrollView *bjScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height)];
    bjScrol.bounces = NO;
    bjScrol.delegate = self;
    bjScrol.bounces = NO;
    bjScrol.showsVerticalScrollIndicator = NO;
    bjScrol.contentSize = CGSizeMake(kScreenWidth, 300+kScreenHeight);
    [self.view addSubview:bjScrol];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = YES;
    [bjScrol addGestureRecognizer:tapGr];
//    // 滑動到position的位置
//    CGPoint position = CGPointMake(0, 300);
//    [bjScrol setContentOffset:position animated:YES];
    self.bjScrol = bjScrol;
    // 图片轮播
    
    UIView *topbjV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    [self.view addSubview:topbjV];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:@"ditu"];
    //[topbjV addSubview:imageV];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    lab.text = @"导游详情";
    lab.textColor =[UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:16];
    [imageV addSubview:lab];
    self.barView = topbjV;
    
    
    [self GetGuider:_GuiderURL];
    
    
    
    if (self.selectedTag == 2) {
        UIButton *btn =  (UIButton *)[self.view viewWithTag:1001];
        btn.selected = YES;
        [self doAction:btn];
    }
    
    UIButton *btn =  (UIButton *)[self.view viewWithTag:1000];
    btn.selected = YES;
    [self doAction:btn];
    
    
}
-(UIButton *)recordBtn{
    if (!_recordBtn) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-30, kScreenHeight-50-narBar, 60, 60);
        [button setImage:[UIImage imageNamed:@"yybf"] forState:UIControlStateNormal];
        
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(beginRecord) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.recordBtn = button;
        
    }
    return _recordBtn;
}

-(UIButton *)spaceBtn{
    if (!_spaceBtn) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-30, kScreenHeight-50-narBar, 60, 60);
        [button setImage:[UIImage imageNamed:@"ai_11"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(intoMySpaceEdit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // button.hidden = YES;
        self.spaceBtn = button;
        
    }
    return _spaceBtn;
}

-(UIButton *)travelBtn{
    if (!_travelBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-30, kScreenHeight-50-narBar, 60, 60);
        [button setImage:[UIImage imageNamed:@"tianji_03"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(travelStrategyEdit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.travelBtn = button;
    }
    return _travelBtn;
}

#pragma mark 线路推荐
-(UIButton *)RecommandLine{
    if (!_RecommandLine) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-30, kScreenHeight-50-narBar, 60, 60);
        [button setImage:[UIImage imageNamed:@"tianji_03"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(addRecommandLine) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
        self.RecommandLine = button;
    }
    return _RecommandLine;
}
#pragma mark 进入线路推荐界面

-(void)addRecommandLine{
    NSLog(@"进入线路推荐界面");
    WebViewViewController *WebViewController=[[WebViewViewController alloc] init];
    
    NSString *encodedString=[[NSString stringWithFormat:@"%@/weixin/quality/Getquality.aspx?GID=%@",DomainURL,[UserDefaults objectForKey:@"guid"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WebViewController.tempUrl= encodedString;
    
    [self.navigationController pushViewController:WebViewController animated:YES];
    
}

-(void)intoMySpaceEdit{
    SpaceEditViewController *space = [[SpaceEditViewController alloc]init];
    space.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:space animated:YES];
}
#pragma mark 进入旅游攻略界面
-(void)travelStrategyEdit{
    NSLog(@"进入旅游攻略界面");

    
    TravelEditViewController *travel = [[TravelEditViewController alloc]init];
    travel.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:travel animated:YES];
    // [self presentViewController:travel animated:YES completion:nil];
}
-(void)backlast{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)beginRecord{
    
    [self.view addSubview:self.recordView];
    
}

/**
 *  导游资料详细信息
 *
 *  @param IconURL            导游头像
 *  @param Guider             导游名称
 *  @param GuiderExperience   导游工作经验
 *  @param GuiderLanguage     导游精通语种
 *  @param GuiderArea         导游工作地
 *  @param GuiderStar         导游星级评定
 *  @param GuideIDCard        导游证书
 *  @param GuiderServiceFrees 导服费
 *  @param LikeCount          点赞数量
 *  @param GuiderSignature    导游个性签名
 */
-(void)showGuiderDetailInfo:(GuiderModel*)Model
{
    
    
    UIView *myView= [[UIImageView alloc]initWithFrame:CGRectMake(0, self.coverView.bounds.size.height-60 , kScreenWidth , 60)];
    myView.backgroundColor = [UIColor blackColor];
    myView.alpha = 0.5;
    [self.coverView addSubview:myView];
    UIView * detail = [[UIView alloc]initWithFrame:CGRectMake(0, self.coverView.bounds.size.height-60 , kScreenWidth, 80)];
    detail.backgroundColor = [UIColor clearColor];
    [self.coverView addSubview:detail];
    detail.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gerenziliao)];
    [detail addGestureRecognizer:tap];
    
    NSURL *portraitURL=[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",DomainURL,Model.GuiderIconURL]];
    
    _IconImage= [[UIImageView alloc]initWithFrame:CGRectMake(10, -20, 70 , 70)];
    //图片设置圆角
    [_IconImage sd_setImageWithURL:portraitURL placeholderImage:[UIImage imageNamed:@"defaultuser"]];
    CALayer * l = [_IconImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:35.0];
    [detail addSubview:_IconImage];
    
    CGSize sizex = [NSString get:Model.TrueName andFont:15];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(85, 3, sizex.width, 20)];
    label.text = Model.TrueName;
    
    label.textColor =[UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [detail addSubview:label];
    
    //男女图标
    UIImageView *imageVx = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+2, 5, 10, 15)];
    imageVx.image = [UIImage imageNamed:@"nanhai"];
    [detail addSubview:imageVx];

    
    UILabel *labe2 = [[UILabel alloc]initWithFrame:CGRectMake(85, 30, 80, 10)];
    labe2.text = [NSString stringWithFormat:@"%@",[Model.GuiderExperience stringByReplacingOccurrencesOfString:@"前" withString:@""] ];
    labe2.textColor =[UIColor whiteColor];
    labe2.font = [UIFont boldSystemFontOfSize:12];
    [detail addSubview:labe2];
    
    
    UILabel *labe22 = [[UILabel alloc]initWithFrame:CGRectMake(85, 45, 80, 10)];
    labe22.text = @"工作年限";
    labe22.textColor =[UIColor whiteColor];
    labe22.font = [UIFont systemFontOfSize:12];
    [detail addSubview:labe22];
    
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 , 30, 1, 25)];
    line.backgroundColor = [UIColor whiteColor];
    [detail addSubview:line];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2+70 , 30, 1, 25)];
    line2.backgroundColor = [UIColor whiteColor];
    [detail addSubview:line2];
    
    UILabel *laba = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 30, 70, 10)];
    
    if ((NSNull *)Model.GuiderLanguage == [NSNull null]) {
        
        Model.GuiderLanguage=@"英语";
    }
    
    [laba setText:[Model.GuiderLanguage isEqualToString:@""]?@"暂无":Model.GuiderLanguage];
    
    [laba setTextAlignment:NSTextAlignmentCenter];
    [laba setTextColor:[UIColor whiteColor]];
    [laba setFont:[UIFont boldSystemFontOfSize:12]];
    //自适应宽度
    [laba setNumberOfLines:0];
    [laba setLineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [laba sizeThatFits:CGSizeMake(laba.frame.size.width, MAXFLOAT)];
    [laba setSize:CGSizeMake(laba.frame.size.width, size.height)];
    [detail addSubview:laba];
    
    UILabel *laba1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 45, 70, 10)];
    laba1.text = @"语种";
    laba1.textAlignment = NSTextAlignmentCenter;
    laba1.textColor =[UIColor whiteColor];
    laba1.font = [UIFont systemFontOfSize:12];
    [detail addSubview:laba1];
    
    UILabel *labb = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-85, 30, 85, 10)];
    labb.text = [Model.GuiderArea isEqualToString:@""] ?@"暂无":Model.GuiderArea;
    labb.textColor =[UIColor whiteColor];
    labb.textAlignment = NSTextAlignmentCenter;

    labb.font = [UIFont boldSystemFontOfSize:12];
    
    [detail addSubview:labb];
    
    UILabel *labc = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-85, 45, 85, 10)];
    labc.text = @"地区";
    labc.textAlignment = NSTextAlignmentCenter;
    labc.textColor =[UIColor whiteColor];
    labc.font = [UIFont systemFontOfSize:12];
    [detail addSubview:labc];
    
    //星星
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth-65, 10, 60, 10) numberOfStars:5 imageName:@"star"];
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.scorePercent=Model.GuiderStar/5.0;
    [detail addSubview:self.starRateView];
    
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_starRateView.frame.origin.x-30, 10, 40, 10)];
    lab.text = [NSString stringWithFormat:@"%.1f星",Model.GuiderStar];
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:12];
    
    [detail addSubview:lab];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.coverView.frame), kScreenWidth, 30)];
    bjV.backgroundColor = WJColor(198, 197, 197);
    [self.bjScrol addSubview:bjV];
    UILabel *labd = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-100, 30)];
    labd.text = [NSString stringWithFormat:@"导游证书%@",[Model.GuiderIDCard isEqualToString:@""]?@"暂无":Model.GuiderIDCard];
    labd.textColor =[UIColor whiteColor];
    labd.font = FontB(13);
    [bjV addSubview:labd];
    
    
    NSString * str_labd1=[NSString stringWithFormat:@"导服费 %.1f元/天",Model.GuiderServiceFrees];
    UILabel *labd1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 0, 110, 30)];
    labd1.text = str_labd1;
    labd1.textColor =[UIColor whiteColor];
    labd1.font = FontB(13);
    [bjV addSubview:labd1];
    
    UIView *bjVa = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bjV.frame), kScreenWidth, 30)];
    bjVa.backgroundColor = WJColor(249, 248, 248);
    [self.bjScrol addSubview:bjVa];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 15, 15)];
    imageV.image = [UIImage imageNamed:@"kongjian_zan"];
    [bjVa addSubview:imageV];
    
    UILabel *labx = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 30)];
    
    labx.text =[NSString stringWithFormat:@"%d",Model.LikeCount];;
    labx.textColor =WJColor(191, 190, 190);
    labx.font =  [UIFont boldSystemFontOfSize:15];
    [bjVa addSubview:labx];
    
    self.signa = [[UILabel alloc]init];
    self.signa.text = self.signature;
    self.signa.numberOfLines = 0;
    self.signa.lineBreakMode = NSLineBreakByWordWrapping;
    self.signa.text = [NSString stringWithFormat:@"个性签名：%@",[Model.GuiderSignature isEqualToString:@""]?@"暂无":Model.GuiderSignature];
    CGFloat height=[NSString getHeightOfLabelText:self.signa.text lableWidth:kScreenWidth-20 textFontSize:12];
    
    self.signa.frame = CGRectMake(10, CGRectGetMaxY(bjVa.frame), kScreenWidth-20, MAX(height, 30));
    self.signa.textColor =[UIColor grayColor];
    [self.signa setFont:[UIFont systemFontOfSize:12]];
    [self.bjScrol addSubview:self.signa];
    
    UIView *lineS = [[UIView alloc]initWithFrame:CGRectMake(-10, self.signa.bounds.size.height-1, kScreenWidth, 1)];
    lineS.backgroundColor = WJColor(198, 197, 197);
    [self.signa addSubview:lineS];
    [self addbuttton];
//    [self addFourMainButton];

    if ([self.seleteSpace isEqualToString:@"space"]) {
        UIButton *button=(UIButton *)  [self.view viewWithTag:1000];
        button.selected = YES;

        [self doAction:button];
        
    }
    
    
    switch (self.selectedTag) {
        case 2://景点讲解被选中
        {
            UIButton *btn =  (UIButton *)[self.view viewWithTag:1001];
            btn.selected = YES;
            [self doAction:btn];
            
        }
            break;
        case 4: //用户评论被选中
        {
            UIButton *btn =  (UIButton *)[self.view viewWithTag:1003];
            btn.selected = YES;
            [self doAction:btn];
            
        }
            break;
            
        default:
            break;
    }

//    [self backtotop];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-50, kScreenHeight-64-40, 40, 40);
    [button setTitleColor:yjlyseleted forState:UIControlStateNormal];
    
//    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"TOP" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:13];
//    button.hidden = YES;
    [button addTarget:self action:@selector(backtotop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    self.topBtn = button;
    button.transform = CGAffineTransformMakeTranslation(0,50);
}
-(void)backtotop{
    [UIView animateWithDuration:0.5 animations:^{
        self.bjScrol.contentOffset = CGPointMake(0, 0);

    }];
}


-(void)addbuttton{
    
//    self.bottomV =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.signa.frame), kScreenWidth, 30)];
//    [self.bjScrol addSubview:self.bottomV];
//    UIView *lineV =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    lineV.backgroundColor = WJColor(229, 229, 229);
//    [self.bottomV addSubview:lineV];
    
    NSArray *arr = [NSArray arrayWithObjects:@"我的空间",@"景点讲解",@"旅游攻略",@"用户评论", nil];
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/4*i, CGRectGetMaxY(self.signa.frame), kScreenWidth/4, 30);
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor grayColor];
        button.backgroundColor = WJColor(241, 241, 241);
        button.tag = i + 1000;
        button.selected = NO;
        [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [button setTitleColor:WJColor(13, 143, 244) forState:UIControlStateSelected];
        button.layer.borderColor = [[UIColor grayColor] CGColor];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        
        button.layer.borderColor = [WJColor(229, 229, 229) CGColor];
        button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bjScrol addSubview:button];
    }
}
-(void)viewTapped{
    [self.recordView removeFromSuperview];
    self.recordView = nil;
    [self setRecordVC:nil];
}
-(UIView *)recordView{
    if (!_recordView) {
        
        self.recordVC = [[RecordViewController alloc]init];
        self.recordVC.view.frame = CGRectMake(0, kScreenHeight -64 -140, kScreenWidth,140);
        [self addChildViewController:self.recordVC];
        _recordView = self.recordVC.view;
        
        
//        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
//        tapGr.cancelsTouchesInView = YES;
//        [_recordView addGestureRecognizer:tapGr];
    }
    return _recordView;
}
-(UIView *)myspace{
    if (!_myspace) {
        
        MySpaceTable *myspce = [[MySpaceTable alloc] init];
        myspce.view.frame = CGRectMake(0, CGRectGetMaxY(self.signa.frame)+35, kScreenWidth, self.bjScrol.contentSize.height-360);
        self.myspace = myspce.view;
        [self addChildViewController:myspce];
        [self.bjScrol addSubview:myspce.view];

    }
    return _myspace;
}

-(UIView *)introdution{
    if (!_introdution) {
        ScenicIntroduceViewController *scenic  = [[ScenicIntroduceViewController alloc]init];
        scenic.view.frame = CGRectMake(0, CGRectGetMaxY(self.signa.frame)+30, kScreenWidth, self.bjScrol.contentSize.height-360);
        self.introdution = scenic.view;
        [self addChildViewController:scenic];
        [self.bjScrol addSubview:scenic.view];
//        [self.introdution removeFromSuperview];
  
       
    }
    return _introdution;
}
-(UIView *)method{
    if (!_method) {
        
        TravelGuidesViewController *Travel  = [[TravelGuidesViewController alloc]init];
        Travel.view.frame = CGRectMake(0, CGRectGetMaxY(self.signa.frame)+30, kScreenWidth, self.bjScrol.contentSize.height-360);
        self.method = Travel.view;
        [self addChildViewController:Travel];
        [self.bjScrol addSubview:Travel.view];
//        [self.method removeFromSuperview];
    }
    return _method;
}


-(UIView *)user{
    if (!_user) {
        
        UserCommentsViewController  *user = [[UserCommentsViewController alloc]init];
        user.view.frame = CGRectMake(0, CGRectGetMaxY(self.signa.frame)+30, kScreenWidth, self.bjScrol.contentSize.height-360);
        self.user = user.view;
        [self addChildViewController:user];
        [self.bjScrol addSubview:user.view];
//        [self.user removeFromSuperview];
    }
    return _user;
}
-(void)addFourMainButton{
    
    
    
    
    
    
    
   
 
    
   
}
#pragma mark 四个主界面的点击事件
-(void)doAction:(UIButton *)btn{
    self.seletedBtn.selected = NO;
    self.seletedBtn.backgroundColor = WJColor(241, 241, 241);
    self.seletedBtn.layer.borderWidth = 0.5;
    btn.selected = YES;
    btn.backgroundColor =[UIColor clearColor];
    btn.layer.borderWidth = 0;
    self.seletedBtn = btn;
    switch (btn.tag) {
        case 1000: //我的空间
        {
            [self.RecommandLine removeFromSuperview];
            [self.user removeFromSuperview];
            [self.method removeFromSuperview];
            [self.introdution removeFromSuperview];
            [self.recordView removeFromSuperview];
            [self.recordBtn removeFromSuperview];
            [self.travelBtn removeFromSuperview];
            self.recordView = nil;
            [self setRecordVC:nil];
            [self.view addSubview:self.spaceBtn];

            [self.bjScrol addSubview:self.myspace];
            //            self.recordBtn.hidden = YES;
            
            
            
        }
            break;
        case 1001:{//景点讲解
            [self.user removeFromSuperview];
            [self.method removeFromSuperview];
            [self.myspace removeFromSuperview];
            [self.bjScrol addSubview:self.introdution];
            //            self.recordBtn.hidden =NO;
            
            [self.RecommandLine removeFromSuperview];

            [self.view addSubview:self.recordBtn];
            [self.spaceBtn removeFromSuperview];
            [self.travelBtn removeFromSuperview];
        }
            
            break;
        case 1002:{//旅游攻略
            [self.recordView removeFromSuperview];
             self.recordView = nil;
            [self setRecordVC:nil];
            [self.myspace removeFromSuperview];
            [self.user removeFromSuperview];

            [self.introdution removeFromSuperview];
            [self.bjScrol addSubview:self.method];
            ///******************************
            [self.travelBtn removeFromSuperview];
            [self.view addSubview:self.RecommandLine];
            
            [self.recordBtn removeFromSuperview];
            [self.spaceBtn removeFromSuperview];
            
            
        }
            
            break;
        case 1003://用户评论
            
        {
            [self.recordView removeFromSuperview];
            self.recordView = nil;
            [self setRecordVC:nil];
            [self.RecommandLine removeFromSuperview];

            [self.method removeFromSuperview];
            [self.introdution removeFromSuperview];
            [self.myspace removeFromSuperview];
            [self.bjScrol addSubview:self.user];
            [self.travelBtn removeFromSuperview ];
            [self.recordBtn removeFromSuperview];
            [self.spaceBtn removeFromSuperview];
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark  wangfengjing begin  友盟分享
-(UIView *)shareView{
    if (!_shareView) {
        
        
        
        
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 200)];
        _shareView.backgroundColor = WJColor(241, 242, 246);
        [self.view addSubview:_shareView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.shareView.bounds.size.width, 20)];
        line.backgroundColor = [UIColor whiteColor];
        [_shareView addSubview:line];
        
        
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.shareView.bounds.size.width, 1)];
        line2.backgroundColor = WJColor(242, 242, 242);
        [_shareView addSubview:line2];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_shareView.bounds.size.width/2-40, 0, 80, 20)];
        lab.text = @"分享到";
        
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentCenter;
        [_shareView addSubview:lab];
        
        NSArray *imgeArr = [NSArray arrayWithObjects:@"xinlang",@"weixin",@"qq", nil];
        CGFloat with =  (self.view.width-60-80)*0.25;
        for (int i = 0; i < 3  ; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(50+i*(with+40),50+20, with, with);
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[imgeArr objectAtIndex:i]] forState:UIControlStateNormal];
            button.tag = 2000+i;
            [button addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:button];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 160,self.shareView.bounds.size.width-20 , 30);
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"kk"] forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:button];
        
        
    }
    return _shareView;
}
//取消分享
-(void)cancel{
    self.sharebjv= (UIView *)[self.view viewWithTag:2100];
    [self.sharebjv removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(0, -300);
    }];
}

-(void)share{
    [self.view addSubview:self.sharebjv];
    
    
    self.shareView.transform = CGAffineTransformMakeTranslation(0, -300);
    [UIView animateWithDuration:0.5 animations:^{
        [self.view bringSubviewToFront:self.shareView];
        self.shareView.transform = CGAffineTransformIdentity;
    }];
    
}
-(void)shareButton:(UIButton *)button{
    switch (button.tag) {
        case 2000:  //新浪
        {

            //设置分享内容，和回调对象
            NSString *shareText = @"燕京联盟。 http://www.yanjinglvyou.com";
            UIImage *shareImage = [UIImage imageNamed:@"512*512"];
            
            [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:nil];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"sina"];
            
            snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        }
            break;
        case 2001:  // 微信
        {
            
            //设置分享内容，和回调对象
            NSString *shareText = @"燕京联盟。 http://www.yanjinglvyou.com";
            UIImage *shareImage = [UIImage imageNamed:@"512*512"];
            
            [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"wxtimeline"];//wxsession 微信好友//wxfavorite微信收藏//wxtimeline朋友圈
            snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        }
            break;
            
        case 2002: //qq
        {
            
            //设置分享内容，和回调对象
            NSString *shareText = @"燕京联盟。 http://www.yanjinglvyou.com";
            UIImage *shareImage = [UIImage imageNamed:@"512*512"];
            
            [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:nil];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"qzone"]; //qzone //qq
            
            snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            
            
        }
            break;
            
            
        default:
            break;
    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark wangfengjing end
-(void)dealloc{
    [YJLYNOTIFICATION removeObserver:self name:@"RecommendLine" object:nil];
    [YJLYNOTIFICATION removeObserver:self name:@"TravelStrategy" object:nil];
//
    [YJLYNOTIFICATION removeObserver:self name:@"changeHeadImage" object:nil];

}
-(void)hideRecordView
{
    [self viewTapped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideRecordView) name:@"UpLoadSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateIconForNotifacation:) name:@"changeHeadImage" object:nil];

       self.view.backgroundColor = [UIColor whiteColor];
    // 分享按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 30);
//    [backButton setTitle:@"分享" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(share)  forControlEvents:UIControlEventTouchUpInside];
     [backButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    back.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = back;
    
    
    [YJLYNOTIFICATION addObserver:self selector:@selector(showRecommendLineBtn) name:@"RecommendLine" object:nil];
    [YJLYNOTIFICATION addObserver:self selector:@selector(showTravelStrategyLineBtn) name:@"TravelStrategy" object:nil];
       //[self pageCon];
    
}
-(void)showRecommendLineBtn{
    [self.travelBtn removeFromSuperview];
    [self.view addSubview:self.RecommandLine];
    
}
-(void)showTravelStrategyLineBtn{
    [self.RecommandLine removeFromSuperview];
    [self.view addSubview:self.travelBtn];
}
-(void)addCertificationCalendar{
    NSArray *arr  = [NSArray arrayWithObjects:@"kongjian_renzheng",@"kongjian_rili", nil];
    
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth-50, 20 +i*45, 30, 30);
        button.tag = 1100+i;
        [button setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(CCAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bjScrol addSubview:button];
        
    }
    
}
-(void)CCAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1100://已认定
            
            break;
        case 1101://我的日历
            
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma 网络请求

/**
 *  获取导游详情信息获取
 *
 *  @param Url 导游信息api
 */
-(void)GetGuider:(NSString*)HomeUrl{
    if ([self.seleteSpace isEqualToString:@"space"]) {
     [MBProgressHUD showMessage:@"我的空间加载中..."];
    }
    switch (self.selectedTag) {
        case 2://景点讲解被选中
        {
            [MBProgressHUD showMessage:@"景点讲解加载中..."];

        }
            break;
        case 4:{//
            [MBProgressHUD showMessage:@"用户评论加载中..."];

        }
            break;
            
        default:
            break;
    }

    

    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:HomeUrl params:nil httpMethod:@"post"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [MBProgressHUD hideHUD];
        
        JsonToModel *modes= [[JsonToModel alloc] initWithDictionary:[completedOperation responseJSON] error:NULL];
        
        //判断是否返回json数据
        if(modes !=nil && [modes.state isEqualToString:@"0"])
        {
            
            //获取value值转化为json串
            NSDictionary *jsonValue= [YjlyRequest dictionaryWithJsonString:modes.value];
            
            
            _guiderModel= [GuiderModel initWithGuider:[[jsonValue objectForKey:@"ID"] integerValue] GuiderIconURL:[jsonValue objectForKey:@"HeadImg"] TrueName:[jsonValue objectForKey:@"TrueName"] GuiderIDCard:[jsonValue objectForKey:@"Certificates"] Guider:[jsonValue objectForKey:@"Username"] GuiderLanguage:[jsonValue objectForKey:@"LangageDesc"] GuiderArea:[jsonValue objectForKey:@"Native"] GuiderGendel:[[jsonValue objectForKey:@"Gendel"] integerValue] GuiderIdentity:[jsonValue objectForKey:@"Number"] GuiderMoblePhone:[[jsonValue objectForKey:@"Phone" ] integerValue] GuiderBirthDate:[jsonValue objectForKey:@"Birthday"] GuiderAddress:[jsonValue objectForKey:@"Adress"] GuiderSignature:[jsonValue objectForKey:@"Personsign"] GuiderServiceFrees:[[jsonValue objectForKey:@"GuderMoney"] floatValue] GuiderQRCode:[jsonValue objectForKey:@"QRcode"] GuiderFeedBack:@"" GuiderStar:[[jsonValue objectForKey:@"Star"] floatValue] GuiderWorkDate:[jsonValue objectForKey:@"WorkDate"] GuiderExperience:0 LikeCount:5000 RotaryFigureImage:[jsonValue objectForKey:@"Star"] Level_ID:[[jsonValue objectForKey:@"Level_ID"] integerValue]];
            if(![[jsonValue objectForKey:@"Image"] isEqualToString:@""])
            {
//                [_news removeAllObjects];
//                _news= [[ arrayByAddingObjectsFromArray:_news] mutableCopy];
                [_news addObjectsFromArray:[YjlyRequest GetArray:[jsonValue objectForKey:@"Image"] SpliteSymbol:@","]];
                [self addlunbo];
            }
            
            
            if(_guiderModel)
            {
                [self showGuiderDetailInfo:_guiderModel];
            }
            
        }else
        {
            [MBProgressHUD hideHUD];

            [MBProgressHUD showError:modes.msg];
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
        
//        [MBProgressHUD showError:[error description]];
        
        
    }];
    
    [engine enqueueOperation:op];
    
}
-(void)addlunbo{
    
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[_news count]; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"%@%@",DomainURL, [_news objectAtIndex:i]];
//        NSString *imageTitle = [NSString stringWithFormat:@"%@%d",DomainURL ,i+1];
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:nil];
        [realArray addObject:model];
    }
    
   self.coverView = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth*17/32) andPlaceholderImageNamed:@"bjt_jiazai" andClickdCallBlock:^(NSInteger index) {
        
    }];
   // coverView.pageControl.backgroundColor = [UIColor  whiteColor];
    [self.bjScrol addSubview:self.coverView];
    
    [self addCertificationCalendar];
    
    
    
    
    
    
    // 滚动视图每一次滚动都会回调此方法
    [self.coverView setScrollViewCallBlock:^(NSInteger index) {
//        NSLog(@"当前滚动到第%d个页面", index);
    }];
    
    // 请打开下面的东西逐个调试
    [self.coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
    //UIViewContentModeScaleToFill  UIViewContentModeScaleAspectFit
    self.coverView.imageViewsContentMode = UIViewContentModeScaleAspectFit; // 图片显示内容模式模式
    // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
    // [coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
    // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
    self.coverView.titleLabel.hidden = YES; //隐藏TitleLabel
    
    //  主要有以下UI成员：
    //    coverView2.scrollView
    //    coverView2.pageControl
    //    coverView2.titleLabel
    // 详情请查看接口文件
    
    [self.coverView updateView]; //修改属性后必须调用updateView方法，更新视图
    
    //
    
}
#pragma mark 认证
-(void)gerenziliao{
    MydataViewController *data = [[MydataViewController alloc]init];
    [self.navigationController pushViewController:data animated:YES];
}
#pragma mark  UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"---------scrollView.contentOffset.y ==%f-------",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y>=self.signa.origin.y) {
//        self.topBtn.hidden = NO;
              [scrollView setScrollEnabled:NO];
        self.topBtn.transform = CGAffineTransformIdentity;

        //    // 滑動到position的位置
            CGPoint position = CGPointMake(0, self.signa.origin.y+30);
            [scrollView setContentOffset:position animated:NO];

    }else{
//        self.topBtn.hidden = YES;
        self.topBtn.transform = CGAffineTransformMakeTranslation(0, 50);

                [scrollView setScrollEnabled:YES];

    }
}
-(void)UpdateIconForNotifacation:(NSNotification*) notification
{
    NSString *StrUpdateIcon= [notification object];
    [_IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,StrUpdateIcon]] placeholderImage:[UIImage imageNamed:@"defaultuser"]];
}@end
