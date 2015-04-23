//
//  DestinationViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)UIButton *selectedBtn;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = [NSArray arrayWithObjects:@"不限",@"国内",@"境外", nil];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/4*i, 0.5, kScreenWidth/4, 30);
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i + 1000;
        button.selected = NO;
        [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor]forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 29, kScreenWidth, 1)];
    line.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line];
    [self loadTableView];
    
}
-(void)doAction:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    switch (btn.tag) {
        case 1000:
        {
            
        }
            break;
        case 1001:
        {
            
        }
            break;
        case 1002:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)loadTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    
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
    cell.textLabel.text = @"埃及";
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
    if ([self.delegate respondsToSelector:@selector(hideDestinationViewControll:)]) {
        [self.delegate hideDestinationViewControll:indexPath ];
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
