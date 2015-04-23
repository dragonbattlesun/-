//
//  TravelEditViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "TravelEditViewController.h"
#import "TravelGuidesViewController.h"
@interface TravelEditViewController ()<UITextFieldDelegate,UzysAssetsPickerControllerDelegate,UITextViewDelegate>

@property (strong, nonatomic)  UIImageView *imageView;

@property(nonatomic,strong) UITextField *GuideTitle;

@property(nonatomic,strong) UITextView * fastTextView ;

@property(nonatomic,strong) UIButton *AddImageButton;


@end

@implementation TravelEditViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_GuideTitle becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    
    _picList =[NSMutableDictionary dictionary];
    _Parameter =[NSMutableDictionary dictionary];
    self.navigationItem.title = @"旅游攻略";
    // Do any additional setup after loading the view.
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 30)];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:@"biaoti_03"];
    [self.view addSubview:imageV];

    _GuideTitle =[[UITextField alloc] initWithFrame:CGRectMake(3, 0, 150, 30)];
    [_GuideTitle setText:@"请输入攻略标题"];
    [_GuideTitle setTextColor:[UIColor lightGrayColor]];
    [_GuideTitle setAlpha:0.5];
    _GuideTitle.delegate =self;
    [_GuideTitle setFont:[UIFont systemFontOfSize:15 weight:20]];
    [_GuideTitle addTarget:self action:@selector(TitleDidChange:) forControlEvents:UIControlEventEditingChanged];
    [imageV addSubview:_GuideTitle];

#pragma  富文本编辑器 begin

    if (_fastTextView == nil) {
     
        _fastTextView= [[UITextView alloc] initWithFrame:CGRectMake(10, imageV.frame.origin.y+imageV.frame.size.height+10, kScreenWidth-20, 100)];
        _fastTextView.delegate=self;
        _fastTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _fastTextView.layer.borderWidth =1.0;
        _fastTextView.layer.cornerRadius =5.0;
        [self SetTextViewStyle:NO];
        [self.view addSubview:_fastTextView];
    }
    

    _AddImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _AddImageButton.frame = CGRectMake(10, CGRectGetMaxY(_fastTextView.frame )+30, 30, 30);
    [_AddImageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_AddImageButton setImage:[UIImage imageNamed:@"tianjia_03"] forState:UIControlStateNormal];
    _AddImageButton.titleLabel.font=[UIFont systemFontOfSize:13];
    
    [_AddImageButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_AddImageButton];
    
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth- 5, 30)]; //设置style
    toolBar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem * CancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancelPublish)]; //在toolBar上加上这些按钮
    
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil]; //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(resignKeyboard)]; //在toolBar上加上这些按钮
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:CancelButton,button2,doneButton,nil];
    [toolBar setItems:buttonsArray];

    [_GuideTitle  setInputAccessoryView:toolBar];
    [_fastTextView  setInputAccessoryView:toolBar];
    
}

-(void)resignKeyboard{
    
    [self.view endEditing:YES];
    
    [self DeliverInformation];
}


-(void)CancelPublish
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addPhoto{
    
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 4;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}

#pragma mark - image picker delegte
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if ([_picList count]>0) {
        
        [YjlyRequest DeleteImage:_picList];
        [_picList removeAllObjects];
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _picList=  [YjlyRequest writeAsset:assets toPath:documentPath];
    

    for (int index=0; index< [assets count];index++) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50*(index+1)+15*index, CGRectGetMaxY(_fastTextView.frame )+30, 60, 60)];
        _imageView.tag = 1001+index;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:_imageView action:@selector(pictureBecomeBig)];
        [_imageView addGestureRecognizer:tap];
        _imageView.userInteractionEnabled = YES;
        
        [self.view addSubview:_imageView];
        ALAsset *representation = [assets objectAtIndex:index];
        
        _imageView.image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                                  scale:representation.defaultRepresentation.scale
                                            orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        
    }
    
    [_GuideTitle resignFirstResponder];
}





#pragma 标题部分事件的函数 begin
-(void)TitleDidChange:(UITextField *)sender
{
    if ([sender.text isEqualToString:@"请输入攻略标题"]) {
        
        [_GuideTitle setText:@""];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self TitleSetStyle:YES];
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self TitleSetStyle:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self TitleSetStyle:NO];
}


-(void)TitleSetStyle:(BOOL)IsSelected
{
    if (IsSelected) {
        
        if ([_GuideTitle.text isEqualToString:@"请输入攻略标题"]) {
            [_GuideTitle setTextColor:[UIColor blackColor]];
            [_GuideTitle setText:@""];
        }
        
    }else
    {
        if ([_GuideTitle.text isEqualToString:@""]) {
            [_GuideTitle setTextColor:[UIColor lightGrayColor]];
            [_GuideTitle setText:@"请输入攻略标题"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma 标题部分事件的函数 end

#pragma 内容部分事件的函数 begin

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self SetTextViewStyle:YES];
    return  YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self SetTextViewStyle:NO];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"攻略长度小于130个字符"]) {
        
        [_fastTextView setText:@""];
    }
    if ([textView.text length] >130) {
        
        _fastTextView.text =[textView.text substringToIndex:130];
        [MBProgressHUD showError:@"攻略内容超入字符数限制" toView:_fastTextView];
    }
}

-(void)SetTextViewStyle:(BOOL)IsSelected
{
    if (IsSelected) {
        
        if ([_fastTextView.text isEqualToString:@"攻略长度小于130个字符"]) {
            [_fastTextView setTextColor:[UIColor blackColor]];
            [_fastTextView setText:@""];
        }
        
    }else
    {
        if ([_fastTextView.text isEqualToString:@""]) {
            [_fastTextView setTextColor:[UIColor lightGrayColor]];
            [_fastTextView setText:@"攻略长度小于130个字符"];
        }
    }
}


#pragma 内容部分事件的函数 end

-(void)DeliverInformation
{
   
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    [_Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"GuideID"];
    [_Parameter setValue:_GuideTitle.text forKey:@"Title"];
    [_Parameter setValue:_fastTextView.text forKey:@"Mark"];
    [_Parameter setValue:@"power" forKey:@"path"];
    NSString *AddDeliverURL=[YjlyRequest UrlParamer:@"PowerMain" CmdName:@"ADDPowerMain" Parameter:_Parameter];
    
//    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:AppHostName customHeaderFields:headerFields];
    
    MKNetworkEngine *engine = YJLY_MKNetWorkPort;
    MKNetworkOperation *operation=[engine operationWithPath:AddDeliverURL params:nil httpMethod:@"post"];
    
    
    for (NSString *key in  _picList) {
    
        [operation addFile:[_picList objectForKey:key] forKey:key];
        
         }
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD showSuccess:[jsonData objectForKey:@"value"]];
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        [MBProgressHUD hideHUD];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];        
    }];
    
    [engine enqueueOperation:operation];
    
    [operation onUploadProgressChanged:^(double progress) {
        
        NSLog(@"上传了 %f",progress);
    }];
}

@end
