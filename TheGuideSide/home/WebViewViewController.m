//
//  WebViewViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/29.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@property (nonatomic,strong) UIWebView  *webView;

@end

@implementation WebViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title= @"";
    [MBProgressHUD showMessage:@"正在请求..."];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight-100)];
    //_webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"_VisiteUrl %@",self.tempUrl);
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.tempUrl]];
    
    [_webView loadRequest:request];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scalesPageToFit =YES;
    [self.view addSubview:_webView];
    
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-100, kScreenWidth, 40)];
    
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setBackgroundColor:yjlyseleted];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

/*
 * 点击事件
 * 调用javaScript的方法postStr()并取得返回值
 * 输出返回值到控制台
 */
-(void)doAction:(UIButton *)sender
{
    
    NSString *jsScript=[NSString stringWithFormat:@" GetID(\"%@\");",[UserDefaults objectForKey:@"guid"]];
    
    NSString *ReturnValue= [_webView stringByEvaluatingJavaScriptFromString:jsScript];
    
    NSLog(@" ReturnValue  %@",ReturnValue);
    
    if ([ReturnValue isEqualToString:@"YES"]) {
        
        [MBProgressHUD showSuccess:@"线路推荐信息添加成功....."];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
        [MBProgressHUD showMessage:ReturnValue];
    }
    sleep(2);
    [MBProgressHUD hideHUD];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    NSString * str = [[request URL] absoluteString];
    //    NSString *urlStr = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSArray * strArray = [urlStr componentsSeparatedByString:@":"];
    //    if([strArray count]>2)
    //    {
    //        NSLog(@"webview for %@",urlStr);
    //        if ([[strArray objectAtIndex:0] isEqualToString:@"jscall"] ) {
    //            //这里拦截做些本地的事情
    //        }
    //        return NO;
    //    }else{
    //        return YES;
    //    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    
    [MBProgressHUD hideHUD];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     "var field = GetID();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    
    if (!_isFirstLoadWeb) {
        
        _isFirstLoadWeb =YES;
    }else
    {
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"GetID(%@);",[UserDefaults objectForKey:@"guid"]]];
        //执行js文件
    }
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    
    NSLog(@"error %@",[error description]);
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
