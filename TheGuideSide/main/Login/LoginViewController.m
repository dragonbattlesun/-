//
//  LoginViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/24.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //初始化nsuserDefaults
    _UserDefaults =[NSUserDefaults standardUserDefaults];
    //初始化预加载视图
    _HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    self.navigationController.navigationBarHidden = YES;
    self.Home =[[HomeViewController alloc]init];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageV.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageV];
    //初始化 loginimageview
    _loginImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_loginImageView setImage:[UIImage imageNamed:@"ic_login"]];
    _loginLeftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [_loginLeftView addSubview:_loginImageView];
    //初始化 _PwdImageView
    _PwdImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_PwdImageView setImage:[UIImage imageNamed:@"ic_login_password"]];
    _PwdLeftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [_PwdLeftView addSubview:_PwdImageView];
    [self addlogin];
    
}


-(void)addlogin{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 40)];
    lab.text = @"登  录";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:lab];
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(20, 150, kScreenWidth-40, 80)];
    bjV.layer.cornerRadius  = 10;
    bjV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjV];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(40, 190, kScreenWidth-80, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    _tf_MoblePhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, bjV.bounds.size.width-20, 40)];
    _tf_MoblePhone.placeholder = @"11位手机号"; //默认显示的字
    _tf_MoblePhone.secureTextEntry = NO; //密码类型
    _tf_MoblePhone.delegate = self;
    _tf_MoblePhone.keyboardType=UIKeyboardTypeNumberPad;
    _tf_MoblePhone.leftView=_loginLeftView;
    _tf_MoblePhone.leftViewMode=UITextFieldViewModeAlways;
    _tf_MoblePhone.tag=1001;
    [bjV addSubview:_tf_MoblePhone];
    
    _tf_UserPwd = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, bjV.bounds.size.width-80, 40)];
    _tf_UserPwd.borderStyle = UITextBorderStyleNone;
    _tf_UserPwd.tag=1002;
    _tf_UserPwd.delegate = self;
    _tf_UserPwd.placeholder = @"密码"; //默认显示的字
    _tf_UserPwd.secureTextEntry = YES; //密码类型
    _tf_UserPwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _tf_UserPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _tf_UserPwd.returnKeyType = UIReturnKeyDone;
    _tf_UserPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tf_UserPwd.leftView=_PwdLeftView;
    _tf_UserPwd.leftViewMode=UITextFieldViewModeAlways;
    [bjV addSubview:_tf_UserPwd];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 270, kScreenWidth-40, 40);
    button.layer.cornerRadius =10;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.backgroundColor = WJColor(23, 104, 242);
    
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(20, 320, kScreenWidth-40, 40);
    [button2 setBackgroundImage:[UIImage imageNamed:@"xinxing"] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:18];
    [button2 setTitle:@"注册" forState:UIControlStateNormal];
    
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(registered:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(kScreenWidth -120, 250, 100, 2);
    // [button3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button3 setTitle:@"找回密码" forState:UIControlStateNormal];
    button3.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [button3 addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}


- (NSString *)createPostURL:(NSMutableDictionary *)params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

-(void)login:(UIButton *)btn{
    
    [self finishAction];
    NSMutableDictionary *loginParames=[NSMutableDictionary dictionary];
    loginParames[@"Phone"] = _tf_MoblePhone.text;
    loginParames[@"Password"] = _tf_UserPwd.text;
    
    
    NSMutableDictionary *bodyRequestDic = [NSMutableDictionary dictionary];
    bodyRequestDic[@"cmd"] = @"DLogin";
    bodyRequestDic[@"param"] = [YjlyRequest param:loginParames];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", @"/S_AJAX/Login.ashx", [self createPostURL:bodyRequestDic]];
    //对url进行utf8编码
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self LoginURL:urlString];
}


/**
 *  登陆的方法
 *
 *  @param Url 登陆的api
 */
-(void)LoginURL:(NSString*)Url{
    [self.navigationController.view addSubview:_HUD];
    _HUD.delegate=self;
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:DomainURL customHeaderFields:nil];
    
    MKNetworkOperation *op = [engine operationWithPath:Url params:nil httpMethod:@"post"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [_UserDefaults setValue:[jsonData objectForKey:@"value"] forKey:_tf_MoblePhone.text ];
            [_HUD setHidden:YES];
            self.Home.MoblePhone=_tf_MoblePhone.text;
            [self.navigationController pushViewController:self.Home animated:YES];
            self.Home.navigationItem.title = @"我的主页";
            self.view.userInteractionEnabled = YES;
            
        }else
        {
            [_HUD setHidden:YES];
            _DialogBox = [[UIAlertView alloc] initWithTitle:@"" message:[jsonData objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [_DialogBox show];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [_HUD setHidden:YES];
        
        _DialogBox = [[UIAlertView alloc] initWithTitle:@"" message:@"网络请求错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [_DialogBox show];
    }];
    
    [engine enqueueOperation:op];
    
}


/**
 *  隐藏预加载的视图
 *  MBProgressHUD 方法委托的实现
 *
 *  @param hud 视图
 */
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [_HUD removeFromSuperview];
    _HUD = nil;
}

-(void)chaoshi{
    //   if (SVPDISMISS==NO) {
    //        [SVProgressHUD showErrorWithStatus:@"网络连接超时！" duration:3];
    //        [KGStatusBar showErrorWithStatus:@"网络异常"];
    //    }
    [MBProgressHUD hideHUD];
}

-(void)forget{
    FindPasswordViewController *reg = [[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1001) {
        
        _loginImageView.image = [UIImage imageNamed:@"ic_login_highlighted"];
        
        
    }else if(textField.tag == 1002)
    {
        _PwdImageView.image = [UIImage imageNamed:@"ic_login_password_highlighted"];
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1001) {
        
        _loginImageView.image = [UIImage imageNamed:@"ic_login"];
        
        
    }else if(textField.tag == 1002)
    {
        _PwdImageView.image = [UIImage imageNamed:@"ic_login_password"];
    }
}
-(void)registered:(UIButton *)btn{
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //    if (self.request) {
    //        [self.request clearDelegatesAndCancel];
    //    }
}



#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (_doneInKeyboardButton.superview)
    {
        [_doneInKeyboardButton removeFromSuperview];
    }
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    if (_doneInKeyboardButton == nil)
    {
        _doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        if(screenHeight==568.0f){//爱疯5
            _doneInKeyboardButton.frame = CGRectMake(0, 568 - 53, 106, 53);
        }else{//3.5寸
            _doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        }
        
        _doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        //图片直接抠腾讯财付通里面的= =!
        [_doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
        [_doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
        [_doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    if (_doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:_doneInKeyboardButton];    // 注意这里直接加到window上
    }
    
}

-(void)finishAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}


@end

