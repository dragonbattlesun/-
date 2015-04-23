//
//  DressSearchViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "DressSearchViewController.h"
#import "CityMessage.h"
@interface DressSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;//数据源
    NSMutableArray *_resultsData;//搜索结果数据
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
}

@end

@implementation DressSearchViewController
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    self.navigationController.navigationBarHidden = YES;
    
    _dataArray = [NSMutableArray array];
    _resultsData = [NSMutableArray array];
    
    [self initNav];
//    [self initDataSource];
    [self initTableView];
    [self initMysearchBarAndMysearchDisPlay];
    [self getAllData];
}

//-(void)initDataSource
//{
//    for (int i = 0; i < 50; i ++) {
//        [_dataArray addObject:[NSString stringWithFormat:@"Hello World %d",i]];
//    }
//}

-(void)initNav{
    //状态栏的背景颜色
    UILabel *twoL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, IOS7?64:44)];
    twoL.backgroundColor = WJColor(249, 249, 249);
    [self.view addSubview:twoL];
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,IOS7?20:0, 320, 44)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = WJColor(11, 104, 210);
    navLabel.text = @"搜索列表";
    navLabel.font = [UIFont systemFontOfSize:18];
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.userInteractionEnabled = YES;
    [self.view addSubview:navLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,IOS7?20:0, 40, 44);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)initTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, IOS7?64:44, 320, kScreenHeight-64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [[UIView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    if (IOS7)
        //分割线的位置不带偏移
        _tableView.separatorInset = UIEdgeInsetsZero;
}

-(void)initMysearchBarAndMysearchDisPlay
{
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.delegate = self;
    //    //设置选项
    //    [mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    mySearchBar.backgroundColor =WJColor(249, 249, 249);
    mySearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:mySearchBar.bounds.size];
    //加入列表的header里面
    _tableView.tableHeaderView = mySearchBar;
    
    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    mySearchDisplayController.delegate = self;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods

//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (IOS7) {
        subViews = [(mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態
    [UIView animateWithDuration:1.0 animations:^{
        _tableView.frame = CGRectMake(0, 20, 320, kScreenHeight-20);
    }];
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀
    [UIView animateWithDuration:1.0 animations:^{
        _tableView.frame = CGRectMake(0, IOS7?64:44, 320, kScreenHeight-64);
    }];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchString:(NSString *)searchString

{
    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:searchString
                               scope:[mySearchBar scopeButtonTitles][mySearchBar.selectedScopeButtonIndex]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    //如果设置了选项，当Scope Button选项有變化的时候，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:mySearchBar.text
                               scope:mySearchBar.scopeButtonTitles[searchOption]];
    
    return YES;
}

//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < _dataArray.count; i++) {
        CityMessage *citymess = _dataArray[i];
        NSString *storeString =citymess.CityName;
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [tempResults addObject:storeString];
        }
    }
    
    [_resultsData removeAllObjects];
    [_resultsData addObjectsFromArray:tempResults];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //searchDisplayController自身有一个searchResultsTableView，所以在执行操作的时候首先要判断是否是搜索结果的tableView，如果是显示的就是搜索结果的数据，如果不是，则显示原始数据。
    
    if(tableView == mySearchDisplayController.searchResultsTableView)
    {
        tableView.frame = CGRectMake(0, 20, 320, kScreenHeight-20);
        //解决上面空出的20个像素
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        if (IOS7)
            //分割线的位置不带偏移
            tableView.separatorInset = UIEdgeInsetsZero;
        
        return _resultsData.count;
    }
    else
    {
        return _dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    if (tableView == mySearchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = _resultsData[indexPath.row];
    }
    else
    {
        CityMessage *citymess = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = citymess.CityName;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == mySearchDisplayController.searchResultsTableView)
    {
       // [self myAlertViewAccording:_resultsData[indexPath.row]];
        
        if ([self.delegate respondsToSelector:@selector(changeAdress:)]) {
            [self.delegate changeAdress:_resultsData[indexPath.row]];
        }
        
    }
    else
    {
      CityMessage *citymess = [_dataArray objectAtIndex:indexPath.row];
//        [self myAlertViewAccording:citymess.CityName];
        if ([self.delegate respondsToSelector:@selector(changeAdress:)]) {
            
            [self.delegate changeAdress:citymess.CityName];
        }

    }
    [self back];
}

-(void)myAlertViewAccording:(NSString *)content
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改地区" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark 数据请求
-(void)getAllData{
    NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
    loginParames[@"CityName"] = @"北";
    NSString *urlString =[YjlyRequest UrlParamer:@"AreaGuider" CmdName:@"Comment_AreaGuider" Parameter:loginParames];
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            
            [MBProgressHUD hideHUD];
            NSArray *diclist =(NSArray*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"返回的数据=%@",diclist);
            
            for (int i = 0; i< diclist.count; i++) {
               NSDictionary *dic =  [diclist objectAtIndex:i];
                CityMessage *cityMess = [[CityMessage alloc]init];
               cityMess.AreaNum =  [dic objectForKey:@"AreaNum"];
                cityMess.CityName =  [dic objectForKey:@"CityName"];

                cityMess.PNum =  [dic objectForKey:@"PNum"];
                [_dataArray addObject:cityMess];

            }
            [_tableView reloadData];
            
            
        }else
        {
            [MBProgressHUD hideHUD];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[jsonData objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alert show];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络请求错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        
//        [alert show];
    }];
    
    [engine enqueueOperation:op];
    
    
    
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
