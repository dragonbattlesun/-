//
//  MySpaceTable.m
//  TheGuideSide
//
//  Created by sunjames on 15/4/5.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
//获取设备的物理高度
#define kScreenHeight                      [UIScreen mainScreen].bounds.size.height

NSString *const _MJTableViewCellIdentifier = @"Cell";

#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "NSString+AutoHeight.h"
#import "SpaceStatus.h"
#import "aaTableViewCell.h"
#import "MySpaceTable.h"
#import "UIView+MJExtension.h"
#import "GuiderInfoModel.h"

@interface MySpaceTable ()

@end

@implementation MySpaceTable
-(void)dealloc{
    [YJLYNOTIFICATION removeObserver:self name:@"spaceEditSuccess" object:nil];
}
-(void)spaceEditSuccess{
//    [self.MJTableView.gifHeader beginRefreshing];
    [self setupRefresh];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [YJLYNOTIFICATION addObserver:self selector:@selector(spaceEditSuccess) name:@"spaceEditSuccess" object:nil];

    _MySpaceDataSource =[NSMutableArray array];
    _MJTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight-44-30) style:UITableViewStylePlain];
    _MJTableView.dataSource = self;
    _MJTableView.delegate = self;
    _MJTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_MJTableView];

    
    // 2.集成刷新控件
    [self setupRefresh];
//    [self RefreshingLoadMore];
    
    _Parameter =[NSMutableDictionary dictionary];
    [_Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
    _pageIndex = 1;
    [_Parameter setValue:[NSString stringWithFormat:@"%ld",(long)_pageIndex] forKey:@"PageIndex"];
    [_Parameter setValue:PageSize forKey:@"PageSize"];

    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self setupRefresh ];


}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 数据处理相关 begin

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
    [self.MJTableView.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
    // 此时self.tableView.footer == self.tableView.gifFooter
}

/**
 *  下啦加载更多实现的方法
 */
-(void)RefreshingLoadMore
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [_MJTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏状态
    _MJTableView.footer.stateHidden = YES;
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    _MJTableView.gifFooter.refreshingImages = refreshingImages;
    [_MJTableView.gifFooter setTitle:@"点击加在更多..." forState:MJRefreshFooterStateIdle];
    
    [_MJTableView.gifFooter setTitle:@"正在加载..." forState:MJRefreshFooterStateRefreshing];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
 
    _pageIndex=1;
    [_Parameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
    [self LoadMySpace];
           [_MySpaceDataSource removeAllObjects];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
//        [_MJTableView.header endRefreshing];
    }

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    _pageIndex++;
    [_Parameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
     [self LoadMySpace];
    [_MJTableView.footer endRefreshing];

            // 拿到当前的上拉刷新控件，结束刷新状态
        if ([_MySpaceDataSource count]>10) {
            
           // [_MJTableView.footer endRefreshing];
        }
    }

#pragma mark - 刷新处理 end

#pragma mark - Tableview delegate begin
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_MySpaceDataSource count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    aaTableViewCell *cell= (aaTableViewCell*)[self tableView:_MJTableView cellForRowAtIndexPath:indexPath];
   
    return  cell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reusableIdentifier = @"MySpace";
    aaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    if (cell == nil) {
        cell = [[aaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if ([_MySpaceDataSource count]>0) {
        
        SpaceStatus *sp = [_MySpaceDataSource objectAtIndex:[indexPath row]];
        
        [cell setData:sp];
        
       
        [cell SetImageList:sp.imgUrls];
        
//        if (_MJTableView.isDragging && !_MJTableView.isDecelerating) {
//            [self downloadImageForVisibleCellsWithTableView:_MJTableView];
//        }
    }
    ///图片处理
    
    return cell;
}

#pragma mark - Tableview delegate end



#pragma mark - ScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _MJTableView) {
        [self downloadImageForVisibleCellsWithTableView:_MJTableView];
    }
}

#pragma mark - 图片异步加载方法
- (void)downloadImageForVisibleCellsWithTableView:(UITableView *)tableView
{
    NSArray *arr = [_MJTableView visibleCells];
    for (aaTableViewCell *cell in arr) {
        if (cell !=nil&&[_MySpaceDataSource count]>0) {
            NSIndexPath *indexPath = [_MJTableView indexPathForCell:cell];
            SpaceStatus *model = (SpaceStatus*)[_MySpaceDataSource objectAtIndex:[indexPath row]];
            [cell SetImageList:model.imgUrls];
        }
    }
}



///网络请求
-(void)LoadMySpace
{
    
    //[MBProgressHUD showMessage:@"我的空间加载中..."];
    
    NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Zone" CmdName:@"DMyZone" Parameter:_Parameter];
 
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:AppHostName customHeaderFields:nil];
    
    MKNetworkOperation *operation=[engine operationWithPath:MySpaceUrl params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [MBProgressHUD hideHUD];
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            NSMutableDictionary *Result =[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            
            if ([Result count]>0) {
                
                for (NSDictionary *dic in Result) {
                    
                    
                    
                    SpaceStatus *sp  =[[SpaceStatus alloc] initWithData:[dic objectForKey:@"CreateDateTime"] andContent:[dic objectForKey:@"Word"] ImageUrlArrs:[dic objectForKey:@"Image"]];
                    [_MySpaceDataSource addObject:sp];
                }
                
                [_MJTableView reloadData];
               // dispatch_async(dispatch_get_main_queue(), ^{
dispatch_async(dispatch_get_main_queue(), ^{
    [_MJTableView.header endRefreshing];
    [_MJTableView.footer endRefreshing];
});
               

                [self downloadImageForVisibleCellsWithTableView:_MJTableView];
            }
            
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_MJTableView.header endRefreshing];
                [_MJTableView.footer endRefreshing];
            });

        }
        
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_MJTableView.header endRefreshing];
            [_MJTableView.footer endRefreshing];
        });

        
    }];
    
    [engine enqueueOperation:operation];
    
}

@end
