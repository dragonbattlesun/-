//
//  LanguageViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/26.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define kWinSize [UIScreen mainScreen].bounds.size

#import "LanguageViewController.h"
#import "NSString+AutoHeight.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>
#import "Language.h"
#import "LanguageTableViewCell.h"
#import "YcKeyBoardView.h"
#import "AFSoundManager.h"
#import "BWMCoverView.h"

#define  GuiderDetailLineSpace 15
@interface LanguageViewController ()<UITableViewDataSource,UITableViewDelegate,LanguageTableViewCellDelegate,YcKeyBoardViewDelegate>
@property(nonatomic ,strong)UIScrollView * bjscrl;
@property(nonatomic,strong)UILabel *contentLable;
@property(nonatomic,strong)UIButton *morebutton;
@property(nonatomic,strong) UIView *chatbjV;
@property(nonatomic,weak) UILabel *introlab;
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UITextField *downloadSourceField;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property(nonatomic,strong) UITextField *elapsedTime;
@property(nonatomic,strong) UITextField *timeRemaining;
@property(nonatomic,strong) UISlider *slider;



@end

@implementation LanguageViewController
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"导游语详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *bjscrl = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    
    
    bjscrl.showsVerticalScrollIndicator = NO;
    bjscrl.contentSize = CGSizeMake(kScreenWidth, 900);
    self.bjscrl = bjscrl;
    [self.view addSubview:bjscrl];
    
    NSArray *PicList= [YjlyRequest GetArray:_DetialModel.PicSrc SpliteSymbol:@","];
    
    
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[PicList count]; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"%@%@",DomainURL, [PicList objectAtIndex:i]];
        NSString *imageTitle = [NSString stringWithFormat:@"%@景点%d",_DetialModel.Name ,i+1];
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
        [realArray addObject:model];
    }
    
    BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(0, 0, kScreenWidth, 180) andPlaceholderImageNamed:@"defaultuser" andClickdCallBlock:^(NSInteger index) {
        
    }];
    
    [_bjscrl addSubview:coverView];
    
    // 滚动视图每一次滚动都会回调此方法
    [coverView setScrollViewCallBlock:^(NSInteger index) {
        NSLog(@"当前滚动到第%d个页面", index);
    }];
    
    // 请打开下面的东西逐个调试
    [coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
    coverView.imageViewsContentMode = UIViewContentModeScaleToFill; // 图片显示内容模式模式
    // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
    // [coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
    // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
     coverView.titleLabel.hidden = YES; //隐藏TitleLabel
    
    //  主要有以下UI成员：
    //    coverView2.scrollView
    //    coverView2.pageControl
    //    coverView2.titleLabel
    // 详情请查看接口文件
    
    [coverView updateView]; //修改属性后必须调用updateView方法，更新视图
    

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,coverView.frame.origin.y+coverView.frame.size.height+5, 30, 30);
   
    [button setImage:[UIImage imageNamed:@"bf"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"baofang"] forState:UIControlStateSelected];

    [button addTarget:self action:@selector(player:) forControlEvents:UIControlEventTouchUpInside];
    self.button  =button;
    [self.bjscrl addSubview:button];
    
    
    self.elapsedTime = [[UITextField alloc]initWithFrame:CGRectMake(50, coverView.frame.origin.y+coverView.frame.size.height+15,50 ,20)];
    self.elapsedTime.text = @"00:00";
    self.elapsedTime.textColor = WJColor(51, 148, 243);
    [self.bjscrl addSubview:self.elapsedTime];
    self.timeRemaining = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-60 , coverView.frame.origin.y+coverView.frame.size.height+15,50 ,20)];
    self.timeRemaining.text = @"00:00";
    self.timeRemaining.textColor = WJColor(51, 148, 243);

    [self.bjscrl addSubview:self.timeRemaining];
    
    
    _slider  = [[UISlider alloc]initWithFrame:CGRectMake(100, coverView.frame.origin.y+coverView.frame.size.height+20, kScreenWidth-180, 10)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    _slider.value = 0;
    [_slider addTarget:self action:@selector(backOrForwardAudio:) forControlEvents:UIControlEventValueChanged];

    [self.bjscrl addSubview:_slider];

    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+10, kScreenWidth, 10)];
    lineV.backgroundColor = WJColor(242, 242, 242);
    [self.bjscrl addSubview:lineV];
    
    
       UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineV.frame)+5, 50, 20)];
    lab.text = @"简介";
    lab.font = Font_15_Weight;
    [self.bjscrl addSubview:lab];
    self.introlab = lab;
    CGFloat heitht=[NSString getHeightOfLabelText:_DetialModel.Introduction lableWidth:kScreenWidth-20 textFontSize:14];
    
    
    
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab.frame)+5, kScreenWidth-20, heitht)];
    
  
    UIView *chatbjV = [[UIView alloc]init];

    
    if (heitht>100) {

        content.size =CGSizeMake(kScreenWidth-20, 110);
       
        content.lineBreakMode = NSLineBreakByTruncatingTail;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/2-30, content.frame.origin.y+content.frame.size.height, 60, 25);
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button setTitle:@"收起" forState:UIControlStateSelected];
         button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button setTitleColor:WJColor(0, 140, 242) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bjscrl addSubview:button];
        self.morebutton = button;
        chatbjV.frame = CGRectMake(0, CGRectGetMaxY(button.frame), kScreenWidth, 700);

    }else{

        content.lineBreakMode = NSLineBreakByWordWrapping;
        content.size = CGSizeMake(kScreenWidth -20, heitht);
        chatbjV.frame = CGRectMake(0, CGRectGetMaxY(content.frame), kScreenWidth, 700);

    }
    
    _MutableStyle = [[NSMutableParagraphStyle alloc] init];
    _MutableStyle.firstLineHeadIndent = 30;
    _MutableStyle.lineSpacing = 3;//行距
    [_MutableStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [content setAttributedText:[YjlyRequest SetTextStyle:_MutableStyle AttributeText:_DetialModel.Introduction]];
    content.numberOfLines = 0;
    
    
    [self.bjscrl addSubview:content];
    
    
    self.contentLable=content;
    
    
    chatbjV.backgroundColor = [UIColor whiteColor];
    [self.bjscrl addSubview:chatbjV];
    
    UIView *bjV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    bjV1.backgroundColor = WJColor(242, 242, 242);
    [chatbjV addSubview:bjV1];
    self.chatbjV =chatbjV;
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"sj-1",@"xin22",@"xingxing_08", nil];

    for (int i = 0; i < 3  ; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i *60, 20, 10, 10)];
        imageV.image = [UIImage imageNamed:[arr objectAtIndex:i]];
        [self.chatbjV addSubview:imageV];
    }
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 30, 10)];
    lab1.text =[NSString stringWithFormat:@"%d",_DetialModel.PlayCount] ;
    lab1.textColor =WJColor(0, 140, 242);
    lab1.font = [UIFont systemFontOfSize:11];
    [self.chatbjV addSubview:lab1];
    
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 30, 10)];
    lab11.text = [NSString stringWithFormat:@"%.0ld",(long)_DetialModel.LoveCount] ;
    lab11.textColor =WJColor(0, 140, 242);
    lab11.font = [UIFont systemFontOfSize:11];
    [self.chatbjV addSubview:lab11];
    
    
    
    UILabel *lab12 = [[UILabel alloc]initWithFrame:CGRectMake(140, 20, 30, 10)];
    lab12.text =[NSString stringWithFormat:@"%.0ld",(long)_DetialModel.PraiseCount] ;
    lab12.textColor =WJColor(0, 140, 242);
    lab12.font = [UIFont systemFontOfSize:11];
    [self.chatbjV addSubview:lab12];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 400) style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorColor = [UIColor clearColor];
    [self.chatbjV addSubview:tableView];
    self.tableView = tableView;
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    LanguageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                      TableSampleIdentifier];
    if (cell == nil) {
        cell = [[LanguageTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    Language *langu =[[Language alloc]init];
    cell.delegate = self;
    [cell setData:langu];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    NSUInteger row = [indexPath row];
    //    cell.mainLabel.text= [self.list objectAtIndex:row];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
     Language *langu =[[Language alloc]init];
    CGFloat height =[NSString getHeightOfLabelText:langu.content lableWidth:kScreenWidth -20 textFontSize:14];
    return height +10 ;
    
}


-(void)moreBtn:(UIButton *)sender{
  
    CGSize  ContentSize=CGRectMake(10, CGRectGetMaxY(_introlab.frame)+5, kScreenWidth-20, 20).size;
    
    if (!sender.selected) {
        
        sender.selected = YES;
        [_contentLable setAttributedText:[YjlyRequest SetTextStyle:_MutableStyle AttributeText:_DetialModel.Introduction]];
        _contentLable.numberOfLines = 0;
        [_contentLable sizeToFit];

#pragma 计算行高 begin
        
        [_MutableStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attribute = @{NSFontAttributeName: _contentLable.font,NSParagraphStyleAttributeName:_MutableStyle};
        
        ContentSize= [_DetialModel.Introduction boundingRectWithSize:CGSizeMake(_contentLable.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        self.contentLable.frame=CGRectMake(10, self.introlab.frame.origin.y+self.introlab.frame.size.height, kScreenWidth-20, ContentSize.height);
#pragma 计算行高 end
    }else
    {
        [sender setSelected:NO];
        
        CGFloat heitht=[NSString getHeightOfLabelText:_DetialModel.Introduction lableWidth:kScreenWidth-20 textFontSize:14];
        if (heitht>100) {
            
            self.contentLable.frame=CGRectMake(10, CGRectGetMaxY(_introlab.frame)+5, kScreenWidth-20, 120);
            _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
            
            
        }else{
            
            _contentLable.lineBreakMode = NSLineBreakByWordWrapping;
            _contentLable.size = CGSizeMake(kScreenWidth -20, heitht);
            
        }
        
        ContentSize=_contentLable.frame.size;
        
    }
    
  
    self.morebutton.frame = CGRectMake(kScreenWidth/2-30, _contentLable.frame.origin.y+ContentSize.height, 60, 25);
    
    
    self.chatbjV.frame =CGRectMake(0, _morebutton.frame.origin.y+_morebutton.frame.size.height, kScreenWidth, 700);

     self.bjscrl.contentSize = CGSizeMake(kScreenWidth, 700+ContentSize.height+_contentLable.frame.origin.y+20);
    
    
  }
#pragma mark  在线播放音频文件

-(void)player:(UIButton *)button{
    
    NSLog(@"selected  %hhd",button.selected);
    
    if (!button.selected) {// 播放
        
        [button setSelected:YES];
       
        [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:[NSString stringWithFormat:@"%@%@",DomainURL,_DetialModel.URL] andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
            
            if (!error) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"mm:ss"];
                NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
                _elapsedTime.text = [formatter stringFromDate:elapsedTimeDate];
                
                NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
                _timeRemaining.text = [formatter stringFromDate:timeRemainingDate];
                _slider.value = percentage * 0.01;
            } else {
                
                NSLog(@"There has been an error playing the remote file: %@", [error description]);
            }
            ///播放结束时 设置cell为播放状态
            if (finished) {
                [_slider setValue:0.0];
                button.selected =NO;
            }
            
        }];
        
        
    }else{
        
        [[AFSoundManager sharedManager]pause];
        
        button.selected =NO;
        
    }
  }
-(void)backOrForwardAudio:(UISlider *)sender {
    
    [[AFSoundManager sharedManager]moveToSection:sender.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:YES];

}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//

#pragma mark LanguageTableViewCellDelegate
-(void)tableViewCell:(LanguageTableViewCell *)cell andGuideButton:(UIButton *)button{
    NSLog(@"----------------tttto");
    
   
}
-(void)tableViewCell:(LanguageTableViewCell *)cell andUserButton:(UIButton *)button{
    NSLog(@"------fff---------tttto");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.key];

}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
        self.view.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    //接口请求
    NSLog(@"----------dd----%@",contentView.text);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.key.textView resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
    [self.key.textView resignFirstResponder];

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
