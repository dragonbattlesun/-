//
//  FlitViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "FlitViewController.h"

@interface FlitViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)UIButton *selectedBtn;
@property(nonatomic,weak)UIButton *selectedBtn2;

@end

@implementation FlitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = [NSArray arrayWithObjects:@"行程天数",@"出发时间",@"价格区间", nil];

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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"3天";
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(cell.frame.size.width-60, 5, 20, 20) ;
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    //button.backgroundColor = [UIColor redColor];
//   [button setImage:[UIImage imageNamed:@"meixing"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"xingxing2"] forState:UIControlStateSelected];
//
//    //[button setTitle:@"ddd" forState:UIControlStateNormal];
//    button.tag = 2000+indexPath.row;
//    [button addTarget:self action:@selector(btnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
//    
    
    
    
    
    UIImage *image= [ UIImage imageNamed:@"meixing" ];
    UIButton *button = [ UIButton buttonWithType:UIButtonTypeCustom ];
    CGRect frame = CGRectMake( 0.0 , 0.0 , image.size.width , image.size.height );
    button. frame = frame;
    [button setImage:[UIImage imageNamed:@"xingxing2"] forState:UIControlStateSelected];
       [button setImage:[UIImage imageNamed:@"meixing"] forState:UIControlStateNormal];

//    [button setBackgroundImage:image forState:UIControlStateNormal ];
    button. backgroundColor = [UIColor clearColor ];
    [button addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
   // [cell addSubview:button];
    //    cell.backgroundColor = WJColor(241, 241, 241);
    //
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    NSUInteger row = [indexPath row];
    //    cell.mainLabel.text= [self.list objectAtIndex:row];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)buttonPressedAction:(id)sender
{
    
        UIButton *button = (UIButton *)sender;
    self.selectedBtn2.selected = NO;
    button.selected = YES;
    self.selectedBtn2 = button;
        UITableViewCell *cell = (UITableViewCell *)[button superview];
       int row = [self.tableView indexPathForCell:cell].row;
    
    NSLog(@"----------88----%d",row);
}
//-(void)rank:(UIButton *)btn{
//    self.selectedBtn2.selected = NO;
//    btn.selected = YES;
//    self.selectedBtn2 = btn;
//    
//}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return 30;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.delegate respondsToSelector:@selector(hideFlitViewControll:)]) {
        [self.delegate hideFlitViewControll:indexPath ];
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--ddd--dd");
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
