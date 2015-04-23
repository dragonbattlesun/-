//
//  SearchViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/22.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property(nonatomic ,strong)UITextField *nametf;
@property(nonatomic ,weak)UIButton *selectedBtn;
@property(nonatomic,strong) NSMutableDictionary *loginParames;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [self.view endEditing:YES];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _HotKeyWord=[NSMutableArray array];
    
    [_HotKeyWord addObject:@"全部景点"];
    [_HotKeyWord addObject:@"星级"];
    [_HotKeyWord addObject:@"评分"];
    _IsShow = NO;
    _PageIndex=1;
    _SourceList =[[NSMutableArray alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _SearchParater =[NSMutableDictionary dictionary];
    [_SearchParater setValue:@"" forKey:@"AreaID"];
    [_SearchParater setValue:@"" forKey:@"StarLevel"];
    [_SearchParater setValue:@"" forKey:@"Name"];
    [_SearchParater setValue:@"" forKey:@"LoveCount"];
    [_SearchParater setValue:[YjlyRequest PageIndexToString:_PageIndex] forKey:@"PageIndex"];
    [_SearchParater setValue:PageSize forKey:@"PageSize"];
    [_SearchParater setValue:@"" forKey:@"Lon"];
    [_SearchParater setValue:@"" forKey:@"Lat"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 32, 25, 25);
    [button setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(conceal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _SearchView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-110, 30,260 , 25)];
    _SearchView.layer.borderColor = [[UIColor grayColor] CGColor];
    _SearchView.layer.borderWidth = 0.5;
    _SearchView.layer.cornerRadius = 12;
    [self.view addSubview:_SearchView];
    
    
    _SearchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight-70) style:UITableViewStylePlain];
    [_SearchTable setHidden:YES];
    _SearchTable.dataSource = self;
    _SearchTable.delegate = self;
    _SearchTable.tableFooterView = [[UIView alloc]init];
    _SearchTable.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:_SearchTable];
    
    
    _DefaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _DefaultButton.frame = CGRectMake(0, 0, 80, 25);
    
    [_DefaultButton setImage:[UIImage imageNamed:@"sanjiao_xia"] forState:UIControlStateNormal];
    [_DefaultButton setTitle:@"全部景点" forState:UIControlStateNormal];
    
    [_DefaultButton setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [_DefaultButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    _DefaultButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [_DefaultButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _DefaultButton.selected  =NO;
    [_DefaultButton addTarget:self action:@selector(allSecen:) forControlEvents:UIControlEventTouchUpInside];
    [_SearchView addSubview:_DefaultButton];
    
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(80, 0,1, 25)];
    _lineView.backgroundColor = [UIColor grayColor];
    [_SearchView addSubview:_lineView];
    
    _SearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(70, 0, 170, 25)];
    _SearchBar.delegate = self;
    _SearchBar.placeholder = @"输入您录制的景点名"; //默认显示的字
    _SearchBar.barTintColor = [UIColor whiteColor] ;
    [_SearchBar setBackgroundColor:[UIColor whiteColor]];
    _SearchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_SearchView addSubview:_SearchBar];
    
    UIView*line = [[UIView alloc]initWithFrame:CGRectMake(0, 69, kScreenWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    /**
     添加热点关键词
     */
    _ShowHotScenic=[[UIView alloc]initWithFrame:CGRectMake(0, 69, kScreenWidth, 60)];
    [self AddHotKeyView];
    
    [self.view addSubview:_ShowHotScenic];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_SourceList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchModel *search=(SearchModel*)[_SourceList objectAtIndex:[indexPath row]];
    //创建委托
    if ([self.delegate respondsToSelector:@selector(TableSelectScenic:)]) {
        
        [self.delegate TableSelectScenic:search];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    if (_SourceList.count > 0) {
        SearchModel *models=(SearchModel*)[_SourceList objectAtIndex:[indexPath row]];
        [cell.textLabel setText:models.SearchScenicName];

    }
    
    return cell;
}


/**
 *  KUISearchBar Delegate
 *
 *  @param searchBar
 *
 *  @return
 */
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
{
    //搜索热门词 隐藏
    _IsShow =YES;
    [_ShowHotScenic setHidden:_IsShow];
    
    [_SearchTable setHidden:NO];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_SearchParater setValue:searchText forKey:@"Name"];
    [_SourceList removeAllObjects];
    [self GetSearchList];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [_SearchParater setValue:_SearchBar.text forKey:@"Name"];
    [_SourceList removeAllObjects];
    [self GetSearchList];
}

-(void)HideTableView
{
    // [self.view endEditing:YES];
}

-(void)conceal:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)allSecen:(UIButton *)sender{
    
    if (_IsShow) {
        _IsShow = NO;
        [_ShowHotScenic setHidden:_IsShow];
        [_SearchTable setOrigin:CGPointMake(_SearchTable.origin.x, _ShowHotScenic.frame.origin.y+ _ShowHotScenic.frame.size.height)];
        
    }else
    {
        _IsShow = YES;
        [_ShowHotScenic setHidden:_IsShow];
        [_SearchTable setOrigin:CGPointMake(0, 70)];
        
    }
    
}



/**
 *  添加热点关键词
 */
-(void)AddHotKeyView{
    
    int Tagindex=1000;
    NSInteger HotKeyWordWidth= _ShowHotScenic.bounds.size.width/3;
    NSInteger HotKeyWordHeight= 40;
    /**
     *  高度增量
     */
    NSInteger AutoIncrease= -40;
    
    
    /**
     *  下划线自增索引
     */
    NSInteger lineIndex=-1;
    for (NSInteger keyIndex=0;keyIndex <[_HotKeyWord count];keyIndex ++)
    {
        if (keyIndex %3 ==0) {
            AutoIncrease +=40;
            lineIndex+=1;
        }
        
        _KeyWordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _KeyWordButton.tag=(Tagindex+keyIndex);
        
        
        _KeyWordButton.frame=CGRectMake(_ShowHotScenic.bounds.size.width/3*keyIndex, AutoIncrease, HotKeyWordWidth, HotKeyWordHeight);
        
        [_KeyWordButton setTitle:[_HotKeyWord objectAtIndex:keyIndex] forState:UIControlStateNormal];
        [_KeyWordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_KeyWordButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _KeyWordButton.selected = NO;
        
        _KeyWordButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_KeyWordButton addTarget:self action:@selector(GetHotKeyWord:) forControlEvents:UIControlEventTouchUpInside];
        [_ShowHotScenic addSubview:_KeyWordButton];
        
        /**
         添加横线
         */
        _lineView= [[UIView alloc]initWithFrame:CGRectMake(0, 39+(40*lineIndex), _ShowHotScenic.bounds.size.width, 1)];
        
        _lineView.backgroundColor = [UIColor grayColor];
        
        [_ShowHotScenic addSubview:_lineView];
        
        /**
         添加竖线
         */
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_ShowHotScenic.bounds.size.width/3+_ShowHotScenic.bounds.size.width/3*keyIndex, 10+lineIndex*40, 1, 20)];
        
        _lineView.backgroundColor = [UIColor grayColor];
        
        [_ShowHotScenic addSubview:_lineView];
        
    }
    
    
}

-(void)GetHotKeyWord:(UIButton *)button{
    
    self.selectedBtn.selected = NO;
    [self.selectedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.selected = YES;
    self.selectedBtn = button;
    NSLog(@"currentTitle %@",button.currentTitle);
    switch (button.tag) {
        case 1000:
        {
            [_DefaultButton setTitle:button.currentTitle forState:UIControlStateNormal];
            
            
        }
            break;
        case 1001:
        {
            [_DefaultButton setTitle:button.currentTitle forState:UIControlStateNormal];
            [_SearchParater setValue:@"desc" forKey:@"StarLevel"];
            [_SearchParater setValue:@"" forKey:@"LoveCount"];
        }
            break;
        case 1002:
        {
            [_DefaultButton setTitle:button.currentTitle forState:UIControlStateNormal];
            [_SearchParater setValue:@"desc" forKey:@"LoveCount"];
            [_SearchParater setValue:@"" forKey:@"StarLevel"];
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
#pragma mark 数据请求
-(void)GetSearchList{
    
    NSString *urlString =[YjlyRequest UrlParamer:@"ScenicSpot" CmdName:@"ScenicLike" Parameter:_SearchParater];
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [self JsonToModel:[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]]];
            [_SearchTable reloadData];
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];    }];
    
    [engine enqueueOperation:op];
    
    
    
}

/**
 *  存储转换
 *
 *  @param ResultList
 */
-(void)JsonToModel:(id) ResultList
{
    for (NSDictionary *dic in ResultList) {
        SearchModel  *models=[SearchModel initWithSearchModel:[[dic objectForKey:@"ID"] integerValue] SearchScenicName:[dic objectForKey:@"Name"]];
        [_SourceList addObject: models];
    }
    
}

@end
