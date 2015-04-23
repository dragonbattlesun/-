//
//  MyDetailViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/22.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "MyDetailViewController.h"
@interface MyDetailViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UITextField *accountField ;

@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
  self.titleString = [[self.titleString componentsSeparatedByString:@":"] objectAtIndex:0];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/2, 30)];
    title.text = [NSString stringWithFormat:@"%@:",self.titleString];
    title.textColor =[UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:title];
   
    
    UITextField*  textField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth/2, 10.0f, kScreenWidth/2-10-10, 30.0f)];
    [textField setBorderStyle:UITextBorderStyleLine]; //外框类型
//    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = self.titleString; //默认显示的字
    //[textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
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
#pragma mark 修改资料
-(void)getAllData{
    
    //修改导游资料
    NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
    loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
    loginParames[@"Value"] = self.accountField.text;
    
    switch (self.row) {
        case 1:{
            loginParames[@"Key"] = @"TrueName";
 
        }
            
            break;
        case 2:{
            loginParames[@"Key"] = @"Certificates";

        }
            
            break;
            
            
        case 3:{
            loginParames[@"Key"] = @"Langage";

        }
            
            break;
        case 4:{
            loginParames[@"Key"] = @"Area";

        }
            
            break;
        case 5:{
            loginParames[@"Key"] = @"Gendel";

        }
            
            break;
        case 6:{
            loginParames[@"Key"] = @"Number";

        }
            
            break;
        case 7:{
            loginParames[@"Key"] = @"Phone";

        }
            
            break;
        case 8:{
            loginParames[@"Key"] = @"Birthday";

        }
            
            break;
        case 9:{
            loginParames[@"Key"] = @"Adress";

        }
            
            break;
        case 11:{
            loginParames[@"Key"] = @"Personsign";

        }
            
            break;
        case 12:{
            loginParames[@"Key"] = @"GuderMoney";

        }
            
            break;
        case 13:{
            loginParames[@"Key"] = @"";

        }
            
            break;
//        case 13:{
//            loginParames[@"Key"] = @"";
//
//        }
//            
//            break;
//        case 14:{
//            loginParames[@"Key"] = @"";
//
//        }
            
            break;
        case 15:{
//            loginParames[@"Key"] = self.accountField.placeholder;

        }
            
            break;
        case 16:{
//            loginParames[@"Key"] = self.accountField.placeholder;

        }
            
            break;
            
            
        default:
            break;
    }
    
   
    
       NSString * urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];
    
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
//            NSMutableArray *list =(NSMutableArray*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
//            NSLog(@"返回的数据=%@",jsonData);
            
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:@"温馨提示" message:@"资料修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
            
            
            
        }else
        {
            [MBProgressHUD hideHUD];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[jsonData objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alert show];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
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
