//
//  AppointDetailViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "AppointDetailViewController.h"
#import "AppointDetailTableViewCell.h"
#import "AppointDetail.h"
@interface AppointDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *allArr;
@property(nonatomic,strong) NSArray *orderdetailArr;
@property(nonatomic,strong) NSArray *accountArr;
@property(nonatomic,strong) UIScrollView *bjScro;

@end

@implementation AppointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bjScro.contentSize = CGSizeMake(kScreenWidth, 1000);
    self.bjScro = bjScro;
    [self.view addSubview:bjScro];
    
self.navigationItem.title = @"我的预约";
    self.view.backgroundColor = WJColor(239, 239, 244);
    NSArray *arr1 = [NSArray arrayWithObjects:@"订单详情", nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"开始日期",@"服务天数",@"联系人电话",@"特殊要求", nil];
    NSArray *arr3 = [NSArray arrayWithObjects:@"结算信息", nil];
    NSArray *arr4 = [NSArray arrayWithObjects:@"总费用",@"每天",@"代金券",@"需支付",@"发票信",@"打赏小费", nil];
    NSArray *arr5 = [NSArray arrayWithObjects:@"分成（其他信息）", nil];
    NSArray *arr6 = [NSArray arrayWithObjects:@"添加消息",@"添加消息", nil];
    NSMutableArray *allArr = [NSMutableArray arrayWithCapacity:0];
    [allArr addObject:arr1];
    [allArr addObject:arr2];
    [allArr addObject:arr3];
    [allArr addObject:arr4];
    [allArr addObject:arr5];
    [allArr addObject:arr6];
    self.allArr =allArr;
    
   self.orderdetailArr = [NSArray arrayWithObjects:@"02月13日",@"2天",@"1323333",@"无", nil];
    self.accountArr = [NSArray arrayWithObjects:@"$1999",@"￥999",@"223333",@"无",@"无",@"10元",nil];

//    AppointDetail *appoint  =[[AppointDetail alloc]init];
//      appoint.title =@"我的预约";
//    appoint.content = @"";
    [self loadTableView];
    
   }
-(void)reciveAppoint{
    
}
-(void)loadTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 880) style:UITableViewStyleGrouped];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.scrollEnabled = NO;
    tableView.showsVerticalScrollIndicator = NO;
   // tableView.separatorColor = [UIColor clearColor];
    [self.bjScro addSubview:tableView];
    self.tableView = tableView;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, CGRectGetMaxY(tableView.frame), kScreenWidth-40, 30);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    //    button.layer.borderWidth = 0;
    button.layer.cornerRadius = 10;
    //[button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"接受预约" forState:UIControlStateNormal];
     button.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self.bjScro addSubview:button];
    [button addTarget:self action:@selector(reciveAppoint) forControlEvents:UIControlEventTouchUpInside];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 30;
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 6;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //AppointDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
    //                                  TableSampleIdentifier];
    //AppointDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    AppointDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (cell == nil) {
        cell = [[AppointDetailTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

           // [cell setData:<#(AppointDetail *)#>];
            break;
        case 1:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                        cell.lab2.text = [self.orderdetailArr objectAtIndex:indexPath.row];
            cell.lab2.textColor = [UIColor grayColor];

            break;
        case 2:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

            
            break;
        case 3:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    cell.lab2.text = [self.accountArr objectAtIndex:indexPath.row];

            cell.textLabel.textColor = [UIColor grayColor];

            break;
        case 4:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

            break;
        case 5:
            cell.lab1.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
           // cell.lab2.text = [[self.allArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

            cell.textLabel.textColor = [UIColor grayColor];

            break;
            
        default:
            break;
    }
    //    cell.backgroundColor = WJColor(241, 241, 241);
    //
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    NSUInteger row = [indexPath row];
    //    cell.mainLabel.text= [self.list objectAtIndex:row];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
    
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

@end
