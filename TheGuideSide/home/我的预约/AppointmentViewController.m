//
//  AppointmentViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//


#import "AppointDetailViewController.h"
#import "AppointmentViewController.h"
#import "AppointmentTableViewCell.h"
@interface AppointmentViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation AppointmentViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  20 )];
    bjV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjV];
   
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 10)];
    lab.text = @"   导服订单（6）";
    lab.textColor =[UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:15];
    [bjV addSubview:lab];
    UIView *bjV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 9, kScreenWidth, 1)];
    bjV2.backgroundColor = WJColor(241, 241, 241);
  //  [lab addSubview:bjV2];
    
    [self loadTableView];

}

-(void)loadTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, kScreenWidth, kScreenHeight-64-30) style:UITableViewStylePlain];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor =WJColor(241, 241, 241);
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
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
    AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                TableSampleIdentifier];
    if (cell == nil) {
        cell = [[AppointmentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
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
    
    return 105;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointDetailViewController *appde = [[AppointDetailViewController alloc]init];
    [self.navigationController pushViewController:appde animated:YES];
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
