//
//  RoutViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RoutViewController.h"
#import "FlitViewController.h"
#import "StaraddressViewController.h"
#import "DestinationViewController.h"
#import "SortViewController.h"
#import "Rout.h"
#import "RoutTableViewCell.h"
#import "StaraddressViewController.h"
#import "ProductDetailViewController.h"
@interface RoutViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,StaraddressViewControllerDelegate ,FlitViewControllerDelegate,DestinationViewControllerDelegate,SortViewControllerDelegate>

@property(nonatomic,strong)UIScrollView * bjScrol;
@property(nonatomic,weak)UIButton * selectedBtn;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *destinationV;
@property(nonatomic,strong)UIView *flitV;
@property(nonatomic,strong)UIView *startaddress;
@property(nonatomic,strong)UIView *sort;
@property(nonatomic,strong) UIButton *secBtnSeclect;

//@property(nonatomic,strong)UIView *destinationV;

@end

@implementation RoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"线路推荐";
    //    self.navigationController.navigationBarHidden = NO;
    UIScrollView *bjScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bjScrol.delegate = self;
    bjScrol.showsVerticalScrollIndicator = NO;
    bjScrol.contentSize = CGSizeMake(kScreenWidth, 900);
    [self.view addSubview:bjScrol];
    self.bjScrol = bjScrol;
    [self addFourButton];
    
    [self loadTableView];
    
    // Do any additional setup after loading the view.
}
-(void)loadTableView{
    
    _RoutDataSource =[[NSMutableArray alloc] init];
    
    _RoutTable =[[UITableView alloc]init];
    _RoutTable.dataSource = self;
    _RoutTable.delegate = self;
    _RoutTable.separatorColor = [UIColor clearColor];
    [self.bjScrol addSubview:_RoutTable];
    
    
    // 2.集成刷新控件
    [self setupRefresh];
//    [self RefreshingLoadMore];
    _RoutParameter =[NSMutableDictionary dictionary];
    [_RoutParameter setValue:@"" forKey:@"Adress"];
    [_RoutParameter setValue:@"国内跟团游" forKey:@"QualityType"];
    [_RoutParameter setValue:@"" forKey:@"MainTitle"];
    _pageIndex = 1;
    [_RoutParameter setValue:[NSString stringWithFormat:@"%ld",(long)_pageIndex] forKey:@"PageIndex"];
    [_RoutParameter setValue:PageSize forKey:@"PageSize"];
    
    [self LoadMySpace];
    
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
    RoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                               TableSampleIdentifier];
    if (cell == nil) {
        cell = [[RoutTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return 130;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *pro = [[ProductDetailViewController alloc]init];
    pro.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:pro animated:YES];
}

-(UIView *)destinationV{
    if (!_destinationV) {
        DestinationViewController *destin = [[DestinationViewController alloc]init];
        destin.delegate = self;
        destin.view.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight);
        self.destinationV = destin.view;
        [self addChildViewController:destin];
        
    }
    return _destinationV;
}
-(UIView *)flitV{
    if (!_flitV) {
        FlitViewController *flit = [[FlitViewController alloc]init];
        flit.delegate = self;
        flit.view.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight);
        [self addChildViewController:flit];
        self.flitV = flit.view;
    }
    return _flitV;
}
-(UIView *)startaddress{
    if (!_startaddress) {
        StaraddressViewController *flit = [[StaraddressViewController alloc]init];
        flit.delegate = self;
        flit.view.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight);
        [self addChildViewController:flit];
        self.startaddress = flit.view;
    }
    return _startaddress;
    
}
-(UIView *)sort{
    if (!_sort) {
        SortViewController *flit = [[SortViewController alloc]init];
        flit.delegate = self;
        flit.view.frame = CGRectMake(0, 30, kScreenWidth, kScreenHeight);
        [self addChildViewController:flit];
        self.sort = flit.view;
    }
    return _sort;
}
-(void)addFourButton{
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    bjV.backgroundColor =  WJColor(241, 241, 241);
    [self.bjScrol addSubview:bjV];
    
    NSArray *arr = [NSArray arrayWithObjects:@"出发地",@"目的地",@"排序",@"筛选", nil];
    //    UIView *lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 400, kScreenWidth, 1)];
    //    lineview.backgroundColor = WJColor(241, 241, 241);
    //    [self.view addSubview:lineview];
    //    lineview.backgroundColor = WJColor(241, 241, 241);;
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, 30);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        //        button.backgroundColor = WJColor(241, 241, 241);
        [button setImage:[UIImage imageNamed:@"sanjiao_03"] forState: UIControlStateSelected];
        
        
        [button setImage:[UIImage imageNamed:@"sanjiao1_03"] forState: UIControlStateNormal];
        
        button.tag = i + 1000;
        button.selected = NO;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:WJColor(0, 132, 232) forState:UIControlStateSelected];
        //        button.layer.borderColor = [[UIColor grayColor] CGColor];
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        
        //        button.layer.borderColor = [[UIColor grayColor] CGColor];
        //        button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bjScrol addSubview:button];
    }
    
    
    
    
    
    
    NSArray *arr2 = [NSArray arrayWithObjects:@"纯玩团",@"邮轮",@"主题",@"企业家团",@"自由行",@"自驾游", nil];
    //    UIView *lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 400, kScreenWidth, 1)];
    //    lineview.backgroundColor = WJColor(241, 241, 241);
    //    [self.view addSubview:lineview];
    //    lineview.backgroundColor = WJColor(241, 241, 241);;
    for (int i = 0; i<arr2.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/6*i, 30, kScreenWidth/6, 30);
        [button setTitleColor:WJColor(58, 151, 243) forState:UIControlStateSelected];
        [button setTitleColor:WJColor(169, 169, 169) forState:UIControlStateNormal];
        button.selected = NO;
        button.tag = 1020+i;
        //        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
        //        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        button.titleLabel.font=[UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(secondBtns:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[arr2 objectAtIndex:i] forState:UIControlStateNormal];
        [self.bjScrol addSubview:button];
        
    }
}
-(void)secondBtns:(UIButton *)button{
    self.secBtnSeclect.selected  = NO;
    button.selected = YES;
    self.secBtnSeclect = button;
    switch (button.tag) {
        case 1020:
            
            break;
        case 1021:
            
            break;
        case 1022:
            
            break;
        case 1023:
            
            break;
        case 1024:
            
            break;
        case 1025:
            
            break;
            
        default:
            break;
    }
}
-(void)doAction:(UIButton *)button{
    //    if (button.selected) {
    //
    //    }else{
    //
    //    }
    
    self.selectedBtn.selected = NO;
    self.selectedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    self.selectedBtn.backgroundColor = WJColor(241, 241, 241);
    self.selectedBtn.imageView.transform=CGAffineTransformMakeRotation(0);
    
    button.selected = YES;
    button.backgroundColor =[UIColor whiteColor];
    // button.imageView.transform=CGAffineTransformMakeRotation(-M_PI /2);
    
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.selectedBtn = button;
    switch (button.tag) {
        case 1000:
        {
            [self.sort removeFromSuperview];
            [self.flitV removeFromSuperview];
            [self.destinationV removeFromSuperview];
            [self.bjScrol addSubview:self.startaddress];
        }
            break;
        case 1001:
        {
            [self.flitV removeFromSuperview];
            [self.startaddress removeFromSuperview];
            [self.sort removeFromSuperview];
            [self.bjScrol addSubview:self.destinationV];
        }
            break;
        case 1002:
        {
            [self.flitV removeFromSuperview];
            [self.startaddress removeFromSuperview];
            [self.destinationV removeFromSuperview];
            [ self.bjScrol addSubview: self.sort ];
            
            
        }
            break;
        case 1003: //
        {
            [self.startaddress removeFromSuperview];
            [self.sort removeFromSuperview];
            
            [self.destinationV removeFromSuperview];
            [self.bjScrol addSubview:self.flitV];
            
        }
            break;
            
        default:
            break;
    }
}
-(void)hideViewControll:(NSIndexPath*)indexpath{
    self.selectedBtn.imageView.transform=CGAffineTransformMakeRotation(0);
    
    [self.startaddress removeFromSuperview];
    
}
-(void)hideSortViewControll:(NSIndexPath *)indexpath{
    self.selectedBtn.imageView.transform=CGAffineTransformMakeRotation(0);
    
    [self.sort removeFromSuperview];
    
}
-(void)hideFlitViewControll:(NSIndexPath *)indexpath{
    self.selectedBtn.imageView.transform=CGAffineTransformMakeRotation(0);
    
    [self.flitV removeFromSuperview];
}
-(void)hideDestinationViewControll:(NSIndexPath *)indexpath{
    self.selectedBtn.imageView.transform=CGAffineTransformMakeRotation(0);
    
    
    [self.destinationV removeFromSuperview];
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


#pragma 刷新动画部分
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_RoutTable addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    _RoutTable.header.updatedTimeHidden = YES;
    // 隐藏状态
    _RoutTable.header.stateHidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"xialakeshuaxin" ]]];
    [_RoutTable.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazai%zd", i]];
        [refreshingImages addObject:image];
    }
    NSMutableArray *PullingImages = [NSMutableArray array];
    [PullingImages addObject:[UIImage imageNamed:@"songkailijishuaxin"]];
    [_RoutTable.gifHeader setImages:PullingImages forState:MJRefreshHeaderStatePulling];
    [_RoutTable.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [_RoutTable.gifHeader beginRefreshing];
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [_RoutTable addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏状态
    _RoutTable.footer.stateHidden = YES;
    
    
    _RoutTable.gifFooter.refreshingImages = refreshingImages;
    [_RoutTable.gifFooter setTitle:@"正在加载更多..." forState:MJRefreshFooterStateRefreshing];
    // 此时self.tableView.footer == self.tableView.gifFooter

    
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    
    _pageIndex=1;
    [_RoutDataSource removeAllObjects];
    
    [_RoutParameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
           [self LoadMySpace];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_RoutTable.header endRefreshing];
  
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    _pageIndex++;
    [_RoutParameter setValue:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"PageIndex"];
    [self LoadMySpace];
    
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_RoutTable.footer endRefreshing];
    
}

#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [_RoutTable.footer noticeNoMoreData];
    });
}


-(void)LoadMySpace
{
    
    NSString *RoutUrl =[YjlyRequest UrlParamer:@"Quality" CmdName:@"GetJsonByQyList" Parameter:_RoutParameter];
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:DomainURL customHeaderFields:nil];
    
    MKNetworkOperation *operation=[engine operationWithPath:RoutUrl params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            NSMutableDictionary *Result =[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            
            for (NSDictionary *dic in Result) {
                
                //[_MySpaceDataSource addObject:dic];
            }
            [_RoutTable reloadData];
            
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
        [MBProgressHUD hideHUD];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"%@",[error description]);
        
    }];
    
    [engine enqueueOperation:operation];
    
}

@end
