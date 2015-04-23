//
//  ChangePWdViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/13.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "ChangePWdViewController.h"

@interface ChangePWdViewController ()
@property(nonatomic,strong) UITextField *accountField;

@end

@implementation ChangePWdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密码";
    
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/2-10, 30)];
    title.text = @"修改密码:";
    title.textAlignment  = NSTextAlignmentCenter;
    title.textColor =[UIColor blackColor];
    title.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:title];
    UITextField*  textField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2, 20.0f, kScreenWidth/2-10-10, 20.0f)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    //    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = @"修改密码"; //默认显示的字
    //[textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview: textField];
    self.accountField = textField;
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 50, kScreenWidth-40, 30);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = WJColor(13, 143, 244).CGColor ;
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(getAllData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

}
#pragma mark 数据请求
-(void)getAllData{
           //修改密码
        NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
        loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
        loginParames[@"NewPwd"] = self.accountField.text;
        NSString * urlString =[YjlyRequest UrlParamer:@"Login" CmdName:@"GPwd" Parameter:loginParames];
    
    
    
    
 MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
            NSMutableArray *list =(NSMutableArray*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"返回的数据=%@",[list objectAtIndex:0]);
            
            
            
            
            
            
        }else
        {
            [MBProgressHUD hideHUD];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[jsonData objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alert show];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络请求错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        
//        [alert show];
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
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
