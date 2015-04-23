//
//  ScenicIntroduceViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import "ScenicIntroduceViewController.h"
#import "SceneIntrTableViewCell.h"
#import "SceneModel.h"
#import "LanguageViewController.h"
#import "AFSoundManager.h"

@interface ScenicIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate,SceneIntrTableViewCellDelegate>
@property(nonatomic,strong) NSURL *recordedFile;
@property(nonatomic,strong) UITableView * MJTableView ;
@property(nonatomic,strong) UIProgressView * progrss ;
@property(nonatomic,strong) UILabel * allTime ;
@property(nonatomic,strong) UITextField *elapsedTime;
@property(nonatomic,strong) UITextField *timeRemaining;
@property(nonatomic,strong) UISlider *slider;
@property(nonatomic,strong) UIButton *selectedBtn;
@property(nonatomic,strong) UILabel *GuiderPublishCount;
@property(nonatomic,assign)CGFloat MoveToSection;

@end

@implementation ScenicIntroduceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //显示定位坐标的地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRefresh) name:@"UpLoadSuccess" object:nil];
      _pageIndex = 1;
    [self getExplainParameter];
    _MySpaceDataSource =[[NSMutableArray alloc] init];
    //[self LoadScenicVideoList];
    [self loadScenicView];
    
    
}


-(void)addprompt{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    lab.text = @"您未发布景点讲解，发布景点讲解可以提高您的曝光率哦";
    // lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:lab];
}

/**
 *  预加载
 */
-(void)loadScenicView{
    
    //[self addprompt];
    
//    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
//    bjV.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:bjV];
    _IconArray = [NSMutableDictionary dictionary];
   _GuiderPublishCount = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,100, 25)];
    _GuiderPublishCount.textColor =WJColor(131, 140, 147);
    _GuiderPublishCount.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_GuiderPublishCount];
    
    _slider  = [[UISlider alloc]initWithFrame:CGRectMake(80, 35, kScreenWidth-160, 1)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    _slider.value = 0;
    [_slider addTarget:self action:@selector(backOrForwardAudio:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_slider];
    
    self.elapsedTime = [[UITextField alloc]initWithFrame:CGRectMake(20, 25,50 ,20)];
    self.elapsedTime.text = @"00:00";
    self.elapsedTime.textColor = WJColor(51, 148, 243);
    [self.view addSubview:self.elapsedTime];
    self.timeRemaining = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-70, 26, 50, 20)];
    self.timeRemaining.text = @"00:00";
    self.timeRemaining.textColor = WJColor(51, 148, 243);
    
    [self.view addSubview:self.timeRemaining];
    [self LoadTableView];
}


/**
 *  加载TableView
 */
-(void)LoadTableView
{
    _MJTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-50-64-30) style:UITableViewStylePlain];
    _MJTableView.dataSource = self;
    _MJTableView.delegate = self;
    _MJTableView.tableFooterView = [[UIView alloc]init];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [_MJTableView  setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    _MJTableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    [self setupRefresh];
//    [self RefreshingLoadMore];
    [self.view addSubview:_MJTableView];
    
    //[NSNotificationCenter defaultCenter] addObserver:@"NotificationAudio" selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_MySpaceDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    SceneIntrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                      TableSampleIdentifier];
    if (cell == nil) {
        cell = [[SceneIntrTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    if (_MySpaceDataSource.count>0) {
        SceneModel *models=[_MySpaceDataSource objectAtIndex:[indexPath row]];
        cell.delegate = self;
        [cell setData:models];

    }
    
       return cell;
}
-(void)backOrForwardAudio:(UISlider *)sender {
    
    [[AFSoundManager sharedManager]moveToSection:sender.value];
}
-(void)tableViewCell:(SceneIntrTableViewCell *)cell Player:(UIButton *)button{
    

    if (!button.selected) {// 播放
        [MBProgressHUD showMessage:nil];
        button.selected =YES;
        NSLog(@"cell.Mp3URL.text ==%@",cell.Mp3URL.text );
        [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:cell.Mp3URL.text andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
            [MBProgressHUD hideHUD];

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
                NSLog(@"----------------播放结束时 设置cell为播放状态");
                button.selected =NO;
            }
            
        }];

        
    }else{
        
        [[AFSoundManager sharedManager]pause];
        
        button.selected =NO;
        
    }

}
-(void)dealloc{
    [[AFSoundManager sharedManager]pause];

}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return 120;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SceneModel *detialModel=[_MySpaceDataSource objectAtIndex:[indexPath row]];
    LanguageViewController *lang = [[LanguageViewController alloc]init];
    [lang setDetialModel:detialModel];
    
    [self.navigationController pushViewController:lang animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    
//    [self setupRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
/**
 *  集成刷新控件
 */
//- (void)setupRefresh
//{
//    // 添加动画图片的下拉刷新
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    
//    [_MJTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    //[_MJTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [_MJTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [_MJTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [_MJTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
//    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
//    
//    // 马上进入刷新状态
//    [_MJTableView.gifHeader beginRefreshing];
//    
//}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.MJTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    self.MJTableView.header.updatedTimeHidden = YES;
    // 隐藏状态
    self.MJTableView.header.stateHidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"xialakeshuaxin" ]]];
    [self.MJTableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazai%zd", i]];
        [refreshingImages addObject:image];
    }
    NSMutableArray *PullingImages = [NSMutableArray array];
    [PullingImages addObject:[UIImage imageNamed:@"songkailijishuaxin"]];
    [self.MJTableView.gifHeader setImages:PullingImages forState:MJRefreshHeaderStatePulling];
    [self.MJTableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.MJTableView.gifHeader beginRefreshing];
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.MJTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏状态
    self.MJTableView.footer.stateHidden = YES;
    
    
    self.MJTableView.gifFooter.refreshingImages = refreshingImages;
//    [self.MJTableView.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
    // 此时self.tableView.footer == self.tableView.gifFooter
}

///**
// *  下啦加载更多
// */
//-(void)RefreshingLoadMore
//{
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    [_MJTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // 隐藏状态
//    _MJTableView.footer.stateHidden = YES;
//    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    _MJTableView.gifFooter.refreshingImages = refreshingImages;
//    [_MJTableView.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
//    
//}



#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    _pageIndex=1;
    [_Parameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
    [_MySpaceDataSource removeAllObjects];
    [self LoadScenicVideoList];
//           [_MJTableView.header endRefreshing];
   
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    _pageIndex++;
    [_Parameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
    [self LoadScenicVideoList];
//            // 拿到当前的上拉刷新控件，结束刷新状态
//        [_MJTableView.footer endRefreshing];
}


-(void)LoadScenicVideoList
{
    
//    [MBProgressHUD showMessage:@"景点讲解加载中..."];
    
    NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Video" CmdName:@"MyToExplain" Parameter:_Parameter];
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *operation=[engine operationWithPath:MySpaceUrl params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [MBProgressHUD hideHUD];
        
        JsonToModel *jsonData=[[JsonToModel alloc] initWithDictionary:[completedOperation responseJSON] error:NULL];
        
        //判断是否返回json数据
        if(jsonData !=nil && [jsonData.state isEqualToString:@"0"])
        {
            [_MJTableView.header endRefreshing];

            // 拿到当前的上拉刷新控件，结束刷新状态
            [_MJTableView.footer endRefreshing];
            [self JsonToModel:[YjlyRequest dictionaryWithJsonString:jsonData.value]];
            
            [_MJTableView reloadData];
            [_GuiderPublishCount setText:[NSString stringWithFormat:@"导游语（%lu）",(unsigned long)[_MySpaceDataSource count]]];
            
        }else
        {           [_MJTableView.header endRefreshing];

            // 拿到当前的上拉刷新控件，结束刷新状态
            [_MJTableView.footer endRefreshing];
            [MBProgressHUD showError:jsonData.msg];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [_MJTableView.header endRefreshing];

        // 拿到当前的上拉刷新控件，结束刷新状态
        [_MJTableView.footer endRefreshing];
//        [MBProgressHUD showError:[error debugDescription]];
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
        
    }];
    
    [engine enqueueOperation:operation];
    
}


-(void)JsonToModel:(id) ResultList
{
    for (NSDictionary *dic in ResultList) {
        
        SceneModel *model=[[SceneModel alloc] initWithDictionary:dic error:NULL];
        
        [_MySpaceDataSource addObject: model];
    }
    
}

/**
 *  获取景点讲解参数
 */
-(void)getExplainParameter
{
    _Parameter =[NSMutableDictionary dictionary];
    [_Parameter setValue:[YjlyRequest PageIndexToString:_pageIndex] forKey:@"PageIndex"];
    [_Parameter setValue:PageSize forKey:@"PageSize"];
    [_Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
}
@end
