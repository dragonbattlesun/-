//
//  ProtaitChangeViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/4/15.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#import "UzysAssetsPickerController.h"
#import "UzysAssetsViewCell.h"
#import "UzysWrapperPickerController.h"
#import "UzysGroupPickerView.h"
#import "UIImage+Graphics.h"
#import "BJImageCropper.h"

#import "ProtaitChangeViewController.h"

@interface ProtaitChangeViewController ()<UzysAssetsPickerControllerDelegate,UIActionSheetDelegate>
{
    BJImageCropper *imageCropper;
    UIView *cropview;
    NSInteger slectedImageTap;
}
@property(nonatomic,strong) NSMutableDictionary *picList;
@property(nonatomic,strong) UIImageView *headimageV;
@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;

@property(nonatomic,strong) UIButton *button3;

@property(nonatomic,strong) UIButton *button4;

@property(nonatomic,strong) UIScrollView *bjScro;
@property(nonatomic,strong) UIImageView *imageview1;
@property(nonatomic,strong) UIImageView *imageview2;
@property(nonatomic,strong) UIImageView *imageview3;
@property(nonatomic,strong) UIImageView *imageview4;

@end

@implementation ProtaitChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picList = [NSMutableDictionary dictionary];

   
    
    
    self.navigationItem.title = @"添加照片";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *bjScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 110)];
    bjScro.contentSize = CGSizeMake(kScreenWidth, (kScreenWidth - 10)*17/34*4);
    bjScro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bjScro];
    self.bjScro = bjScro;
    [self loadImageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight - 104, kScreenWidth, 40);
    button.backgroundColor = yjlyseleted;
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(DeliverInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)loadImageView{
    NSArray *imageArr = [self.zhuyebeijingImage componentsSeparatedByString:@","];

    NSMutableArray *imageurlStringArr = [NSMutableArray arrayWithCapacity:0];
    for (NSString *str in imageArr) {
        [imageurlStringArr addObject:  [NSString stringWithFormat:@"%@%@",DomainURL,str]];
    }
    

    
    
    
   self.imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, (kScreenWidth - 10)*17/34)];
    [self.imageview1 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    self.imageview1.contentMode =  UIViewContentModeScaleAspectFill;
    
    self.imageview1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.imageview1.clipsToBounds  = YES;
    self.imageview1.tag = 1001;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(self.imageview1.bounds.size.width/2-25, self.imageview1.bounds.size.height/2-25, 50, 50);
    button1.tag = 1011;
    self.button1 = button1;
    [button1 setImage:[UIImage imageNamed:@"tianjia_03"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addProtait:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageview1 addSubview:button1];
    self.imageview1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimageaddProtait:)];
    [self.imageview1 addGestureRecognizer:tap];
    
    
    NSString *imageurl1=@"";
    if (imageurlStringArr.count >= 1) {
        self.button1.hidden = YES;
        imageurl1 = [imageurlStringArr objectAtIndex:0];
    }
    [self.imageview1 sd_setImageWithURL:[NSURL URLWithString:imageurl1] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
    self.imageview1.userInteractionEnabled = YES;
//    self.imageview1.tag = 1000+i ;
    [self.bjScro addSubview:self.imageview1];
    
   
    if (self.zhuyebeijingImage.length ==0) {
        self.button1.hidden = NO;
    }
       
    
    
    
   self.imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5+CGRectGetMaxY(self.imageview1.frame), kScreenWidth - 10, (kScreenWidth - 10)*17/34)];
    self.imageview2.tag = 1002;

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(self.imageview2.bounds.size.width/2-25, self.imageview2.bounds.size.height/2-25, 50, 50);
    [button2 setImage:[UIImage imageNamed:@"tianjia_03"] forState:UIControlStateNormal];
    button2.tag = 1010+2;
    self.button2= button2;
    [button2 addTarget:self action:@selector(addProtait:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageview2 addSubview:button2];

    self.imageview2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimageaddProtait:)];
    [self.imageview2 addGestureRecognizer:tap1];
    NSString *imageurl2=@"";
    if (imageurlStringArr.count >= 2) {
        imageurl2 = [imageurlStringArr objectAtIndex:1];
        self.button2.hidden = YES;
    }

    [self.imageview2 sd_setImageWithURL:[NSURL URLWithString:imageurl2] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
    self.imageview2.userInteractionEnabled = YES;
    [self.bjScro addSubview:self.imageview2];
    
    
    
    
    
    
    self.imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5+CGRectGetMaxY(self.imageview2.frame), kScreenWidth - 10, (kScreenWidth - 10)*17/34)];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(self.imageview3.bounds.size.width/2-25, self.imageview3.bounds.size.height/2-25, 50, 50);
    [button3 setImage:[UIImage imageNamed:@"tianjia_03"] forState:UIControlStateNormal];
    button3.tag = 1010+3;
    self.button3 = button3;
    [button3 addTarget:self action:@selector(addProtait:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageview3 addSubview:button3];
    

    self.imageview3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimageaddProtait:)];
    [self.imageview3 addGestureRecognizer:tap3];
    
    
    NSString *imageurl3=@"";
    if (imageurlStringArr.count >=3  ) {
        self.button3.hidden = YES;
        imageurl3 = [imageurlStringArr objectAtIndex:2];
    }
    [self.imageview3 sd_setImageWithURL:[NSURL URLWithString:imageurl3] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
    self.imageview3.userInteractionEnabled = YES;
    self.imageview3.tag = 1000+3 ;
    [self.bjScro addSubview:self.imageview3];
    
    
    
    
    
    self.imageview4 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5+CGRectGetMaxY(self.imageview3.frame), kScreenWidth - 10, (kScreenWidth - 10)*17/34)];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(self.imageview4.bounds.size.width/2-25, self.imageview4.bounds.size.height/2-25, 50, 50);
    [button4 setImage:[UIImage imageNamed:@"tianjia_03"] forState:UIControlStateNormal];
    button4.tag = 1010+4;
    self.button4 = button4;
    [button4 addTarget:self action:@selector(addProtait:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageview4 addSubview:button4];

    self.imageview4.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapimageaddProtait:)];
    [self.imageview4 addGestureRecognizer:tap4];
    NSString *imageurl4=@"";
    if (imageurlStringArr.count >= 4) {
        self.button4.hidden = YES;
        imageurl4 = [imageurlStringArr objectAtIndex:3];
    }
    [self.imageview4 sd_setImageWithURL:[NSURL URLWithString:imageurl4] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
    self.imageview4.userInteractionEnabled = YES;
    self.imageview4.tag = 1000+4 ;
    [self.bjScro addSubview:self.imageview4];
    
   
    
}
-(void)tapimageaddProtait:(UITapGestureRecognizer *)recognizer{
    NSLog(@"%d",(recognizer.view.tag ));
    switch (recognizer.view.tag) {
        case 1001:
        {
            
            slectedImageTap = 1001;
            [self showSheet];
            
            self.headimageV = self.imageview1;
        }
            break;
        case 1002:
        {
           
            slectedImageTap = 1002;
            [self showSheet];
            self.headimageV = self.imageview2;

        }
            break;

        case 1003:
            
        {    slectedImageTap = 1003;
                        [self showSheet];

            self.headimageV = self.imageview3;
        }
            break;

        case 1004:
        {
           
            slectedImageTap = 1004;
            [self showSheet];

            self.headimageV = self.imageview4;
            
        }
            break;
            
        default:
            break;
    }

}
-(void)showSheet{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:slectedImageTap+10];
    if (button.hidden == YES) {
        UIActionSheet *actionSheetTest = [[UIActionSheet alloc]initWithTitle:@"选择"
                                                                    delegate:self
                                                           cancelButtonTitle:nil
                                                      destructiveButtonTitle:@"取消"
                                                           otherButtonTitles:@"照片更新",@"删除",nil];
        actionSheetTest.delegate = self;
        [actionSheetTest showInView:self.view];

    }else{
        UIActionSheet *actionSheetTest = [[UIActionSheet alloc]initWithTitle:@"选择"
                                                                    delegate:self
                                                           cancelButtonTitle:nil
                                                      destructiveButtonTitle:@"取消"
                                                           otherButtonTitles:@"添加照片",nil];
        
        actionSheetTest.delegate = self;
        [actionSheetTest showInView:self.view];

    }
    
   
}
#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   
        switch (buttonIndex) {
            case 0:
                // 取消
                return;
            case 1:
                // 更新
            {
                [self changPhtoto];

            }break;
                
            case 2:
                // 删除
            {
                [self deleteShowPic];
            }
                break;
        }

  
    

}
#pragma mark 删除展示的图片
-(void)deleteShowPic{
   
    NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
    loginParames [@"Guid"] = [UserDefaults objectForKey:@"guid"];
    loginParames [@"Ids"] = [NSString stringWithFormat:@"%zd",slectedImageTap-1001];
    NSLog(@"----- ddd--------------%zd",slectedImageTap-1001);

    NSString *urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GDelImage" Parameter:loginParames];
    MKNetworkEngine *engine = YJLY_MKNetWork;
    
    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            UIButton *button = (UIButton *)[self.view viewWithTag:slectedImageTap+10];
            button.hidden = NO;
            UIImageView *imageV = (UIImageView *)[self.view viewWithTag:slectedImageTap];
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"tp_jiazai"]];
            
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"删除成功"];
            NSLog(@"返回的数据=%@",jsonData);
            NSLog(@"图片删除成功");
            //            self.Introduction =[diclist objectForKey:@"Introduction"];
            //            [self addimageView];
            //            [self addIntrduce];
            
            //            if (list.count == 0) {
            //                [self.dataSourseArr removeAllObjects];
            //                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有内容" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            //                [alert show];
            //                return ;
            //            }
            
            
            
            
            
            
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
-(void)addProtait:(UIButton *)button{
 
    switch ( button.tag) {
        case 1011:
        {
            slectedImageTap = 1001;


            self.headimageV = self.imageview1;
            [self showSheet];
        }
            break;
        case 1012:
        {
            slectedImageTap = 1002;


            self.headimageV = self.imageview2;

            [self showSheet];

        }
            break;

        case 1013:
        {
            slectedImageTap = 1003;


            self.headimageV = self.imageview3;
            [self showSheet];

        }
            break;
        case 1014:
        {
            slectedImageTap = 1004;


            self.headimageV = self.imageview4;
            [self showSheet];

        }
            break;


            
        default:
            break;
    }
    
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
    NSLog(@"---%zd",slectedImageTap);

    
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    _picList=  [YjlyRequest writeAsset:assets toPath:documentPath];
//    NSMutableDictionary *imageDic = [YjlyRequest writeAsset:assets toPath:documentPath rename:[NSString stringWithFormat:@"image%zd",slectedImageTap]];
    
//    NSLog(@"imageDic=%@",imageDic);
//    
//    if (slectedImageTap == 1001) {
//        
//        [_picList setObject:[imageDic objectForKey:@"image1001"] forKey:@"0"];
//    }
//    if (slectedImageTap == 1002) {
//        [_picList setObject:[imageDic objectForKey:@"image1002"] forKey:@"1"];
//
//    }
//    if (slectedImageTap == 1003) {
//        [_picList setObject:[imageDic objectForKey:@"image1003"] forKey:@"2"];
//
//    }
//    if (slectedImageTap == 1004) {
//        [_picList setObject:[imageDic objectForKey:@"image1004"] forKey:@"3"];
//        
//    }
//
    /*
     2015-04-20 23:20:08.410 燕京联盟[1939:81943] =====_picList------------------------- =={
     1 = "/Users/yanjinglvyou/Library/Developer/CoreSimulator/Devices/62417AFB-E227-462D-BD9F-AF0F126195EB/data/Containers/Data/Application/154E5B05-31B4-4FC8-859F-45FB055288A4/Documents/image1002.jpg";
     }

     */
    
    
    NSLog(@"=====_picList------------------------- ==%@",_picList);

    ALAsset *representation = [assets objectAtIndex:0];
   
    
    UIImage * image =[UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
    
    NSData*imageData = UIImageJPEGRepresentation(image, 0.1);
    //将二进制数据生成UIImage
    image = [UIImage imageWithData:imageData];
    
//    self.headimageV.image = image;
    
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
                                           andWidthRatio:64.00 andHeightRatio:34.00];
    
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
    [btn setTitle:@"确定" forState:UIControlStateNormal];
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
    
    
    UIButton *button =(UIButton *)[self.view viewWithTag:slectedImageTap +10];
    button.hidden = YES;
    UIImage *resultImage = [imageCropper getCroppedImage];
    resultImage = [resultImage imageByScalingToSize:CGSizeMake(320*2 , 170*2)];
    NSLog(@"---%zd",slectedImageTap);
   UIImageView *imageV=  (UIImageView *)[self.view viewWithTag:slectedImageTap  ];
//   self.headimageV.image =image;
    imageV.image = resultImage;
    [cropview removeFromSuperview];
    
    NSString *imagename = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    if (<#condition#>) {
//        <#statements#>
//        
//    }
      NSString *filePath =@"";
    if (slectedImageTap == 1001) {
        filePath =[documentsDirectory stringByAppendingPathComponent:@"image1001.jpg"];
        [_picList setObject:filePath forKey:@"0"];
        
    }
    if (slectedImageTap == 1002) {
        filePath =[documentsDirectory stringByAppendingPathComponent:@"image1002.jpg"];

        [_picList setObject:filePath forKey:@"1"];
        
    }
    if (slectedImageTap == 1003) {
        filePath =[documentsDirectory stringByAppendingPathComponent:@"image1003.jpg"];

        [_picList setObject:filePath forKey:@"2"];
        
    }
    if (slectedImageTap == 1004) {
        filePath =[documentsDirectory stringByAppendingPathComponent:@"image1004.jpg"];

        [_picList setObject:filePath forKey:@"3"];
        
    }

//    NSString *filePath =[documentsDirectory stringByAppendingPathComponent:@"headimage.jpg"];
    
    BOOL result = [UIImagePNGRepresentation(resultImage)writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
    NSLog(@"===是否成功保存入沙盒=%d",result);
    
    //    NSData*imageData = UIImageJPEGRepresentation(resultImage, 0.3);
    //   BOOL result = [imageData writeToFile:filePath atomically:YES];// 保存成功会返回YES
    
//    if (result) {
//        [self DeliverInformation:(NSString *)filePath];
//        
//    }

//    [self DeliverInformation];
    
    NSLog(@"---image.size--%@",NSStringFromCGSize(resultImage.size));

}
#pragma mark ----------------------------- 取消裁剪图片
- (void)cropImageRemove{
    
    [cropview removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
    
}
#pragma mark    上传图片
-(void)DeliverInformation
{
    
    
    
    
    
    NSMutableDictionary * Parameter = [NSMutableDictionary dictionary];
    
    
    
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    [Parameter setValue:[UserDefaults objectForKey:@"guid"] forKey:@"Guid"];
    
    
    
    //--------------------------------------------------------
    NSMutableArray *numimage = [NSMutableArray arrayWithCapacity:0];
    
    NSEnumerator *enumeratorKey = [_picList keyEnumerator];
    for (NSObject *object in enumeratorKey) {
        NSString *keyStr = (NSString *)object;
        //        NSInteger num =  keyStr.length-1;
        //        NSString * laststr =[keyStr substringFromIndex: num];
        [numimage addObject:keyStr];
        
    }
    
    NSArray *sortedArray = [numimage sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"排序后:%@",sortedArray);
    
    NSString *string = nil;
    NSString *lastString = @"";//路径
    for (NSString *value in sortedArray) {
        string = [NSString stringWithFormat:@"%@%@", lastString, value];
        lastString = [NSString stringWithFormat:@"%@,", string];
    }
    lastString=[NSString stringWithFormat:@"%@",lastString];
    
    if (lastString.length == 0) return;
    
    NSString *Ids  = [lastString substringToIndex:lastString.length - 1];
    
    
    //--------------------------------------------------------
    [Parameter setValue:Ids forKey:@"Ids"];
    NSString *AddDeliverURL=[YjlyRequest UrlParamer:@"Update" CmdName:@"GImage" Parameter:Parameter];
    
//    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:DomainURL customHeaderFields:headerFields];
    
    [MBProgressHUD showMessage:nil];
     MKNetworkEngine *engine = YJLY_MKNetWorkPort;
    
    MKNetworkOperation *operation=[engine operationWithPath:AddDeliverURL params:nil httpMethod:@"post"];
    
    

    
    
    
    
    
    NSLog(@"============_picList ---%@=============",_picList);
    for (NSString *key in  _picList) {
        
        NSLog(@"FileName %@",key);
        
        [operation addFile:[_picList objectForKey:key] forKey:key];
        
    }
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
            // [MBProgressHUD showSuccess:[jsonData objectForKey:@"value"]];
            [MBProgressHUD showSuccess:@"背景照片修改成功"];
            [YjlyRequest DeleteImage:_picList];
            [_picList removeAllObjects];
            NSLog(@"---头像上传成功");
            
        }else
        {
           [MBProgressHUD hideHUD];

            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
        [MBProgressHUD hideHUD];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];

[MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];        
    }];
    
    [engine enqueueOperation:operation];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_picList removeAllObjects];

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
