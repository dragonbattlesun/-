//
//  NavViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/20.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "NavViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface NavViewController ()

@end

@implementation NavViewController
+(void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"ditu"] forBarMetrics:UIBarMetricsDefault];
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//设置状态栏颜色
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 20)];
    statusBarView.backgroundColor=WJColor(26, 113, 200);
    statusBarView.alpha = 0.3;
    [self.navigationBar addSubview:statusBarView];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,nil]];
  
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 能拦截所有push进来的子控制器
/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮

        
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"fanhui" highImage:@"fanhui"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"caidan" highImage:@"caidan"];
        
        
        
    }
    [super pushViewController:viewController animated:animated];
}
-(void)rightBtn{
   // if (self.childViewControllers.count == 1)return;
    [self popToViewController:[self.childViewControllers objectAtIndex:1 ] animated:YES];
}
/**
 *  返回上一个控制器
 */
- (void)back {
    if (self.childViewControllers.count == 1)return;
    [self popViewControllerAnimated:YES];
}
-(void)more{
    [self popToViewController:[self.childViewControllers objectAtIndex:1] animated:YES];

}
@end
