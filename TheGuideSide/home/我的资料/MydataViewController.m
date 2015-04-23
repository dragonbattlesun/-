//
//  MydataViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import "UzysAssetsPickerController.h"
#import "UzysAssetsViewCell.h"
#import "UzysWrapperPickerController.h"
#import "UzysGroupPickerView.h"
#import "UIImage+Graphics.h"
#import "LoginViewController.h"
#import "MydataViewController.h"
#import "CWStarRateView.h"
#import "MyDetailViewController.h"
#import "BJImageCropper.h"
#import "ChangePWdViewController.h"
#import "SuggestionViewController.h"
#import "QRcodeViewController.h"
#import "UMFeedback.h"
#import "ZSYPopoverListView.h"
#import "Language.h"
#import "ProtaitChangeViewController.h"
#import "UITextField+TimePiker.h"
#import "DressSearchViewController.h"
#import "ActionSheetDatePicker.h"

@interface MydataViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UzysAssetsPickerControllerDelegate,ZSYPopoverListDatasource, ZSYPopoverListDelegate,UIAlertViewDelegate,DressSearchViewControllerDelegate>
{
    BJImageCropper *imageCropper;
    UIView *cropview;
    NSInteger tapedIndex;
    int  TagForPopover ;
    UITextField *birthTf;

}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) CWStarRateView *starRateView;
@property(nonatomic,strong) UIImageView *headimageV;
@property(nonatomic,strong) NSMutableDictionary *picList;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) NSMutableArray *contentArr;
@property(nonatomic,strong) NSString *QRcode;
@property(nonatomic,strong) NSString *imageUrlStr;
@property(nonatomic,strong) NSString *zhuyebeijingImage;
@property(nonatomic,strong) ZSYPopoverListView *listView;
@property(nonatomic,strong) ZSYPopoverListView *genderView;
@property(nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSIndexPath *grendIndexPath;
@property(nonatomic,strong) NSMutableArray *grendArr;

@property(nonatomic,strong) NSMutableArray *languageArr;
@property(nonatomic,strong) UIImage *headimage;
@property(nonatomic,strong) NSString *dateString;
@property(nonatomic,strong) UIView *pickerView;

@end

@implementation MydataViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"Guid"] = [UserDefaults objectForKey:@"guid"];
    NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Guid" CmdName:@"GuidModel" Parameter:dic];
    [self LoadMyData:MySpaceUrl ifChangeHead:nil];
}
#pragma mark UIDatePicker
-(void)datePickerValueChanged:(UIDatePicker *)datepicker{
    //datepicker.calendar;
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    //    [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    
   self.dateString = [pickerFormatter stringFromDate:datepicker.date];
    NSLog(@"datepicker====%@",self.dateString);
    
}

//-(void)pickerfinish{
//    self.pickerView.hidden = YES;
//    tapedIndex = 8;
//    [self ChangeAllData:self.dateString];
//}
-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [element setText:[dateFormatter stringFromDate:selectedTime]];
      tapedIndex = 8;
    
    [self ChangeAllData:[dateFormatter stringFromDate:selectedTime]];
    NSLog(@"--[dateFormatter stringFromDate:selectedTime]---%@",[dateFormatter stringFromDate:selectedTime]);
}

-(void)addDatePicker{
    
//    self.pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
//    self.pickerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.pickerView];
//    
//    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, -40, kScreenWidth, 40)];
//    bjV.backgroundColor = WJColor(246, 246, 246);
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(bjV.frame.size.width - 60 , 0, 60, 40);
//    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    
//    [button1 setTitle:@"完成" forState:UIControlStateNormal];
//    button1.titleLabel.font=[UIFont boldSystemFontOfSize:14];
//    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    
//    [button1 addTarget:self action:@selector(pickerfinish) forControlEvents:UIControlEventTouchUpInside];
//    [bjV addSubview:button1];
//    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
//    self.pickerView.hidden = YES;
//    //    datePicker.backgroundColor = [UIColor grayColor];
//    // 设置时区
//    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    // 设置当前显示时间
//    //               [datePicker setDate:tempDate animated:YES];
//    // 设置显示最大时间（此处为当前时间）
//    [datePicker setMaximumDate:[NSDate date]];
//    // 设置UIDatePicker的显示模式
//    [datePicker setDatePickerMode:UIDatePickerModeDate];
//    // 设置区域为中国简体中文
//    
//    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    
//    // 当值发生改变的时候调用的方法
//    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.pickerView addSubview:datePicker];
//    [datePicker addSubview:bjV];
//    self.datePicker = datePicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    self.navigationController.navigationBarHidden = NO;
    [self loadTableView];
    self.listView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.listView.titleName.text = @"选择";
    self.listView.datasource = self;
    self.listView.delegate = self;
    
    self.genderView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    self.genderView.titleName.text = @"选择";
    self.genderView.datasource = self;
    self.genderView.delegate = self;
    self.grendArr = [NSMutableArray arrayWithObjects:@"男",@"女", nil];

    self.languageArr = [NSMutableArray arrayWithCapacity:0];
    [self getAllDataAboutLanguage];
//    self.titleArray = [NSMutableArray arrayWithCapacity:0];
//    self.titleArray = [NSArray arrayWithObjects:@"",@"真实姓名:",@"导游证件:",@"语种:",@"地区:",@"性别:",@"证件号:",@"手机号:",@"出生日期:",@"地址:",@"个性签名:",@"导服费:",@"我的二维码:",@"意见反馈：",@"我的星级：", @"修改密码：",@"",nil];

    _picList = [NSMutableDictionary dictionary];
    _MySpaceDataSource =[[NSMutableArray alloc] init];
    
    _MyDataParameter =[NSMutableDictionary dictionary];
    
    [self addDatePicker];

    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)loadTableView{
    
    UIScrollView *sco = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64)];
    sco.contentSize = CGSizeMake(kScreenWidth, 800);
    sco.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:sco];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.scrollEnabled = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
        if (indexPath.row == 0) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 80, 80)];
//        imageV.image = self.headimageV.image;
            imageV.layer.masksToBounds  = YES;
            imageV.layer.cornerRadius = 40.0;
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,self.imageUrlStr]] placeholderImage:[UIImage imageNamed:@"wodezhuy"]];

        [cell.contentView addSubview:imageV];
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changPhtoto)];
        [imageV addGestureRecognizer:tap];
       self.headimageV= imageV;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth- 100, 40, 50, 20)];
        lab.text = @"头像";
        lab.textColor =[UIColor grayColor];
        lab.font = [UIFont systemFontOfSize:14  ];
        [cell.contentView addSubview:lab];
        
        
        
           }else
        if (indexPath.row == 17 ){
//     cell.backgroundColor = [UIColor redColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth-20, 60)];
        label.text = @"提示： 您的资料将作为审核的唯一凭证，请您完整如实填写，避免资料不实带来的不便。";
        label.textColor =[UIColor grayColor];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentView addSubview:label];
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(15, 80, kScreenWidth-30, 30);
        button.layer.borderColor = [[UIColor redColor] CGColor];
        button.layer.cornerRadius = 15;
        button.layer.borderWidth = 0.5;
        // [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitle:@"注销登录" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancellation) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }else
        if (indexPath.row ==15) {
            //星星
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.text = @"我的星级：";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            NSString *starnum = [self.titleArray objectAtIndex:indexPath.row];
            self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(90, 15, 60, 10) numberOfStars:5 imageName:@"xingxing4_03"];
            self.starRateView.scorePercent = [starnum floatValue]/5;
            self.starRateView.allowIncompleteStar = YES;
            // self.starRateView.hasAnimation = YES;
            [cell addSubview:self.starRateView];

        }else{
            NSLog(@"%@",[self.titleArray objectAtIndex:indexPath.row]);
            cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        
    if (indexPath.row!=0&&indexPath.row!=17) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    if (indexPath.row == 0 && indexPath.row == 15) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
   
 

   
    return cell;
}
-(void)changPhtoto{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 1;
    [self presentViewController:picker animated:YES completion:^{
        
    }];

}

- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [_picList removeAllObjects];
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    _picList=  [YjlyRequest writeAsset:assets toPath:documentPath rename:@"headimage"];
     ALAsset *representation = [assets objectAtIndex:0];
     UIImage*image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                              scale:representation.defaultRepresentation.scale
                                        orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
     NSData*imageData = UIImageJPEGRepresentation(image, 0.1);
    //将二进制数据生成UIImage
     image = [UIImage imageWithData:imageData];
////    self.headimage = image;
    [self creatUIviewTocropImage:image];
    

    //[self DeliverInformation];
}
#pragma mark 图片裁剪
-(void)creatUIviewTocropImage:(UIImage * )image {
    cropview = [[UIView alloc] initWithFrame:self.view.bounds];
    cropview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:cropview];
    
    imageCropper = [[BJImageCropper alloc] initWithImage:image
                                              andMaxSize:CGSizeMake(self.view.frame.size.width  , self.view.frame.size.height - 60)
                                           andWidthRatio:1.00 andHeightRatio:1.00];
   
    [cropview addSubview:imageCropper];
    imageCropper.frame = CGRectMake(0, 0, self.view
                                    .frame.size.width  , self.view
                                    .frame.size.height - 60);
    imageCropper.imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    imageCropper.imageView.layer.shadowRadius = 3.0f;
    imageCropper.imageView.layer.shadowOpacity = 0.8f;
    imageCropper.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    
    
    
    UIView *bjV = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 70, kScreenWidth, 50)];
    bjV.backgroundColor = [UIColor whiteColor];
    [cropview addSubview:bjV];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width*0.5, 50);
    [btn setTitle:@"头像上传" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blueColor]];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn1.frame = CGRectMake(self.view.frame.size.width*0.5, 0, self.view.frame.size.width*0.5, 50);
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor blueColor]];
    [btn1 addTarget:self action:@selector(cropImageRemove) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:15];

    [bjV addSubview:btn];
    [bjV addSubview:btn1];

}
- (void)cropImage{

    UIImage *resultImage = [imageCropper getCroppedImage];
//    resultImage = [resultImage imageByScalingToSize:CGSizeMake(100, 100)];
    resultImage = [resultImage imageByScalingToSize:CGSizeMake(100 , 100)];
 
//    self.headimageV.image =image;
    [cropview removeFromSuperview];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   NSString *filePath =[documentsDirectory stringByAppendingPathComponent:@"headimage.jpg"];
    
    BOOL result = [UIImagePNGRepresentation(resultImage)writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
    
    
//    NSData*imageData = UIImageJPEGRepresentation(resultImage, 0.3);
//   BOOL result = [imageData writeToFile:filePath atomically:YES];// 保存成功会返回YES

    if (result) {
        [self DeliverInformation:(NSString *)filePath];

    }
    NSLog(@"---image.size--%@",NSStringFromCGSize(resultImage.size));

}
#pragma mark ----------------------------- 取消裁剪图片
- (void)cropImageRemove{
    
    [cropview removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
    
}
#pragma mark    上传头像
-(void)DeliverInformation:(NSString *)filePath
{
    NSMutableDictionary * Parameter = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    [Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
//    [Parameter setValue:self.textView2.text forKey:@"Content"];
//    [Parameter setValue:@"1" forKey:@"Path"];
    NSString *AddDeliverURL=[YjlyRequest UrlParamer:@"Update" CmdName:@"GHeadImage" Parameter:Parameter];
    
    MKNetworkEngine *engine =YJLY_MKNetWorkPort;
    
//    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:DomainURL customHeaderFields:headerFields];
    
    [MBProgressHUD showMessage:nil];
    MKNetworkOperation *operation=[engine operationWithPath:AddDeliverURL params:nil httpMethod:@"post"];
    
    NSLog(@"---------------22222-FileNameFileName---------%@-----",_picList);
//    for (NSString *key in  _picList) {
//        
//        NSLog(@"FileName %@",key);
    
        [operation addFile:filePath forKey:@"headimage"];
//        NSLog(@"---------------111111-FileNameFileName---------%@-----",[_picList objectForKey:key] );
    
    //}
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
//            self.headimageV.image = self.headimage;
           // [MBProgressHUD showSuccess:[jsonData objectForKey:@"value"]];
            [MBProgressHUD showSuccess:@"头像修改成功"];
//            [YjlyRequest DeleteImage:_picList];
            NSLog(@"---头像上传成功");
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Guid" CmdName:@"GuidModel" Parameter:dic];
            [self LoadMyData:MySpaceUrl ifChangeHead:@"change"];

            
        }else
        {
            [MBProgressHUD hideHUD];

            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
 [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
        NSLog(@"%@",[error description]);
        
    }];
    
    [engine enqueueOperation:operation];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return 90;
    }else if(indexPath.row == 17){
     return 150  ;
    }else{
        return 40;
    }
   
   // return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       switch (indexPath.row) {
             
               case 1:
           {
               [self showChangeAlert:@"修改名字"];
               tapedIndex = 1;
           }
               break;
               
              case 2:
           {
               [self showChangeAlert: @"修改导游证件"];
               tapedIndex = 2;

           }
               break;
               
               case 3: //语种
           {
               [ self.listView show];
               tapedIndex = 3;

           }
               break;
               case 4: //地区 //搜索界面
           {
               
               tapedIndex = 4;
               DressSearchViewController *dre = [[DressSearchViewController alloc]init];
               dre.delegate = self;
               [self presentViewController:dre animated:YES completion:nil];

           }
               break;
               
           case 5: //性别
           {
               TagForPopover = 200;
               [ self.genderView show];

//               [self showChangeAlert:@"修改性别"];
//               tapedIndex = 5;
           }
               break;

           case 6: //证件号
           {
               [self showChangeAlert:@"修改证件号"];
               tapedIndex = 6;
           }
               break;
               
               
           case 8: //修改出生日期
           {
               UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
               UILabel * sender = cell.detailTextLabel;
               ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"修改出生日期" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] target:self action:@selector(timeWasSelected:element:) origin:sender];
               datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
               
               datePicker.minuteInterval = 5;
               [datePicker showActionSheetPicker];

           }
               break;
               
               
           case 9: //修改地址
           {
               [self showChangeAlert:@"修改地址"];
               tapedIndex = 9;
           }
               break;

           case 10:{
               ProtaitChangeViewController *pro = [[ProtaitChangeViewController alloc]init];
               pro.zhuyebeijingImage = self.zhuyebeijingImage;
               [self.navigationController pushViewController:pro animated:YES];
               
            }
               break;
           case 11:{
               [self showChangeAlert:@"修改个性签名"];
                tapedIndex = 11;
           }
               break;
               case 12:
           {
//               [self showChangeAlert:@"修改导服费"];
               tapedIndex = 12;

               
           }
               break;
               
        case 13: //二维码
        {
            QRcodeViewController *qr =[[QRcodeViewController alloc]init];
            [self.navigationController pushViewController:qr animated:YES];
        }
            break;
           case 14: //意见反馈
           {
               [self.navigationController pushViewController:[UMFeedback feedbackViewController]
                                                    animated:YES];
           }
               break;
           case 15: //星级
           {
               
           }
            break;

           case 16: //修改密码
           {
               [self showChangeAlert:@"修改密码"];
               tapedIndex = 16;

               
           }
               break;
            
        default:
           {
//               MyDetailViewController *detail = [[MyDetailViewController alloc]init];
//               detail.row = indexPath.row;
//               detail.titleString = [self.titleArray objectAtIndex:indexPath.row];
//               detail.view.backgroundColor = [UIColor whiteColor];
//               [self.navigationController pushViewController:detail animated:YES];
           }
            break;
    }
   
}
//注销登录
-(void)cancellation{
    
    UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert show];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1000:
        {
            if (buttonIndex==1) {
                [UserDefaults setValue:@"" forKey:@"guid"];
                [UserDefaults setValue:@"" forKey:@"moblePhone"];
                [UserDefaults synchronize];
                
                LoginViewController *login = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
 
        }
            break;
            case 1001:
        {
            //得到输入框
            switch (buttonIndex) {
                case 1:
                {
                    UITextField *tf=[alertView textFieldAtIndex:0];
                    if (tf.text.length == 0) return;
                    [self ChangeAllData:tf.text];
                }
                    break;
                    
                default:
                    break;
            }        }
            break;
            
        default:
            break;
    }
   }


#pragma mark 数据请求 获取个人资料
-(void)LoadMyData:(NSString *)urlString ifChangeHead:(NSString *)string
{
    [MBProgressHUD showMessage:@""];
    
     MKNetworkEngine *engine = YJLY_MKNetWork;
    
    MKNetworkOperation *operation=[engine operationWithPath:urlString params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];

            [self.titleArray removeAllObjects];

            
          NSMutableDictionary    *Datadic=[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"个人资料===%@",Datadic);
            self.imageUrlStr  = [Datadic objectForKey:@"HeadImg"];
            NSLog(@"----HeadImg %@ ",[Datadic objectForKey:@"HeadImg"]);
            
            if ([string isEqualToString:@"change"]) {
                
                NSLog(@"---currentThread-----%@",[NSThread currentThread]);
                
                [YJLYNOTIFICATION postNotificationName:@"changeHeadImage" object:self.imageUrlStr];

            }
           NSString *TrueName =   [Datadic objectForKey:@"TrueName"];
           TrueName =  [NSString stringWithFormat:@"真实姓名:  %@",TrueName];

            NSString *Certificates = [Datadic objectForKey:@"Certificates"];
            Certificates =  [NSString stringWithFormat:@"导游证件:  %@",Certificates];

            NSString *Langage = [Datadic objectForKey:@"LangageDesc"];
            Langage =  [NSString stringWithFormat:@"语种:  %@",Langage];

            NSString *Area = [Datadic objectForKey:@"Area"];
            Area =  [NSString stringWithFormat:@"地区:  %@",Area];

            NSString *Gendel = [Datadic objectForKey:@"Gendel"];
            if ([Gendel isEqualToString:@"1"]) {
                Gendel = @"男";
            }
            if ([Gendel isEqualToString:@"2"]) {
                Gendel = @"女";
            }
            Gendel =  [NSString stringWithFormat:@"性别:  %@",Gendel];

            NSString *Number = [Datadic objectForKey:@"Number"];
            Number =  [NSString stringWithFormat:@"证件号:  %@",Number];

           NSString *Phone =  [Datadic objectForKey:@"Phone"];
            Phone =  [NSString stringWithFormat:@"手机号:  %@",Phone];

           NSString *Birthday  = [Datadic objectForKey:@"Birthday"];
            NSLog(@"-------Birthday %@",Birthday);
            
            Birthday = [YjlyRequest GetDateTime:Birthday stringFormat:@"yyyy-MM-dd"];
            Birthday =  [NSString stringWithFormat:@"出生日期:  %@",Birthday];
            NSLog(@"bithday==%@",Birthday);
            NSString *Adress = [Datadic objectForKey:@"Adress"];
            Adress =  [NSString stringWithFormat:@"地址:  %@",Adress];

           NSString *Personsign =  [Datadic objectForKey:@"Personsign"];
            Personsign =  [NSString stringWithFormat:@"个性签名:  %@",Personsign];

           NSString *GuderMoney =  [Datadic objectForKey:@"GuderMoney"];
            GuderMoney =  [NSString stringWithFormat:@"导服费:  %@",GuderMoney];

          self.QRcode =  [Datadic objectForKey:@"QRcode"]; //我的二维码

//           NSString *TrueName =  [Datadic objectForKey:@"TrueName"]; //意见反馈
          NSString *Star =  [Datadic objectForKey:@"Star"]; //
            self.zhuyebeijingImage = [Datadic objectForKey:@"Image"];
            
//            self.titleArray = [NSArray arrayWithObjects:@"",@"真实姓名:",@"导游证件:",@"语种:",@"地区:",@"性别:",@"证件号:",@"手机号:",@"出生日期:",@"地址:",@"个性签名:",@"导服费:",@"我的二维码:",@"意见反馈：",@"我的星级：", @"修改密码：",@"",nil];

            self.starRateView.scorePercent = [Star floatValue]/5;
            
            
            [self.titleArray addObject:self.imageUrlStr];
            [self.titleArray addObject:TrueName];
            [self.titleArray addObject:Certificates];
            [self.titleArray addObject:Langage];
            [self.titleArray addObject:Area];
            [self.titleArray addObject:Gendel];
            [self.titleArray addObject:Number];
            [self.titleArray addObject:Phone];
            [self.titleArray addObject:Birthday];
            [self.titleArray addObject:Adress];
            [self.titleArray addObject:@"我的主页背景照片"];
            [self.titleArray addObject:Personsign];
            [self.titleArray addObject:GuderMoney];
            [self.titleArray addObject:@"我的二维码："];
            [self.titleArray addObject:@"意见反馈："];
            [self.titleArray addObject:Star];
            [self.titleArray addObject:@"修改密码："];
            [self.titleArray addObject:@""];

//            [self.titleArray addObject:GuderMoney];
//            [self.titleArray addObject:GuderMoney];
//            [self.titleArray addObject:GuderMoney];
//
//            
//            self.titleArray = [NSMutableArray arrayWithObjects:self.imageUrlStr,TrueName,Certificates,Langage,Area,Gendel,Number,Phone,Birthday,Adress,@"我的主页背景照片",Personsign,GuderMoney,@"我的二维码：",@"意见反馈：" ,Star,@"修改密码：",@"", nil];

            [self.tableView reloadData];
            
        }else
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
    
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
//        [MBProgressHUD showError:[error localizedFailureReason]];
    
    }];
    
    [engine enqueueOperation:operation];
    
}
#pragma mark -  ZSYPopoverListDelegate
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.listView]) {
        return self.languageArr.count;

    }
    if ([tableView isEqual:self.genderView]) {
        return self.grendArr.count;
    }
    return 0;
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.listView]) {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        }
        if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
        {
            cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
        }
        //    cell.textLabel.text = [NSString stringWithFormat:@"-dsds---%zd------", indexPath.row];
        Language *language =  [self.languageArr objectAtIndex:indexPath.row];
        cell.textLabel.text = language.descriptionStr;
        
        return cell;

    }
    
    
    
       if ([tableView isEqual:self.genderView]) {
        static NSString *identifier = @"grend";
        UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        }
        if ( self.grendIndexPath && NSOrderedSame == [self.grendIndexPath compare:indexPath])
        {
            cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
        }
        cell.textLabel.text = [self.grendArr objectAtIndex:indexPath.row];
        
        return cell;

    }
    return nil;
    }

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
    NSLog(@"deselect:%d", indexPath.row);
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.listView]) {
        self.selectedIndexPath = indexPath;
        UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
        NSLog(@"select:%d", indexPath.row);
    }if ([tableView isEqual:self.genderView]){
        self.grendIndexPath = indexPath;
        UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
        NSLog(@"select:%d", indexPath.row);
    }
   
    
    
    
    
}
#pragma mark 修改语种和性别
-(void)dismissListView:(ZSYPopoverListView *)tableView{
    
    NSString *urlString = @"";
    if ([tableView isEqual:self.listView]) { //语言修改
        Language *language =[self.languageArr objectAtIndex:self.selectedIndexPath.row];
        //修改导游语种
        NSLog(@"------修改导游语种--------------------%@",language.Id);
        NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
        loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
        loginParames[@"Value"] = language.Id;
        loginParames[@"Key"] = @"Langage";
        urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

    }
    
     if ([tableView isEqual:self.genderView] ){
        //性别修改
        NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
        loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
        NSString *gendelnum = @"";
        if (self.grendIndexPath.row ==  0) {
            gendelnum = @"1";
        }
        if (self.grendIndexPath.row == 1) {
            gendelnum = @"2";
        }
        loginParames[@"Value"] = gendelnum;
        loginParames[@"Key"] = @"Gendel";
         NSLog(@"gender--------- = %@",loginParames);
        urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

    }
       MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            
            [MBProgressHUD hideHUD];
            NSDictionary *diclist =(NSDictionary*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"语言修改成功%@",jsonData);
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Guid" CmdName:@"GuidModel" Parameter:dic];
            [self LoadMyData:MySpaceUrl  ifChangeHead:nil];

            
            
            
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



#pragma mark 获取语种 数据请求
-(void)getAllDataAboutLanguage{
    
    NSMutableDictionary  *dic = [NSMutableDictionary  dictionary];
    NSString *urlString =[YjlyRequest UrlParamer:@"Guid" CmdName:@"Language" Parameter:dic];
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
//    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            
            [MBProgressHUD hideHUD];
            NSMutableArray *list =(NSMutableArray*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"返回的语种=%@",list);
            for (int i = 0; i<list.count; i++) {
                 NSDictionary    * dic = [list objectAtIndex:i];
                Language *laguage = [[Language alloc]init];
                laguage.descriptionStr  =[dic objectForKey:@"Description"];
                laguage.Id = [dic objectForKey:@"Id"];
                [self.languageArr addObject:laguage];
                
            }
        
//            [self.listView reloadInputViews];
            
            
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

#pragma mark 弹出信息修改框
-(void)showChangeAlert:(NSString *)titleStr{
    
    UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:titleStr message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1001;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];

}
#pragma mark 修改资料
-(void)ChangeAllData:(NSString *)dataString{
    
    //修改导游资料
    NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
    NSString * urlString = @"";
    switch (tapedIndex) {
        case 1:{
            loginParames[@"Key"] = @"TrueName";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 2:{
            loginParames[@"Key"] = @"Certificates";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
            
            
        case 3:{
            loginParames[@"Key"] = @"Langage";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 4:{
            loginParames[@"Key"] = @"Area";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 5:{
            loginParames[@"Key"] = @"Gendel";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 6:{
            loginParames[@"Key"] = @"Number";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 7:{
            loginParames[@"Key"] = @"Phone";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 8:{
            loginParames[@"Key"] = @"Birthday";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 9:{
            loginParames[@"Key"] = @"Adress";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 11:{
            loginParames[@"Key"] = @"Personsign";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];
 
        }
            
            break;
        case 12:{
            loginParames[@"Key"] = @"GuderMoney";
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"Value"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GUpdateInfo" Parameter:loginParames];

        }
            
            break;
        case 13:{
            loginParames[@"Key"] = @"";
            
        }
            
            break;
        case 15:{
            //            loginParames[@"Key"] = self.accountField.placeholder;
            
        }
            
            break;
        case 16:{//修改密码
            //            loginParames[@"Key"] = self.accountField.placeholder;
            loginParames[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            loginParames[@"NewPwd"] = dataString;
            urlString =[YjlyRequest UrlParamer:@"Login" CmdName:@"GPwd" Parameter:loginParames];

        }
            
            break;
            
            
        default:
            break;
    }
    
    
    
    
    
    MKNetworkEngine *engine = YJLY_MKNetWork;
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"Guid"] = [UserDefaults objectForKey:@"guid"];
            NSString *MySpaceUrl =[YjlyRequest UrlParamer:@"Guid" CmdName:@"GuidModel" Parameter:dic];
            [self LoadMyData:MySpaceUrl ifChangeHead:nil];
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
#pragma mark DressSearchViewControllerDelegate
-(void)changeAdress:(NSString *)adressString{
    NSLog(@"------changeAdresschangeAdresschangeAdresschangeAdress-----------%@----------------",adressString);
    tapedIndex = 4;
    [self ChangeAllData:adressString];
}
@end
