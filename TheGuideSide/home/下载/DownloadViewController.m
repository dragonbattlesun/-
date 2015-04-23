//
//  DownloadViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//


#import "PNLineChartView.h"
#import "PNPlot.h"
#import "DownloadViewController.h"

@interface DownloadViewController ()
@property (strong, nonatomic)  PNLineChartView *lineChartView;
@property(strong,nonatomic)PNPlot *plot1;

@end

@implementation DownloadViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户收入";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addsecondpart];
    [self addformView];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40 )];
    bjV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjV];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 10, 200, 20)];
    lab.text = @"七天推广走势";
    lab.textColor =[UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:18  ];
    [bjV addSubview:lab];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 5, 20, 20);
    button.showsTouchWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"xiangzuo_03"] forState:UIControlStateNormal];
   
    [button addTarget:self action:@selector(rankleft) forControlEvents:UIControlEventTouchUpInside];
    [bjV addSubview:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth- 80, 5, 20, 20);
    [button2 setImage:[UIImage imageNamed:@"xiangyou_03"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(rankright) forControlEvents:UIControlEventTouchUpInside];
    button2.showsTouchWhenHighlighted = YES;
    [bjV addSubview:button2];

}
-(void)rankleft{
//    NSArray* plottingDataValues1 =@[@12, @63, @52, @53,@13, @52,@13, ];
//    PNPlot *plot1 = [[PNPlot alloc] init];
//    plot1.plottingValues = plottingDataValues1;
    
    NSArray* plottingDataValues1 =@[@13, @13, @13, @15,@13, @14,@14,];
    
    [self.view addSubview:self.lineChartView];
    self.plot1.plottingValues = plottingDataValues1;
    [self.lineChartView addPlot:self.plot1];

}
-(void)rankright{
    NSArray* plottingDataValues1 =@[@43, @53, @33, @55,@23, @44,@34,];
    
    [self.view addSubview:self.lineChartView];
    self.plot1.plottingValues = plottingDataValues1;
    [self.lineChartView addPlot:self.plot1];
}
-(void)addformView{
    // test line chart
    self.lineChartView  = [[PNLineChartView alloc]init];
    self.lineChartView.backgroundColor = [UIColor whiteColor];
    self.lineChartView.pointerInterval = 38;
    self.lineChartView.userInteractionEnabled = NO;
    NSArray* plottingDataValues1 =@[@22, @33, @12, @23,@43, @32,@53, ];
    NSArray* plottingDataValues2 =@[@24, @23, @22, @20,@53, @22,@33, ];
    
    self.lineChartView.max = 58;
    self.lineChartView.min = 12;
    
    self.lineChartView.frame  =CGRectMake(0, 30, kScreenWidth, 230);
    [self.view addSubview:self.lineChartView];

    
    
    UILabel *leixing = [[UILabel alloc]initWithFrame:CGRectMake(20, 260, 15, 15)];
    leixing.backgroundColor = [UIColor redColor];
    [self.view addSubview:leixing];
    UILabel *leixing2 = [[UILabel alloc]initWithFrame:CGRectMake(120, 260, 15, 15)];
    leixing2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:leixing2];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 260, 80, 15)];
    lab.text = @"无效";
    lab.textColor =[UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lab];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(140, 260, 80, 15)];
    lab2.text = @"有效";
    lab2.textColor =[UIColor grayColor];
    lab2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lab2];
    
    self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/5;
    
    NSMutableArray* yAxisValues = [@[] mutableCopy];
    for (int i=0; i<6; i++) {
        NSString* str = [NSString stringWithFormat:@"%.2f", self.lineChartView.min+self.lineChartView.interval*i];
        [yAxisValues addObject:str];
    }
    
    self.lineChartView.xAxisValues = @[@"1", @"2", @"3",@"4", @"5", @"6",@"7", ];
    self.lineChartView.yAxisValues = yAxisValues;
    self.lineChartView.axisLeftLineWidth = 39;
    
    
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = plottingDataValues1;
    
    plot1.lineColor = [UIColor blueColor];
    plot1.lineWidth = 0.5;
    self.plot1 =plot1;

    [self.lineChartView addPlot:plot1];
    
    
    PNPlot *plot2 = [[PNPlot alloc] init];
    
    plot2.plottingValues = plottingDataValues2;
    
    plot2.lineColor = [UIColor redColor];
    plot2.lineWidth = 1;
    
    [self.lineChartView  addPlot:plot2];
    
    
}
-(void)addsecondpart{
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2 , kScreenWidth, kScreenHeight/2)];
    bjV.backgroundColor = WJColor(251, 251, 251);
    [self.view addSubview:bjV];
   
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"有效 （123）",@"无效 （123）", nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"七天推广统计",@"规则说明", nil];
//    NSArray *arr3 = [NSArray arrayWithObjects:@"1:下载并安装",@"2:手机注册并验证", nil];

    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(50 , 120 , 150, 100)];
    lab3.text =@"1:  下载并安装 \r\n2:  手机注册并验证";
    lab3.backgroundColor = [UIColor clearColor];
    lab3.numberOfLines = 0;
    lab3.font = [UIFont systemFontOfSize:15];
    [bjV addSubview:lab3];
    

    for (int i = 0; i < 2 ; i ++) {
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10 +(100*i), 150, 30)];
        lab2.text = [arr2 objectAtIndex:i];
        lab2.textColor =[UIColor grayColor];
        lab2.font = [UIFont boldSystemFontOfSize:17];
        [bjV addSubview:lab2];
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(15, 110+(120*i), kScreenWidth-30, 1)];
       lineV.backgroundColor = WJColor(241, 241, 241);
//              lineV.backgroundColor = [UIColor redColor];

        [bjV addSubview:lineV];
        
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(50+(150*i), 50, 30, 30);
        button.tag = 1000+i;
//        [button setTitle:@"加加" forState:UIControlStateNormal];
      //  button.titleLabel.font=[UIFont systemFontOfSize:<#rect#>];
        if (i == 0) {
            [button setImage:[UIImage imageNamed:@"youxiao_03"] forState:UIControlStateNormal];

        }else{
            [button setImage:[UIImage imageNamed:@"wuxiao_03"] forState:UIControlStateNormal];
 
        }
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [bjV addSubview:button];//
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(40 +(150*i), 80, 100, 30)];
        lab.text =[arr objectAtIndex:i];
        lab.tag =1100+i;
        //lab.textColor =[UIColor <#lab#>];
        lab.font = [UIFont systemFontOfSize:14];
        [bjV addSubview:lab];
        
//        
//        UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(50 , 150+(20*i) , 100, 30)];
//        lab3.text =[arr3 objectAtIndex:i];
//        lab3.tag =1100+i;
//        //lab.textColor =[UIColor <#lab#>];
//        lab3.font = [UIFont systemFontOfSize:17];
//        [bjV addSubview:lab3];
        
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(50+(150*i), 50, 40, 40);
//        button.tag = 1000+i;
//        //[button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [button setTitle:[arr3 objectAtIndex:i] forState:UIControlStateNormal];
//        //  button.titleLabel.font=[UIFont systemFontOfSize:<#rect#>];
//        
//        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bjV addSubview:button];//


           }

    
}
-(void)doAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1000:
            
            break;
            
        case 1001:
            
            break;
            
        default:
            break;
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
