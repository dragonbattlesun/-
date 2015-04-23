//
//  TravelGuidesViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
//获取设备的物理高度
#define kScreenHeight                      [UIScreen mainScreen].bounds.size.height


#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "DetailMethodViewController.h"
#import "RoutLineTableViewCell.h"
#import "MethodDetailCell.h"
#import "RoutViewController.h"
#import "TravelGuidesViewController.h"
#import "TravelTableViewCell.h"
#import "Travel.h"
#import "RecommendTravalModel.h"
#import "TravelGuideModel.h"

@interface TravelGuidesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) UITableView *RouttableView;

@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation TravelGuidesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    _SetSelected = 0;
    _TravelParameter =[NSMutableDictionary dictionary];
    
    _TravelDataSource=[NSMutableArray array];
    
    _RoutParameter =[NSMutableDictionary dictionary];
    
    _RoutDataSource =[NSMutableArray array];
    
    //{%22PageIndex%22:%222%22,%22PageSize%22:%222%22,%22Adress%22:%22%22,%22QualityType%22:%22%E5%9B%BD%E5%A4%96%E8%B7%9F%E5%9B%A2%E6%B8%B8%22,%22MainTitle%22:%22%E5%B8%8C%22,%22GID%22:%22845898f5480e4e5fa62dfaad556f310d%22
    [_RoutParameter setValue:@"" forKey:@"Adress"];
    [_RoutParameter setValue:@"" forKey:@"QualityType"];
    [_RoutParameter setValue:@"" forKey:@"MainTitle"];
    _RoutpageIndex = 1;
    [_RoutParameter setValue:[YjlyRequest PageIndexToString:_RoutpageIndex] forKey:@"PageIndex"];
    [_RoutParameter setValue:PageSize forKey:@"PageSize"];
    [_RoutParameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"GID"];
    
    
    [_TravelParameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"GuideID"];
    _TravelpageIndex= 1;
    [_TravelParameter setValue:[YjlyRequest PageIndexToString:_TravelpageIndex] forKey:@"PageIndex"];
    [_TravelParameter setValue:PageSize forKey:@"PageSize"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 5, kScreenWidth/2, 25);
    [button setTitle:@"线路推荐" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"glj"] forState:UIControlStateSelected];
    
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.selected = YES;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:WJColor(230, 95, 96) forState:UIControlStateSelected];
    button.tag = 100;
    [button addTarget:self action:@selector(rank:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: button ];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth/2, 5, kScreenWidth/2, 25);
    [button2 setTitle:@"旅游攻略" forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"glj"] forState:UIControlStateSelected];
    
    button2.titleLabel.font=[UIFont systemFontOfSize:15];
    button2.selected = NO;
    button2.tag = 101;
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2 setTitleColor:WJColor(230, 95, 96) forState:UIControlStateSelected];
    
    [button2 addTarget:self action:@selector(rank:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 26, kScreenWidth, 1.5)];
    bjV.backgroundColor = WJColor(231, 231, 231);
    [self.view addSubview:bjV];
    
    [ self loadTableView];

    [self rank:button];
    
    //[self LoadDataForTravel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];    //    [self setupRefresh];
    //     [self RefreshingLoadMore];
    //[self downloadImageForVisibleCellsWithTableView:_TravelTable];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)rank:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    self.selectedBtn = btn;
    
    switch (btn.tag) {//线路推荐
        case 100:
        {
            _SetSelected=0;
            [self LoadDataForTravel];
            
            [YJLYNOTIFICATION postNotificationName:@"RecommendLine" object:nil];
            
        }
            break;
        case 101: //旅游攻略
        {
            [YJLYNOTIFICATION postNotificationName:@"TravelStrategy" object:nil];
            _SetSelected=1;
            
            [self LoadDataForTravel];
        }
            
            break;
            
        default:
            break;
    }
}

/**
 *  加载Table
 */
-(void)loadTableView{
    
    _TravelTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, kScreenHeight-44-30-30) style:UITableViewStylePlain];
    _TravelTable.dataSource = self;
    _TravelTable.delegate = self;
    _TravelTable.tableFooterView =[[UIView alloc]init];
    _TravelTable.separatorColor = [UIColor clearColor];
    [self.view addSubview:_TravelTable];
    [self setupRefresh];
//    [self RefreshingLoadMore];
}

-(void)addprompt{
    UIView *proView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [self.view addSubview:proView];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    lab.text = @"路线推荐，旅游攻略";
    // lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [proView addSubview:lab];
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 180, 70)];
    lab2.text = @"选择线路推荐开始挣佣金。";
    // lab.textColor =[UIColor <#lab#>];
    lab2.font = [UIFont systemFontOfSize:15];
    lab2.numberOfLines = 0;
    lab2.lineBreakMode = NSLineBreakByWordWrapping;
    [proView addSubview:lab2];
    
    UIImageView *imageV = [[UIImageView alloc]init ];
    imageV.frame = CGRectMake(200, 50, 60, 60);
    imageV.image = [UIImage imageNamed:@"xingxing"];
    [proView addSubview:imageV];
    
}
-(void)doAction{
    NSArray *arr = [NSArray arrayWithObjects:@"燕京推荐",@"国内游",@"境外游", nil];
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/3*i, 100, kScreenWidth/3, 40);
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor grayColor];
        // button.backgroundColor = WJColor(241, 241, 241);
        button.tag = i + 1000;
        button.selected = NO;
        [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor]forState:UIControlStateSelected];
        
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        
        //        button.layer.borderColor = [[UIColor grayColor] CGColor];
        //        button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
}
-(void)doAction:(UIButton *)btn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TableView Delegate  Begin
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_SetSelected) {
        
        return [_TravelDataSource count];
    }else
    {
        return  [_RoutDataSource count];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_SetSelected) {
        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        MethodDetailCell  *Detialcell = [tableView dequeueReusableCellWithIdentifier:
                                         TableSampleIdentifier];
        if (Detialcell == nil) {
            Detialcell = [[MethodDetailCell alloc]
                          initWithStyle:UITableViewCellStyleDefault
                          reuseIdentifier:TableSampleIdentifier];
        }
        if([_TravelDataSource count]>0)
        {
            TravelGuideModel *travelModel=[_TravelDataSource objectAtIndex:[indexPath row]];
            
            [Detialcell setCellModel:travelModel];
            
            if (![travelModel.Image isEqualToString:@"" ]) {
                [Detialcell SetImageList:travelModel.Image  DefaultIcon:@"defaultUser"];
            }
        }
        //        if (tableView.isDragging&& !tableView.isDecelerating) {
        //            [self downloadImageForVisibleCellsWithTableView:tableView];
        //        }
        return Detialcell;
    }else{
        
        static NSString *TableSampleIdentifier = @"cell1";
        RoutLineTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:
                                        TableSampleIdentifier];
        if (cell == nil) {
            cell = [[RoutLineTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:TableSampleIdentifier];
        }
        
        if ([_RoutDataSource count] >0 ) {
            
            RecommendTravalModel *model=[_RoutDataSource objectAtIndex:[indexPath row]];
            [cell SetCellValue:model];
            
            if (![model.Image isEqualToString:@"" ]) {
                
                [cell SetImageList:model.Image];            }
            NSLog(@"----id--%d  imgae--%@-",model.ID,model.Image);
        }
        
        if (tableView.isDragging&& !tableView.isDecelerating) {
            [self downloadImageForVisibleCellsWithTableView:tableView];
        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_SetSelected) {
        
        TravelGuideModel *models= [_TravelDataSource objectAtIndex:[indexPath row]];
        DetailMethodViewController *detail = [[DetailMethodViewController alloc]init];
        [detail setTraveModel:models];
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        
        //        RoutViewController *root = [[RoutViewController alloc]init];
        //        [self.navigationController pushViewController:root animated:YES];
        //[_WebView setVisiteUrl:[NSURL URLWithString:@"http://app.yanjinglvyou.com/weixin/quality/quality.aspx"]];
        //[_WebView setVisiteUrl:[NSURL URLWithString:@"http://app.yanjinglvyou.com/weixin/quality/Getquality.aspx"]];
        // [self.navigationController pushViewController:_WebView animated:YES];
    }
}


#pragma mark - ScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _TravelTable) {
        [self downloadImageForVisibleCellsWithTableView:_TravelTable];
    }
}

#pragma mark - 图片异步加载方法
- (void)downloadImageForVisibleCellsWithTableView:(UITableView *)tableView
{
    NSArray *arr = [_TravelTable visibleCells];
    
    if (_SetSelected) {
        
        for (MethodDetailCell *cell in arr) {
            if (cell !=nil&&[_TravelDataSource count]>0) {
                NSIndexPath *indexPath = [_TravelTable indexPathForCell:cell];
                TravelGuideModel *model = (TravelGuideModel*)[_TravelDataSource objectAtIndex:[indexPath row]];
                if (![model.Image isEqualToString:@""]) {
                    [cell SetImageList:model.Image DefaultIcon:@"defaultUser"];
                }
                
            }
            
            
        }
    }else
    {
        for (RoutLineTableViewCell *cell in arr) {
            if (cell !=nil&&[_RoutDataSource count]>0) {
                NSIndexPath *indexPath = [_TravelTable indexPathForCell:cell];
                RecommendTravalModel *model = (RecommendTravalModel*)[_RoutDataSource objectAtIndex:[indexPath row]];
                [cell SetImageList:model.Image];
            }
        }
    }
    
    
}

#pragma  TableView Delegate End



#pragma 刷新动画部分
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_TravelTable addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    _TravelTable.header.updatedTimeHidden = YES;
    // 隐藏状态
   _TravelTable.header.stateHidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"xialakeshuaxin" ]]];
    [_TravelTable.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazai%zd", i]];
        [refreshingImages addObject:image];
    }
    NSMutableArray *PullingImages = [NSMutableArray array];
    [PullingImages addObject:[UIImage imageNamed:@"songkailijishuaxin"]];
    [_TravelTable.gifHeader setImages:PullingImages forState:MJRefreshHeaderStatePulling];
    [_TravelTable.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_TravelTable.gifHeader beginRefreshing];
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [_TravelTable addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏状态
    _TravelTable.footer.stateHidden = YES;
    
    
    _TravelTable.gifFooter.refreshingImages = refreshingImages;
    [_TravelTable.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
    // 此时self.tableView.footer == self.tableView.gifFooter
    
}

/**
 *  下啦加载更多
 */
//-(void)RefreshingLoadMore
//{
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    [_TravelTable addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // 隐藏状态
//    _TravelTable.footer.stateHidden = YES;
//    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    _TravelTable.gifFooter.refreshingImages = refreshingImages;
//    [_TravelTable.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
//    
//}



#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.
    if (_SetSelected) {
        
        _TravelpageIndex=1;
        [_TravelParameter setValue:[NSString stringWithFormat:@"%d",_TravelpageIndex] forKey:@"PageIndex"];
        [_TravelDataSource removeAllObjects];
        
    }else
    {
        _RoutpageIndex=1;
        [_RoutParameter setValue:[NSString stringWithFormat:@"%d",_RoutpageIndex] forKey:@"PageIndex"];
        [_RoutDataSource removeAllObjects];
    }
    
    
           [self LoadDataForTravel];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
//        [_TravelTable.header endRefreshing];
   
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    if (_SetSelected) {
        
        _TravelpageIndex++;
        [_TravelParameter setValue:[NSString stringWithFormat:@"%d",_TravelpageIndex] forKey:@"PageIndex"];
        
    }else
    {
        _RoutpageIndex++;
        [_RoutParameter setValue:[NSString stringWithFormat:@"%d",_RoutpageIndex] forKey:@"PageIndex"];
    }
    
   
        
        [self LoadDataForTravel];
        // 拿到当前的上拉刷新控件，结束刷新状态
   
}

#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [_TravelTable.footer noticeNoMoreData];
        
    });
}


-(void)LoadDataForTravel
{
    
    NSString *RoutUrl =[YjlyRequest UrlParamer:@"Quality" CmdName:@"GetJsonByQyListbyGIDshow" Parameter:_RoutParameter];
    
    if(_SetSelected)
    {
        
        RoutUrl =[YjlyRequest UrlParamer:@"PowerMain" CmdName:@"GetPowerMainList" Parameter:_TravelParameter];
    }
    
    NSLog(@"RoutUrl %@ ",RoutUrl);
    
    //MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:AppHostName customHeaderFields:nil];
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    
    MKNetworkOperation *operation=[engine operationWithPath:RoutUrl params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [_TravelTable.header endRefreshing];
            [_TravelTable.footer endRefreshing];

            NSMutableDictionary *Result =[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            [self JsonToModel:Result];
            [_TravelTable reloadData];
            [self downloadImageForVisibleCellsWithTableView:_TravelTable];
        }else
        {
            [_TravelTable.header endRefreshing];
            [_TravelTable.footer endRefreshing];

            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        //        [self downloadImageForVisibleCellsWithTableView:_TravelTable];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [_TravelTable.header endRefreshing];
        [_TravelTable.footer endRefreshing];

[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];        
        
    }];
    
    [engine enqueueOperation:operation];
    
    
}

-(void)JsonToModel:(NSMutableDictionary *)Result
{
    if ([Result count] == 0) {
        
        if(_SetSelected&&_TravelpageIndex==0)
        {
            [_TravelDataSource removeAllObjects];
            
        }else if(!_SetSelected&&_RoutpageIndex  == 0)
        {
            [_RoutDataSource removeAllObjects];
        }
        
    }else
    {
        
        for (NSDictionary *dictionary in Result){
            
            /**
             *  旅游攻略
             */
            if (_SetSelected) {
                
                
                [_TravelDataSource addObject:[[TravelGuideModel alloc] initWithDictionary:dictionary error:NULL]] ;
                
                
            }else ///线路推荐
            {
                
                RecommendTravalModel *models=[RecommendTravalModel initWithRecommendTraval:[[dictionary objectForKey:@"ID"] integerValue] MainTitle:[dictionary objectForKey:@"MainTitle"] ImageList:[dictionary objectForKey:@"Mark2"]  CreateTime:[dictionary objectForKey:@"CreateTime"] QualityType:[dictionary objectForKey:@"QualityType"]];
                
                NSLog(@"Mark 2 %@",[dictionary objectForKey:@"Mark2"]);
                [_RoutDataSource addObject:models];
            }
            
            
        }
    }
}

@end
