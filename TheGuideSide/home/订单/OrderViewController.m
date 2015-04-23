//
//  OrderViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "OrderViewController.h"
#import "orderTableViewCell.h"

typedef enum {
    OrderViewControllerFirst,
    OrderViewControllerSecond,
    OrderViewControllerThird,
    OrderViewControllerForth
} OrderViewControllerType;

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,orderTableViewCellDelegate>
@property(strong ,nonatomic)UITableView *tableView;
@property (weak, nonatomic) UIButton *seletedBtn;
@property (weak, nonatomic) UIButton *seletedBtn2;
@property(nonatomic,assign) OrderViewControllerType type;
@property(nonatomic,weak)   UIView *titleView ;
@property(nonatomic,weak)   UIView *btnView ;
@property(nonatomic,strong) UIView *lineV;
@property(nonatomic,strong) UITableView *allTypeTB;
@property(nonatomic,strong) UITableView *orderStateTB;
@property(nonatomic,strong) NSArray *allTpyeArr;
@property(nonatomic,strong)  NSArray *orderStateArr;
@property(nonatomic,strong)  UIView *bjv;

@end

@implementation OrderViewController
-(UITableView *)allTypeTB{
    if (!_allTypeTB) {
        _allTypeTB = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.allTpyeArr.count*30)];
        _allTypeTB.delegate = self;
        _allTypeTB.dataSource = self;
        _allTypeTB.hidden = YES;
        _allTypeTB.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_allTypeTB];
    }
    return _allTypeTB;
}
-(UITableView *)orderStateTB{
    if (!_orderStateTB) {
        _orderStateTB = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth,self.orderStateArr.count*30)];
//        _orderStateTB.backgroundColor = [UIColor redColor];
        _orderStateTB.hidden = YES;
        _orderStateTB.delegate = self;
        _orderStateTB.dataSource = self;
//        _orderStateTB.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_orderStateTB];
        
    }
    return _orderStateTB;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}
//-(UIView *)bjv{
//    if (!_bjv) {
//            }
//    return _bjv;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.allTpyeArr = [NSArray arrayWithObjects:@"景点门票订单",@"导服订单",@"保险订单",@"签证订单",@"定制游订单",@"品质团游订单",@"邮轮订单",nil];
    self.orderStateArr = [NSArray arrayWithObjects:@"已支付",@"未支付",@"撤销订单",@"已完成",@"违约订单",nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addclassorder];
     [self addbuttton];
    [self loadTableView];
  
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100)];
    bjV.backgroundColor = [UIColor grayColor];
    bjV.alpha = 0.8;
    bjV.userInteractionEnabled = YES;
    bjV.hidden = YES;
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [bjV addGestureRecognizer:tapGr];
    [self.view addSubview:bjV];
    self.bjv = bjV;
    

}
-(void)viewTapped{
    self.allTypeTB.hidden = YES;
    self.orderStateTB.hidden = YES;
    self.bjv.hidden = YES;
}
-(void)addclassorder{
    NSArray *arr = [NSArray arrayWithObjects:@"全部类型",@"订单状态", nil];
    long count = arr.count;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, 2.5, 160, 25)];
//    bjV.backgroundColor = [UIColor grayColor];
    bjV.layer.borderColor = [WJColor(129, 129, 129) CGColor];
    bjV.layer.borderWidth = 1;
    bjV.layer.cornerRadius = 13;
    [self.view addSubview:bjV];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 20, 20)];
    imageV.image = [UIImage imageNamed:@"fangdajing_03"];
    [bjV addSubview:imageV];

    UITextField *searchTf = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 50, 5, 115, 20)];
    //searchTf.backgroundColor = [UIColor redColor];
    searchTf.borderStyle = UITextBorderStyleNone;
    searchTf.placeholder = @"输入类型和时间";
    searchTf.returnKeyType = UIReturnKeyGo;
    searchTf.delegate = self;
    [searchTf setValue:[UIFont boldSystemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];

    [self.view addSubview:searchTf];
    
    
    for (int i = 0; i < count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 0, 80, 30);
        if (i == 1) {
            button.frame = CGRectMake(kScreenWidth-85, 0, 80, 30);

        }
        button.imageView.contentMode = UIViewContentModeCenter;
        button.selected = NO;
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sanjiao_03"] forState:UIControlStateSelected];
        
        [button setImage:[UIImage imageNamed:@"sanjiao1_03"] forState:UIControlStateNormal];
        button .imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
        button .contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);

        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:WJColor(51, 149, 243) forState:UIControlStateSelected];
        button.selected = NO;
        [button addTarget:self action:@selector(divided:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"----d-d--d-%@",textField.text);
}


-(void)divided:(UIButton *)btn{
    self.seletedBtn2.selected = NO;
    btn.selected = YES;
    self.seletedBtn2 = btn;
    switch (btn.tag) { //全部类型
        case 100://
        {
            
                self.bjv.hidden = NO;
                self.orderStateTB.hidden = YES;
                self.allTypeTB.hidden = NO;
                [self.allTypeTB reloadData];
                btn.selected = YES;
 
                      
            
            

        }
            break;
        case 101://订单状态
        {
            self.bjv.hidden = NO;
            self.allTypeTB.hidden = YES;
            self.orderStateTB.hidden = NO;
            [self.orderStateTB reloadData];
        }
            break;
        default:
            break;
    }
    
}

-(void)addbuttton{
//    NSArray *arr = [NSArray arrayWithObjects:@"全部（23232）",@"已付（3额423）",@"未付（3434）",@"撤销（123）", nil];
//    long count = arr.count;

    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), kScreenWidth, 30)];
    btnView.backgroundColor = WJColor(241, 241, 241);
    self.btnView = btnView;
    


//    UIView*lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    lineV.backgroundColor = [UIColor redColor ];
//   // [self.btnView addSubview:lineV];
    
    [self.view addSubview:btnView];
    [self setBtnWithTitle:@"全部订单" type:OrderViewControllerFirst];
    [self setBtnWithTitle:@"近三个月" type:OrderViewControllerSecond];
    [self setBtnWithTitle:@"三个月前" type:OrderViewControllerThird];
//    [self setBtnWithTitle:@"撤销（23232）" type:OrderViewControllerForth];

    CGFloat btnH = btnView.height;
    CGFloat btnY = 0;
    CGFloat btnW = btnView.width /3;
    for (int i = 0; i<btnView.subviews.count; i++) {
        UIButton *btn = btnView.subviews[i];
        btn.frame = CGRectMake(i*btnW, btnY, btnW, btnH);
    }
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth/3, 2)];
    lineV.backgroundColor = WJColor(0, 144, 242);
    [btnView addSubview:lineV];
    self.lineV = lineV;
    
    UIView *firstLine = [[UIView alloc] init];
    [btnView addSubview:firstLine];
    firstLine.backgroundColor = WJColor(149, 149, 149);
    firstLine.frame = CGRectMake(0, 0, btnView.width, 0.5);
    
    UIView *secondLine = [[UIView alloc] init];
    [btnView addSubview:secondLine];
    secondLine.backgroundColor = WJColor(149, 149, 149);
    
    secondLine.frame = CGRectMake(0, btnView.height -0.5, btnView.width, 0.5);
//
//    
//    for (int i = 0; i<count; i++) {
//        
//    }
    
}

- (void)setBtnWithTitle:(NSString *)title type:(OrderViewControllerType)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
   // button.backgroundColor = WJColor(241, 241, 241);
    // [button setBackgroundImage:[UIImage imageNamed:@"buttonbj1"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [button setTitleColor:WJColor(0, 144, 242) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.tag = type;
    button.selected = NO;
    //button.titleLabel.textColor = [UIColor whiteColor];
    //button.backgroundColor = [UIColor orangeColor];
//    button.layer.borderColor = [[UIColor grayColor] CGColor];
//    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnView addSubview:button];
    if (type == OrderViewControllerFirst) {
        [self doAction:button];
    }

}

-(void)doAction:(UIButton *)btn{
    
    NSLog(@"%f",kScreenWidth);
      self.seletedBtn.selected = NO;
//    self.seletedBtn.layer.borderColor = [[UIColor grayColor] CGColor];
//    self.seletedBtn.backgroundColor= WJColor(241, 241, 241);
   // [self.seletedBtn setBackgroundImage:[UIImage imageNamed:@"buttonbj"] forState:UIControlStateSelected];
    btn.selected =YES;
//    btn.layer.borderColor = [[UIColor clearColor] CGColor];
//    btn.backgroundColor = [UIColor whiteColor];
    self.seletedBtn = btn;
        switch (btn.tag) {
        case OrderViewControllerFirst:  //全部
            {
                [self.tableView reloadData];
                [UIView animateWithDuration:0.5 animations:^{
                    self.lineV.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                }];
            }
            break;
        case OrderViewControllerSecond:  //近三月
            {
                [self.tableView reloadData];
                [UIView animateWithDuration:0.5 animations:^{
                    self.lineV.transform = CGAffineTransformMakeTranslation( self.lineV.width , 0);
                } completion:^(BOOL finished) {
                }];
            }
            
            break;
        case OrderViewControllerThird:  //三月前
            {
                [UIView animateWithDuration:0.5 animations:^{
                    self.lineV.transform = CGAffineTransformMakeTranslation( self.lineV.width*2 , 0);
                } completion:^(BOOL finished) {
                }];
                [self.tableView reloadData];
            }
            break;
           
                break;
 
    }
}
-(void)loadTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame)+40, kScreenWidth, kScreenHeight-135)];
    tableView.dataSource = self;
    tableView.delegate = self;
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
    if ([tableView isEqual:self.allTypeTB]) {
        return self.allTpyeArr.count;
    }else if ([tableView isEqual:self.orderStateTB]){
        return self.orderStateArr.count;
    }else{
        return 30;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([tableView isEqual:self.allTypeTB]) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [self.allTpyeArr objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;


    }else if ([tableView isEqual:self.orderStateTB]){
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        cell.textLabel.text = [self.orderStateArr objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;


    }else{
        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                    TableSampleIdentifier];
        if (cell == nil) {
            cell = [[orderTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:TableSampleIdentifier];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    
    
   
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    if ([tableView isEqual:self.allTypeTB]) {
        return 30;
    }else if ([tableView isEqual:self.orderStateTB]){
        return 30;

    }else{
        return 120;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.allTypeTB]) {
        self.allTypeTB.hidden = YES;
        self.bjv.hidden = YES;
    }else if ([tableView isEqual:self.orderStateTB]){
        self.orderStateTB.hidden = YES;
        self.bjv.hidden = YES;
    }else{
        
    }
}
#pragma mark orderTableViewCellDelegate
-(void)tableViewCell:(orderTableViewCell *)cell sancButton:(UIButton *)button{
    
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
