//
//  RegisterViewController.m
//  YjlyUserSide
//
//  Created by yanjinglvyou on 15/3/22.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
@interface FindPasswordViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property (strong,nonatomic) MBProgressHUD *HUD;
@property(strong,nonatomic) UIAlertView *DialogBox;
@property (strong,nonatomic)  NSMutableDictionary *RegesterParamter;

@property (strong,nonatomic)  NSMutableDictionary *SendCodeParamter;
@property(strong,nonatomic) UIButton *doneInKeyboardButton;
@property(nonatomic,assign) NSInteger CheckStatus;

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _CheckStatus =0;
    _SendCodeParamter=[NSMutableDictionary dictionary];
    [_SendCodeParamter setValue:@"" forKey:@"Phone"];
    
    _RegesterParamter=[NSMutableDictionary dictionary];
    [_RegesterParamter setValue:@"" forKey:@"Phone"];
    [_RegesterParamter setValue:@"" forKey:@"UserPassword"];
    [_RegesterParamter setValue:@"1" forKey:@"Pid"];
    [_RegesterParamter setValue:@"" forKey:@"Code"];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageV.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageV];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 40)];
    lab.text = @"找回密码";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:lab];
    
    
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(20, 150, kScreenWidth-40, 150)];
    bjV.layer.cornerRadius  = 10;
    bjV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bjV];
    
    NSArray *arr = [NSArray arrayWithObjects:@"ic_login",@"yanzy.jpg",@"ic_login_password", nil];
    // NSArray *arr1 = [NSArray arrayWithObjects:@"",@"",@"", nil];
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20+(i*46), 20, 20)];
        imageV.image = [UIImage imageNamed:[arr objectAtIndex:i ]];
        [bjV addSubview:imageV];
        
    }
    
    for (int i = 0; i < 2; i ++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 49+i*49,  bjV.bounds.size.width-20, 1)];
        lineV.backgroundColor = WJColor(241, 241, 241);
        [bjV addSubview:lineV];
    }
    
    NSArray *arr2 = [NSArray arrayWithObjects:@"11位中国大陆手机号码",@"请输入短信验证码",@"密码，6-12位字母或数字", nil];
    
    for (int i = 0; i < 3; i ++) {
        
        UITextField *textf = [[UITextField alloc] initWithFrame:CGRectMake(40,20+(i*47), bjV.bounds.size.width-110, 25)];
        //textf.backgroundColor = [UIColor redColor];
        textf.placeholder = [arr2 objectAtIndex:i]; //默认显示的字
        [textf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        textf.secureTextEntry = NO; //密码类型
        textf = textf;
        textf.delegate = self;
        
        if (i<2) {
            if(i==0)
            {
                [textf addTarget:self action:@selector(MoblePhoneDidChange:) forControlEvents:UIControlEventEditingChanged];
            }
            textf.keyboardType=UIKeyboardTypeNumberPad;
            
            textf.leftViewMode=UITextFieldViewModeAlways;
            
        }else
        {
            textf.clearButtonMode = UITextFieldViewModeWhileEditing;
            textf.borderStyle = UITextBorderStyleNone;
            textf.autocorrectionType = UITextAutocorrectionTypeNo;
            textf.autocapitalizationType = UIKeyboardTypeNumbersAndPunctuation;
            textf.keyboardType = UIKeyboardTypeDefault;
            textf.returnKeyType = UIReturnKeyDone;
            textf.secureTextEntry = YES; //密码类型
        }
        
        //accountField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        textf.tag=1001+i;
        //accountField.keyboardAppearance = UIKeyboardAppearanceDefault;
        
        textf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [bjV addSubview:textf];
        
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(bjV.frame.size.width-90, 65, 80, 20);
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    button.titleLabel.font=[UIFont boldSystemFontOfSize:13];
    [button setTitleColor:WJColor(22, 108, 243) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [bjV addSubview:button];
    
    [button addTarget:self action:@selector(SendCodeMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *bj2 = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(bjV.frame), kScreenWidth-40, 200)];
    [self.view addSubview:bj2];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 20, bj2.bounds.size.width, 40);
    
    //[button2 setBackgroundImage:[UIImage imageNamed:@"yanseguixing"] forState:UIControlStateNormal];
    button2.backgroundColor = WJColor(23, 104, 242);
    button2.layer.cornerRadius = 5;
    [button2 setTitle:@"注册并登录" forState:UIControlStateNormal];
    button2.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(regiserLogin) forControlEvents:UIControlEventTouchUpInside];
    [bj2 addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(bj2.bounds.size.width -130, CGRectGetMaxY(button2.frame), 130, 40);
    
    //  [button3 setBackgroundImage:[UIImage imageNamed:@"yanseguixing"] forState:UIControlStateNormal];
    [button3 setTitle:@"已有账号？现在登录" forState:UIControlStateNormal];
    button3.titleLabel.font=[UIFont boldSystemFontOfSize:13];
    [button3 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [bj2 addSubview:button3];
    [button3 addTarget:self action:@selector(nowLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)SendCodeMessage{
    _CheckStatus=0;
    UITextField *textf = (UITextField *)[self.view viewWithTag:1001];
    
    _SendCodeParamter[@"Phone"]=textf.text ;
    NSString *sendCodeUrl=  [YjlyRequest UrlParamer:@"Register" CmdName:@"SendSms" Parameter:_SendCodeParamter];
    [self RegisterUrl:sendCodeUrl];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
-(void)regiserLogin{//注册并登录
    
    _CheckStatus=1;
    
    UITextField *textf1 = (UITextField *)[self.view viewWithTag:1001];
    
    UITextField *textf2 = (UITextField *)[self.view viewWithTag:1002];
    UITextField *textf3 = (UITextField *)[self.view viewWithTag:1003];
    
    _RegesterParamter[@"Phone"] = textf1.text  ;
    _RegesterParamter[@"Code"]= textf2.text;
    _RegesterParamter[@"UserPassword"] = textf3.text;
    NSString * loginURL=[YjlyRequest UrlParamer:@"Login" CmdName:@"GgPwd" Parameter:_RegesterParamter];
    [self RegisterUrl:loginURL];
    
}




/**
 *  获取导游信息
 *
 *  @param Url 导游信息api
 */
-(void)RegisterUrl:(NSString *)LoginUrl{

    if (_CheckStatus) {
        [MBProgressHUD showMessage:@"正在找回...."];
    }else
    {
        [MBProgressHUD showMessage:@"验证码发送中...."];
    }
    
 MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:LoginUrl params:nil httpMethod:@"post"];
    // [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [MBProgressHUD hideHUD];
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            if (_CheckStatus) {
                
                [UserDefaults setValue:[jsonData objectForKey:@"value"] forKey:@"guid" ];
                [UserDefaults synchronize];
                
                HomeViewController *home=[[HomeViewController alloc] init];
                [self.navigationController pushViewController:home animated:YES];
                self.view.userInteractionEnabled = YES;
            }
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];

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

-(void)nowLogin{
    LoginViewController *hwtabbar = [[LoginViewController alloc]init];
    [self.navigationController pushViewController: hwtabbar animated:YES];
    
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

-(void)MoblePhoneDidChange:(id)sender
{
    UITextField *_tf_MoblePhone=(UITextField*)sender;
    if (_tf_MoblePhone.text.length > 11) {
        _tf_MoblePhone.text = [_tf_MoblePhone.text substringToIndex:11];
    }
    
}


@end
