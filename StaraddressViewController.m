//
//  StaraddressViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "StaraddressViewController.h"

@interface StaraddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation StaraddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
          UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-10, 30)];
    lab.text = [NSString stringWithFormat:@"%@%@",@"您现在的位置：",@"北京"];
    //lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lab];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 29, kScreenWidth, 1)];
    line.backgroundColor = WJColor(47, 137, 225);
    [lab addSubview:line];

    [self loadTableView];
    
}
-(void)loadTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    // tableView.separatorColor = [UIColor clearColor];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    cell.textLabel.text = @"意大利";
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.highlightedTextColor = [UIColor blueColor];
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    NSUInteger row = [indexPath row];
    //    cell.mainLabel.text= [self.list objectAtIndex:row];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return 30;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(hideViewControll:)]) {
        [self.delegate hideViewControll:indexPath ];
    }
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
