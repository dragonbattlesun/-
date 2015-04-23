//
//  SpaceEditViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/23.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import "UzysAssetsPickerController.h"
#import "UzysAssetsViewCell.h"
#import "UzysWrapperPickerController.h"
#import "UzysGroupPickerView.h"
#import "SpaceEditViewController.h"
#import "UIImageView+ImageZoom.h"
static int imageNum;

@interface SpaceEditViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UzysAssetsPickerControllerDelegate>
{
    BOOL isFullScreen;
    NSData *_imageData;

}

//@property(strong,nonatomic) DashedLineTextView *textView;
@property(nonatomic,strong) UITextView * textView2 ;
@property (nonatomic, copy) NSString *currentImageName;

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *label2;
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UIImageView *imageView2;

@property (strong, nonatomic)  UIImageView *imageView3;

@property (strong, nonatomic)  UIImageView *imageView4;

@property(nonatomic,weak)UITextField *textField;
@end

@implementation SpaceEditViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.textField.hidden  = YES;

    [self.textView2 becomeFirstResponder];
    
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageNum =0;
    self.navigationItem.title = @"我的空间";
    _Parameter=[NSMutableDictionary dictionary];
    _picList=[NSMutableDictionary dictionary];
    
    UITextView *contentTV = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 100)];
    [self.view addSubview:contentTV];
    self.textView2 = contentTV;
    self.textView2.tag = 1001;
    self.textView2.delegate = self;
    [_textView2 setFont:[UIFont systemFontOfSize:15]];
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    [_label2 setEnabled:NO];
    [_label2 setFont:[UIFont systemFontOfSize:15]];
    [_label2 setText:@"记录我的空间吧。。。"];
    [_label2 setTextColor:[UIColor lightGrayColor]];
    [self.textView2 addSubview:_label2];
    [self.view addSubview:self.textView2];
       UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)]; //设置    toolBar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil]; //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(resignKeyboard)]; //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [toolBar setItems:buttonsArray];
    [self.textView2 setInputAccessoryView:toolBar];
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, (120 * kScreenHeight/568), 30, 30);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"jiahao_03"] forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    

    _imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(250, 110, 60, 60)];
    _imageView4.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap4 = [[UITapGestureRecognizer alloc] initWithTarget:_imageView4 action:@selector(pictureBecomeBig)];
    [_imageView4 addGestureRecognizer:tap4];
    [self.view addSubview:_imageView4];
    _imageView4.tag = 1004;
//    [_imageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureBecomeBig:)]];
    _imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(185, 110, 60, 60)];
    _imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap3 = [[UITapGestureRecognizer alloc] initWithTarget:_imageView3 action:@selector(pictureBecomeBig)];
    [_imageView3 addGestureRecognizer:tap3];

    [self.view addSubview:_imageView3];
    _imageView3.tag = 1003;
//    [_imageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureBecomeBig:)]];
    
    
    _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 110, 60, 60)];
    [self.view addSubview:_imageView2];
    _imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap2 = [[UITapGestureRecognizer alloc] initWithTarget:_imageView2 action:@selector(pictureBecomeBig)];
    [_imageView2 addGestureRecognizer:tap2];

    _imageView2.tag = 1002;
//    [_imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureBecomeBig:)]];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(55, 110, 60, 60)];
    _imageView.tag = 1001;
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:_imageView action:@selector(pictureBecomeBig)];
    [_imageView addGestureRecognizer:tap];


    [self.view addSubview:_imageView];
//    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureBecomeBig:)]];
    
}

-(void)pictureBecomeBig:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    isFullScreen = !isFullScreen;

    
    switch (tap.view.tag) {
        case 1001:
        {
            [self.view bringSubviewToFront:self.imageView];
            
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (isFullScreen) {
                // 放大尺寸
                
                self.imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }
            else {
                // 缩小尺寸
                self.imageView.frame = CGRectMake(55, 110, 60, 60);
            }
            
            // commit动画
            [UIView commitAnimations];

            
        }
            break;
        case 1002:
        {
            [self.view bringSubviewToFront:self.imageView2];
            
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (isFullScreen) {
                // 放大尺寸
                
                self.imageView2.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }
            else {
                // 缩小尺寸
                self.imageView2.frame = CGRectMake(120, 110, 60, 60);
            }
            
            // commit动画
            [UIView commitAnimations];
 
        }
            break;

        case 1003:
        {
            [self.view bringSubviewToFront:self.imageView3];
            
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (isFullScreen) {
                // 放大尺寸
                
                self.imageView3.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }
            else {
                // 缩小尺寸
                self.imageView3.frame = CGRectMake(185, 110, 60, 60);
            }
            
            // commit动画
            [UIView commitAnimations];

        }
            break;

        case 1004:
        {
            [self.view bringSubviewToFront:self.imageView4];
            
            // 设置图片放大动画
            [UIView beginAnimations:nil context:nil];
            // 动画时间
            [UIView setAnimationDuration:1];
            
            if (isFullScreen) {
                // 放大尺寸
                
                self.imageView4.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }
            else {
                // 缩小尺寸
                self.imageView4.frame = CGRectMake(250, 110, 60, 60);
            }
            
            // commit动画
            [UIView commitAnimations];

        }
            break;

            
        default:
            break;
    }
    
   

}
-(void)addPhoto{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    
        picker.maximumNumberOfSelectionVideo = 0;
        picker.maximumNumberOfSelectionPhoto = 4;
    [self presentViewController:picker animated:YES completion:^{
        
    }];

}

- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if ([_picList count]>0) {
        
        [YjlyRequest DeleteImage:_picList];
    }
    
    [_picList removeAllObjects];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _picList=  [YjlyRequest writeAsset:assets toPath:documentPath];
    switch (assets.count) {
    case 1:
    {
    
        self.imageView.hidden = NO;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;
        self.imageView4.hidden = YES;
        ALAsset *representation = [assets objectAtIndex:0];
        
        self.imageView.image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                                  scale:representation.defaultRepresentation.scale
                                            orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        
    }
        break;
        
    case 2:
    {
        self.imageView.hidden = NO;
        self.imageView2.hidden = NO;
        
        self.imageView3.hidden = YES;
        self.imageView4.hidden = YES;
        ALAsset *representation = [assets objectAtIndex:0];
        self.imageView.image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                                  scale:representation.defaultRepresentation.scale
                                            orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        ALAsset *representation2 = [assets objectAtIndex:1];
        self.imageView2.image =[UIImage imageWithCGImage:representation2.defaultRepresentation.fullResolutionImage
                                                   scale:representation2.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation2.defaultRepresentation.orientation];
    }
        break;
    case 3:
    {    self.imageView.hidden = NO;
        self.imageView2.hidden = NO;
        self.imageView3.hidden = NO;
        
        self.imageView4.hidden = YES;
        ALAsset *representation = [assets objectAtIndex:0];
        self.imageView.image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                                  scale:representation.defaultRepresentation.scale
                                            orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        ALAsset *representation2 = [assets objectAtIndex:1];
        self.imageView2.image =[UIImage imageWithCGImage:representation2.defaultRepresentation.fullResolutionImage
                                                   scale:representation2.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation2.defaultRepresentation.orientation];
        ALAsset *representation3 = [assets objectAtIndex:2];
        self.imageView3.image =[UIImage imageWithCGImage:representation3.defaultRepresentation.fullResolutionImage
                                                   scale:representation3.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation3.defaultRepresentation.orientation];
    }
        break;
        
        
    case 4:
    {
        self.imageView.hidden = NO;
        self.imageView2.hidden = NO;
        self.imageView3.hidden = NO;
        self.imageView4.hidden = NO;
        
        ALAsset *representation = [assets objectAtIndex:0];
        
        self.imageView .image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                                   scale:representation.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        ALAsset *representation2 = [assets objectAtIndex:1];
        self.imageView2.image =[UIImage imageWithCGImage:representation2.defaultRepresentation.fullResolutionImage
                                                   scale:representation2.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation2.defaultRepresentation.orientation];
        ALAsset *representation3 = [assets objectAtIndex:2];
        self.imageView3.image =[UIImage imageWithCGImage:representation3.defaultRepresentation.fullResolutionImage
                                                   scale:representation3.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation3.defaultRepresentation.orientation];
        ALAsset *representation4 = [assets objectAtIndex:3];
        self.imageView4 .image =[UIImage imageWithCGImage:representation4.defaultRepresentation.fullResolutionImage
                                                    scale:representation4.defaultRepresentation.scale
                                              orientation:(UIImageOrientation)representation4.defaultRepresentation.orientation];
    }
        break;
        
    default:
        break;
}
}

//隐藏键盘
- (void)resignKeyboard {
    
    [self.textView2 resignFirstResponder];
    [self.textField resignFirstResponder];
    
    [self DeliverInformation];
    
}
- (void) textViewDidChange:(UITextView *)textView{
    self.textField.hidden  = YES;

    switch (textView.tag) {
        case 1000:
        {
            if ([textView.text length] == 0) {
                [self.label setHidden:NO];
            }else{
                [self.label setHidden:YES];
                
            }
        }
            break;
        case 1001:
        {
            if ([textView.text length] == 0) {
                [self.label2 setHidden:NO];
            }else{
                [self.label2 setHidden:YES];
                
            }
        }
            
        default:
            break;
    }
    
    
    NSInteger number = [textView.text length];
    if (number > 128) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于128" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:128];
        number = 128;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------------------------ 随机生成照片名称
- (NSString *)creatImageName {
    
    _currentImageName = nil;
    for (int i = 0; i < 32; i++) {
        int j = arc4random()%16;
        if (_currentImageName.length == 0) {
            _currentImageName = [NSString stringWithFormat:@"%x",j];
        }else {
            if (i == 7 || i == 11 || i == 15 || i == 19) {
                _currentImageName = [NSString stringWithFormat:@"%@%x-",_currentImageName,j];
            }else {
                _currentImageName = [NSString stringWithFormat:@"%@%x",_currentImageName,j];
            }
        }
    }
    _currentImageName = [NSString stringWithFormat:@"%@_YDBS",_currentImageName];
    
    _currentImageName = [_currentImageName uppercaseString];
    return _currentImageName;
    
}



-(void)DeliverInformation
{
    
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    [_Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
    [_Parameter setValue:self.textView2.text forKey:@"Content"];
    [_Parameter setValue:@"1" forKey:@"Path"];
    NSString *AddDeliverURL=[YjlyRequest UrlParamer:@"Zone" CmdName:@"AddDXinQ" Parameter:_Parameter];
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:AppHostName customHeaderFields:headerFields];
    
   
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
            [YjlyRequest DeleteImage:_picList];
            [YJLYNOTIFICATION postNotificationName:@"spaceEditSuccess" object:nil];
            
            
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
        [MBProgressHUD hideHUD];
       
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];        
    }];
    
    [engine enqueueOperation:operation];
    
    
}

@end
