//
//  RecordViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RecordViewController.h"
#import "SearchViewController.h"
#import "MLAudioRecorder.h"
#import "CafRecordWriter.h"
#import "AmrRecordWriter.h"
#import "Mp3RecordWriter.h"
#import <AVFoundation/AVFoundation.h>
#import "MLAudioMeterObserver.h"
#import "lame.h"
#define NEW_PLAY_BUTTON_TAG 1011
#define PAUSE_BUTTON_TAG 1015

#define PAUSE_PLAY_BUTTON_TAG 1012

@interface RecordViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
{
    UILabel* recordTitleLabel;
    UISlider* progressView;
    UILabel* timeLabel;
//    UILabel* RectimeLabel;
    UIButton* pauseButton;

    UIButton* recordButton;
    UILabel* recordLabel;

    
    NSTimer* timer;
//    NSTimer* Rectimer;

    float recordTime;
    int playTime;
    int playDuration;
    int second;
    int minute;

    
    
    AVAudioSession * audioSession;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;

    
    
    NSURL* recordUrl;
    NSURL* mp3FilePath;
    NSURL* audioFileSavePath;
}
@property (nonatomic) BOOL isRecording;
@property (nonatomic,strong) NSURL *recordedFile;
@property(nonatomic,strong) UIButton  *ksly;
@property(nonatomic,strong) UIButton  *bdsc;
@property(nonatomic,strong) UILabel  *titleLab;
@property(nonatomic,strong) UIImageView *imageV1;
@property(nonatomic,strong) UIImageView *imageV2;
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *listening;
@property(nonatomic,strong) UIScrollView *bjScro;
@property(nonatomic,strong) UIView *clscView;
@property (nonatomic, strong) MLAudioRecorder *recorder;
@property (nonatomic, strong) CafRecordWriter *cafWriter;
@property (nonatomic, strong) AmrRecordWriter *amrWriter;
@property (nonatomic, strong) Mp3RecordWriter *mp3Writer;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) MLAudioMeterObserver *meterObserver;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic,strong) UIProgressView *ShowProgress;
@property (nonatomic,strong) UILabel *ShowText;

@end

@implementation RecordViewController
static int i;

-(void)viewWillAppear:(BOOL)animated{
    i = 0;
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)dealloc
{
    //音谱检测关联着录音类，录音类要停止了。所以要设置其audioQueue为nil
    self.meterObserver.audioQueue = nil;
    [self.recorder stopRecording];
    [self.timer reset];
    [self.timer pause];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"luyinjiesu" object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(volumeChanged:)
     
                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
     
                                               object:nil];
    
    [self AddToExplainParameter];
    self.view.backgroundColor = WJColor(242, 242, 242);
    self.navigationItem.title = @"录音";
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    // bjScro.backgroundColor = [UIColor redColor];
    bjScro.contentSize = CGSizeMake(kScreenWidth, 100);
    bjScro.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bjScro];
    self.bjScro =bjScro;
    
    _searchView = [[SearchViewController alloc]init];
    
    _searchView.delegate =self;
    
    //---------------------------------------------------
    //开始录音
    
////    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 10, 100, 20)];
////    lab.text = @"点击录音";
////    lab.textAlignment = NSTextAlignmentCenter;
////    lab.textColor =WJColor(98, 98, 98);
////    lab.font = [UIFont boldSystemFontOfSize:16];
////    [self.bjScro addSubview:lab];
//    self.titleLab = lab;
    //开始录音按钮
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.frame = CGRectMake(kScreenWidth/2-30 , 35, 60, 60);
    [self.recordButton setImage:[UIImage imageNamed:@"kaishiluyin_03"] forState:UIControlStateNormal];
    [self.recordButton setImage:[UIImage imageNamed:@"zhenzailuyin_03"] forState:UIControlStateSelected];
    //    [startRec setTitle:@"开始录音" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:WJColor(98  , 98, 98) forState:UIControlStateNormal];
    [self.recordButton setTitleColor:WJColor(51, 148, 243) forState:UIControlStateSelected];
    self.recordButton.titleLabel.font=[UIFont systemFontOfSize:16];
    self.recordButton.tag = 1000 ;
    self.recordButton.selected = NO;
    [self.recordButton addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.bjScro addSubview:self.recordButton];
    
    UIButton *ksly = [UIButton  buttonWithType:UIButtonTypeCustom];
    ksly.frame = CGRectMake(kScreenWidth/2-100, 115 , 80, 20);
    [ksly setTitle:@"开始录音" forState:UIControlStateNormal] ;
    [ksly setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ksly setTitleColor:WJColor(52, 148, 249) forState:UIControlStateSelected];
    //    ksly.font = [UIFont boldSystemFontOfSize:16];
    //[ksly addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ksly];
    self.ksly = ksly;
    
    
    UIButton *bdsc = [UIButton  buttonWithType:UIButtonTypeCustom];
    bdsc.frame = CGRectMake(kScreenWidth/2+20, 115 , 80, 20);
    [bdsc setTitle:@"本地上传" forState:UIControlStateNormal] ;
    [bdsc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [bdsc addTarget:self action:@selector(bdscAction:) forControlEvents:UIControlEventTouchUpInside];
    [bdsc setTitleColor:WJColor(52, 148, 249) forState:UIControlStateSelected];
    //    ksly.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:bdsc];
    self.bdsc = bdsc;
    
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 105, 5, 5)];
    imageV1.image = [UIImage imageNamed:@"yuandian_03"];
    [self.view addSubview:imageV1];
    self.imageV1 =imageV1;
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+60, 105, 5, 5)];
    imageV2.image = [UIImage imageNamed:@"yuandian_03"];
    [self.view addSubview:imageV2];
    self.imageV2 =imageV2;
    
    
    
    //---------------------------------------------------------
    //重录和上传  试听界面
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, 150)];
    bjV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjV];
    self.clscView = bjV;
    
    _ShowProgress =[[UIProgressView alloc] initWithFrame:CGRectMake(20, 55, self.view.frame.size.width-100, 20)];
    [_ShowProgress setHidden:YES];
    _ShowText =[[UILabel alloc] initWithFrame:CGRectMake(_ShowProgress.frame.origin.x+_ShowProgress.frame.size.width+10, 45, 50, 20)];
    [_ShowText setHidden:YES];
    [_ShowText setFont:[UIFont systemFontOfSize:13]];
    
    [_ShowText setTextColor:[UIColor blueColor]];
    
    [self.clscView addSubview:_ShowText];
    
    [self.clscView addSubview:_ShowProgress];
    
//    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 10, 100, 20)];
//    [timeLabel setText:@"00:00"];
//    [timeLabel setFont:[UIFont systemFontOfSize:32]];
//    [timeLabel setTextColor:[UIColor blackColor]];

    
//    MZTimerLabel *timer22 = [[MZTimerLabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 10, 100, 20)];
//    timer22.timerType = MZTimerLabelTypeStopWatch;
//    [self.clscView addSubview:timer22];
//    //do some styling
//    timer22.timeLabel.backgroundColor = [UIColor clearColor];
//    timer22.timeLabel.font = [UIFont systemFontOfSize:20.0f];
//    timer22.timeLabel.textColor = WJColor(51, 148, 243);
//    timer22.timeLabel.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
//    //fire
//    self.timer2 = timer22;
    
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 10, 100, 15)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [timeLabel setText:@"00:00"];
    [timeLabel setFont:[UIFont systemFontOfSize:15]];
    [timeLabel setTextColor:yjlyseleted];
    [self.clscView addSubview:timeLabel];
    [self.view addSubview:timeLabel];

    // 试听
    self.listening = [UIButton buttonWithType:UIButtonTypeCustom];
    // button.backgroundColor = [UIColor blueColor];
    self.listening.frame = CGRectMake( kScreenWidth/2-30 , 0, 60, 60);
//    [self.listening setImage:[UIImage imageNamed:@"shiting_03"] forState:UIControlStateSelected];
    //    [startRec setTitle:@"开始录音" forState:UIControlStateNormal];
    [self.listening setImage:[UIImage imageNamed:@"luzhiwancheng_03"] forState:UIControlStateNormal];
    [self.listening setTitleColor:WJColor(98  , 98, 98) forState:UIControlStateNormal];
    [self.listening setTitleColor:WJColor(51, 148, 243) forState:UIControlStateSelected];
    self.listening.titleLabel.font=[UIFont systemFontOfSize:16];
    self.listening.tag = NEW_PLAY_BUTTON_TAG ;
    self.listening.selected = NO;
    [self.listening addTarget:self action:@selector(listening:) forControlEvents:UIControlEventTouchUpInside];
    [self.clscView addSubview:self.listening];
    [self.view addSubview:self.clscView];
    
    
    
    pauseButton = [[UIButton alloc] initWithFrame:CGRectMake( kScreenWidth/2-30 , 0, 60, 60)];
    [pauseButton setImage:[UIImage imageNamed:@"shiting_03.png"] forState:UIControlStateNormal];
    pauseButton.tag = PAUSE_BUTTON_TAG;
    [pauseButton addTarget:self action:@selector(listening:) forControlEvents:UIControlEventTouchUpInside];
//    [self.clscView addSubview:pauseButton];

    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 70, kScreenWidth/2, 40);
    [button setTitleColor:WJColor(51, 148, 243) forState:UIControlStateNormal];
    
    //    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"重录" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    button.layer.borderWidth  = 1;
    button.layer.borderColor = [WJColor(206, 206, 206) CGColor];
    [button addTarget:self action:@selector(remake) forControlEvents:UIControlEventTouchUpInside];
    [self.clscView addSubview:button];
    self.button = button;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth/2, 70, kScreenWidth/2, 40);
    [button2 setTitleColor:WJColor(51, 148, 243) forState:UIControlStateNormal];
    [button2 setTag:1000];
    //    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button2 setTitle:@"上传" forState:UIControlStateNormal];
    button2.titleLabel.font=[UIFont systemFontOfSize:16];
    button2.layer.borderWidth  = 1;
    button2.layer.borderColor = [WJColor(206, 206, 206) CGColor];
    [button2 addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [self.clscView addSubview:button2];
    self.button2 = button2;
    
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）, 采样率必须要设为11025才能使转化成mp3格式后不会失真
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    //录音通道数  1 或 2 ，要转换成mp3格式必须为双通道
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    //存储录音文件
    recordUrl = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"selfRecord.caf"]];
    
    //初始化
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:recordUrl settings:recordSetting error:nil];
    //开启音量检测
    audioRecorder.meteringEnabled = YES;
    audioRecorder.delegate = self;
    
}

-(void)changbButtonandTime:(NSDictionary *)userInfo{
    [self.timer pause];
    [self.recordButton setImage:[UIImage imageNamed:@"kaishiluyin_03"] forState:UIControlStateNormal];
}
#pragma mark 重录
//重录
-(void)remake{
    self.clscView.transform = CGAffineTransformIdentity;
    [self.clscView addSubview:self.listening];
    [pauseButton removeFromSuperview];
    
    [self.recordButton setImage:[UIImage imageNamed:@"zhenzailuyin_03"] forState:UIControlStateNormal];
//    [timeLabel setText:@"00:00"];
//    [timer invalidate];

    [self beginRecord:self.recordButton];
//    [self.timer reset];
//    [self.timer start];
    self.imageV1.hidden = NO;
    self.imageV2.hidden = YES;
}

/**
 *  上传录音
 */
-(void)upload{
    
    [self  presentViewController:_searchView animated:YES completion:nil];
}

/**
 *  委托必须实现的方法
 *
 *  @param model
 */
-(void)TableSelectScenic:(SearchModel *)model
{
    [_AddToExplain setValue:[YjlyRequest PageIndexToString:model.SearchScenicID] forKey:@"Scenic"];
    
    [_AddToExplain setValue:model.SearchScenicName forKey:@"Title"];
    
//    playDuration = (int)audioPlayer.duration;
   NSLog(@"---------音频时长为：%i",_RecordTime);
    
    [_AddToExplain setValue:[NSString stringWithFormat:@"%d",_RecordTime] forKey:@"Datetime"];
    
    [self ShowProgressForView:YES];
    
    [self DeliverInformation];
}

//本地上传
-(void)bdscAction:(UIButton *)button{
    
    
}
#pragma mark 开始录音
-(void)beginRecord:(UIButton *)recordButton{//开始录音
    audioSession = [AVAudioSession sharedInstance];//得到AVAudioSession单例对象
    
 
    NSTimeInterval timeCounted = [self.timer getTimeCounted];
  
    //_RecordTime=timeCounted;
  
    if ([audioRecorder isRecording]) {
  
        //取消录音
        [self.timer reset];
        [self.timer pause];

       [audioRecorder stop];                          //录音停止
       [audioSession setActive:NO error:nil];         //一定要在录音停止以后再关闭音频会话管理（否则会报错），此时会延续后台音乐播放
        
        

        
//        playDuration
        [timer invalidate];                            //timer失效
        [timeLabel setText:@"00:00"];                  //时间显示复位
        [progressView setValue:0 animated:YES];
        [self.recordButton setImage:[UIImage imageNamed:@"kaishiluyin_03"] forState:UIControlStateNormal];
        
        self.clscView.transform=CGAffineTransformMakeTranslation(0, -115);
        [self transformCAFToMP3];
        
//        //获取音频时长
//        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordUrl error:nil];
//        playDuration = (int)audioPlayer.duration;
//        NSLog(@"recordUrl==音频时长为：%i",playDuration);

        
    }else{
        
//        [recordButton setTitle:@"Stop" forState:UIControlStateNormal];
        //开始录音
        self.titleLab.hidden = YES;
        self.timer.hidden = NO;
        [self.timer reset];
        [self.timer start];
  
  [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];//设置类别,表示该应用同时支持播放和录音
  [audioSession setActive:YES error:nil];//启动音频会话管理,此时会阻断后台音乐的播放.
  
  [audioRecorder prepareToRecord];
  [audioRecorder peakPowerForChannel:0.0];
  [audioRecorder record];
  recordTime = 0;
  [self recordTimeStart];

  
        [self.recordButton setImage:[UIImage imageNamed:@"zhenzailuyin_03"] forState:UIControlStateNormal];
        
    }
   
    
    
    
}
- (void)recordTimeStart {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordTimeTick) userInfo:nil repeats:YES];
}
- (void)recordTimeTick {
    
    playDuration=(int)audioRecorder.currentTime;
//    NSLog(@"audioRecorder.currentTime==%d",(int)audioRecorder.currentTime);
    _RecordTime=playDuration;
    NSLog(@"audioRecorder.currentTime==%d",_RecordTime);

    recordTime += 1;
    [progressView setValue:(float)recordTime/30.0 animated:YES];
    if (recordTime == 300) {
        recordTime = 0;
        
        
        [audioRecorder stop];
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [timer invalidate];
        [timeLabel setText:@"00:00"];
        [progressView setValue:0.0 animated:YES];
        
        self.clscView.transform=CGAffineTransformMakeTranslation(0, -115);
        [self transformCAFToMP3];

        
        return;
    }
    [self updateAudioRecordTime];
}
- (void)updateAudioRecordTime {
    minute = recordTime/60.0;
    second = recordTime-minute*60;
    
    [timeLabel setText:[NSString stringWithFormat:@"%02d:%02d",minute,second]];
}

#pragma mark 试听
-(void)listening:(UIButton *)button{
    switch (button.tag) {
        case NEW_PLAY_BUTTON_TAG:
        {
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            [audioSession setActive:YES error:nil];
            
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordUrl error:nil];
            [audioPlayer prepareToPlay];
            audioPlayer.volume = 1;
            [audioPlayer play];
            
            [self.listening removeFromSuperview];
//            [playLabel removeFromSuperview];
            [self.clscView addSubview:pauseButton];
//            [self.view addSubview:pauseLabel];
            
            playDuration = (int)audioPlayer.duration;
            NSLog(@"音频时长为：%i",playDuration);
            playTime = 0;
            [self audioPlayTimeStart];
  
        }
            break;
            case PAUSE_PLAY_BUTTON_TAG:
        {
            [audioSession setActive:YES error:nil];
            
            [audioPlayer play];
            
            [self.listening removeFromSuperview];
//            [playLabel removeFromSuperview];
            [self.clscView addSubview:pauseButton];
//            [self.view addSubview:pauseLabel];

        }
            break;
        case PAUSE_BUTTON_TAG:{
            [audioPlayer pause];
            [audioSession setActive:NO error:nil];
            
            self.listening.tag = PAUSE_PLAY_BUTTON_TAG;
            [pauseButton removeFromSuperview];
//            [pauseLabel removeFromSuperview];
            [self.clscView addSubview:self.listening];
//            [self.view addSubview:playLabel];
        }
            break;
           

            
        default:
            break;
    }
    
}
- (void)audioPlayTimeStart {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playTimeTick) userInfo:nil repeats:YES];
}

- (void)playTimeTick {
    if (playDuration == playTime) {
        playTime = 0;
        [audioPlayer stop];
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [pauseButton removeFromSuperview];
        [self.clscView addSubview:self.listening];

        self.listening.tag = NEW_PLAY_BUTTON_TAG;
        
        [timeLabel setText:@"00:00"];
        [timer invalidate];
        progressView.value = 0;
        return;
    }
    if (![audioPlayer isPlaying]) {
        return;
    }
    playTime += 1;
    [progressView setValue:(float)playTime/(float)playDuration animated:YES];
    [self updateAudioPlayTime];
}
- (void)updateAudioPlayTime {
    minute = playTime/60.0;
    second = playTime-minute*60;
    
    [timeLabel setText:[NSString stringWithFormat:@"%02d:%02d",minute,second]];
}

//播放完成时调用的方法  (代理里的方法),需要设置代理才可以调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{    i = 0;
    [self.listening setImage:[UIImage imageNamed:@"luzhiwancheng_03"] forState:UIControlStateSelected];
    [self.timer2 pause];
    
    
    [audioSession setActive:NO error:nil];
    
    playTime = 0;
    
    [pauseButton removeFromSuperview];
//    [pauseLabel removeFromSuperview];
    [self.clscView addSubview:self.listening];
//    [self.view addSubview:playLabel];
    self.listening.tag = NEW_PLAY_BUTTON_TAG;
    
    [timeLabel setText:@"00:00"];
    [timer invalidate];
    progressView.value = 0;

    
    // [self.timer invalidate]; //NSTimer暂停   invalidate  使...无效;
}

-(void)rank:(UIButton *)btn{
    switch (btn.tag) {
        case 1001: //试听
        {
            
            if([self.player isPlaying])
            {
                [self.player pause];
                [btn setTitle:@"播放" forState:UIControlStateNormal];
            }
            //If the track is not player, play the track and change the play button to "Pause"
            else
            {
                [self.player play];
                [btn setTitle:@"暂停" forState:UIControlStateNormal];
            }
            
        }
            break;
        case 1002:// 重录
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DeliverInformation
{
    NSLog(@"audioRecorder.currentTime==%d",_RecordTime);

    playDuration = (int)audioPlayer.duration;
    NSLog(@"音频时长为：%i",playDuration);
    
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    [_AddToExplain setValue:_RecordPath forKey:@"Path"];
    
    
    NSString *AddDeliverURL=[YjlyRequest UrlParamer:@"Video" CmdName:@"AddToExplain" Parameter:_AddToExplain];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:AppHostName customHeaderFields:headerFields];
    
    
    MKNetworkOperation *operation=[engine operationWithPath:AddDeliverURL params:nil httpMethod:@"post"];
    
    [operation addFile:_RecordPath forKey:@"media"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpLoadSuccess" object:nil];
            [MBProgressHUD showSuccess:[jsonData objectForKey:@"value"]];
            [self deleteRecordFile];
            
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
        [MBProgressHUD hideHUD];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];        
    }];
    
    [engine enqueueOperation:operation];
    
    
    /**
     *  显示进度条
     *
     *  @param progress <#progress description#>
     *
     *  @return <#return value description#>
     */
    [operation onUploadProgressChanged:^(double progress) {
        
        _ShowProgress.progress = progress;
        if(progress>=1)
        {
            
            [_ShowText setText:@"上传完毕"];
            [self ShowProgressForView:NO];
        }else
        {
            [_ShowText setText:[NSString stringWithFormat:@"%f%%",progress*100]];
            
        }
        
    }];
}

// 删除沙盒里的文件
-(void)deleteRecordFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"myselfRecord.mp3"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
}
/**
 *  添加景点讲解参数
 */

-(void)AddToExplainParameter
{
    _AddToExplain=[NSMutableDictionary dictionary];
    /**
     *  景点ID
     */
    [_AddToExplain setValue:@"" forKey:@"Scenic"];
    /**
     *  录音时长
     */
    [_AddToExplain setValue:@"180" forKey:@"Datetime"];
    /**
     *  标题
     */
    [_AddToExplain setValue:@"test" forKey:@"Title"];
    /**
     *  路径
     */
    [_AddToExplain setValue:@"" forKey:@"Path"];
    
    
    [_AddToExplain setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
}

-(void)ShowProgressForView:(BOOL)IsShow
{
    if(IsShow)
    {
        
        [self.ShowProgress setHidden:NO];
        
        [self.ShowText setHidden:NO];
        
        [self.timer setHidden:YES];
        
        [self.timer setEnabled:NO];
        
        [self.listening setHidden:YES];
        
        [self.listening setEnabled:NO];
        
        
        
        
    }else
    {
        
        
        [self.ShowProgress setHidden:YES];
        
        [self.ShowText setHidden:YES];
        
        [self.timer setHidden:NO];
        
        [self.timer setEnabled:YES];
        
        [self.listening setHidden:NO];
        
        [self.listening setEnabled:YES];
        
        
        
        
    }
}


-(void)volumeChanged:(NSNotification *)notification {
    self.player.volume= [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
}
- (void)transformCAFToMP3 {
    
    mp3FilePath = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"myselfRecord.mp3"]];
    
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([[recordUrl absoluteString] cStringUsingEncoding:1], "rb");   //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                                   //skip file header
        FILE *mp3 = fopen([[mp3FilePath absoluteString] cStringUsingEncoding:1], "wb"); //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        audioFileSavePath = mp3FilePath;
        NSLog(@"MP3生成成功: %@",audioFileSavePath);
        [self.timer start];
        _RecordPath =[NSString stringWithFormat:@"%@",mp3FilePath];
        NSLog(@"%@--",_RecordPath);
        NSLog(@"---%@",self.timer.text);
        
//      duration
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"mp3转化成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        
        
                //获取音频时长
          AVAudioPlayer*  audioPlayermp3 = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3FilePath error:nil];
                playDuration = (int)audioPlayermp3.duration;
                NSLog(@"mp3FilePath==音频时长为：%i",playDuration);
        recordTime = playDuration;
        
        
        
        
        AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:mp3FilePath options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
        recordTime = audioDurationSeconds;

        NSLog(@"===audioDurationSeconds==%f",audioDurationSeconds);
    }
}

@end
