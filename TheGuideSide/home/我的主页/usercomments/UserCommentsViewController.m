//
//  UserCommentsViewController.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/18.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define kWinSize [UIScreen mainScreen].bounds.size

#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "YcKeyBoardView.h"
#import "UserComment.h"
#import "UserCommentsViewController.h"
#import "userCommentTableViewCell.h"
#import "userCommentTableViewCell.h"
@interface UserCommentsViewController ()<UITableViewDataSource,UITableViewDelegate,userCommentTableViewCellDelegate,YcKeyBoardViewDelegate>
@property(nonatomic,strong) UITableView * commentTable ;//comment
@property (nonatomic,strong)YcKeyBoardView *key;

@property(nonatomic,strong) UITableView * receptionTable ;// reception
@property(nonatomic,strong) UITableView * tableView ;// lead
@property(nonatomic,strong) UITableView * lead ;// lead
@property(nonatomic,strong) UIView * remiderV ;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property (weak, nonatomic) UIButton *seletedBtn;
@property (weak, nonatomic) UIButton *seletedCellBtn;
@property(nonatomic,weak)  UIImageView *moveImageView;
@property(nonatomic,strong) NSMutableArray *dataSourseArr;

@end

@implementation UserCommentsViewController
-(void)loadView{
    [super loadView];
//    [self addbutton];
//    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
//    btn.selected = YES;
//    [self doAction:btn];
    [self addtableView];
}
-(void)reminder{
    UIView *remiderV = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 100)];
    remiderV.backgroundColor = [UIColor redColor];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 100)];
    lab.text = @"内容组成：\r\n1：当前旅行服务标题 \r\n2：旅行服务项评分（酒店、饮食、导游服务等等）\r\n以上信息由产品部提供";
    //lab.textColor =[UIColor <#lab#>];
    lab.font = [UIFont systemFontOfSize:15];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [remiderV addSubview:lab];
    self.remiderV = remiderV;
    [self.view addSubview:remiderV];
}

-(void)addtableView{
//    switch ( signtag) {
//        case 1:
//        {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView =tableView;
//        }
//            break;
//        case 2:
//        {
//            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40) style:UITableViewStylePlain];
//            tableView.delegate = self;
//            tableView.dataSource = self;
//            [self.view addSubview:tableView];
//            self.receptionTable =tableView;
//        }
//
//            break;
//        case 3:
//        {
//            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40) style:UITableViewStylePlain];
//            tableView.delegate = self;
//            tableView.dataSource = self;
//            [self.view addSubview:tableView];
//            self.leadTable =tableView;
//        }
//
//            break;
//            
//        default:
//            break;
//    }
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([tableView isEqual:self.commentTable])
//    {
    
    
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        userCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                          TableSampleIdentifier];
    if (cell == nil) {
        cell = [[userCommentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }

    cell.delegate = self;
     UserComment *user=[[UserComment alloc]init];
    [cell setData:user];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
   // NSInteger interger = self.seletedBtn.tag;
  
//    switch (interger) {
//        case 1000:
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
  //  }
   }
#pragma mark userCommentTableViewCellDelegate
- (void)tableViewCell:(userCommentTableViewCell *)cell andButton:(UIButton *)button height:(CGFloat)height
{
    button.selected = !button.selected ;
    self.seletedCellBtn.selected = NO;
    button.selected = YES;
    self.seletedCellBtn = button;
    
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    NSLog(@"-----d--d-d--d-d44--==%zd",indexpath.row);
    //[self becomeFirstResponder];
    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.size.width, height), YES, 0);
//    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *moveImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *moveImgView = [[UIImageView alloc] initWithFrame:(CGRect){0, kWinSize.height-44-height - 126 - 3, cell.size.width,height}];
//    moveImgView.image = moveImg;
//    self.moveImageView = moveImgView;
//   [[UIApplication sharedApplication].keyWindow addSubview:moveImgView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        //        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, self.view.height-44, kWinSize.width, 44)];
        
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
        [[[UIApplication sharedApplication].windows lastObject] addSubview:self.key];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
//    cell.hidden = YES
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
        self.view.transform=CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
        self.key = nil;
        [self.moveImageView removeFromSuperview];
        self.moveImageView = nil;
    }];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    //接口请求
    NSLog(@"----------dd----%@",contentView.text);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.key.textView resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.key.textView resignFirstResponder];

    [self.key removeFromSuperview];
    self.key = nil;
    [self.moveImageView removeFromSuperview];
    self.moveImageView = nil;

}


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath

{
   UserComment *user =  [[UserComment alloc]init];
    
    CGFloat height1=[NSString getHeightOfLabelText:user.content lableWidth:kScreenWidth-80 textFontSize:14];
     CGFloat height2=[NSString getHeightOfLabelText:user.conment lableWidth:kScreenWidth-80 textFontSize:14];
    return height1 +height2 +35 + 20+20+20+10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"------d-fdfd-----%zd",self.seletedBtn.tag);
    if (self.seletedBtn.tag ==1001) {
        return 40;
    }else{
         return 0;
    }
    

    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    lab.text = @"用户评价";
    lab.textColor =[UIColor blueColor];
    lab.font = [UIFont systemFontOfSize:14 ];
    return lab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addtableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 数据请求
-(void)getAllData{
    
    NSMutableDictionary *loginParames = [NSMutableDictionary dictionary];
    loginParames[@""] = @"";
    NSString *urlString =[YjlyRequest UrlParamer:@"ScenicSpot" CmdName:@"ScenicLike" Parameter:loginParames];
    NSLog(@"dic ==  %@",loginParames);
 MKNetworkEngine *engine = YJLY_MKNetWork;    MKNetworkOperation *op = [engine operationWithPath:urlString params:nil httpMethod:@"post"];
    [MBProgressHUD showMessage:nil];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            [MBProgressHUD hideHUD];
            NSMutableArray *list =(NSMutableArray*)[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"返回的数据=%@",[list objectAtIndex:0]);
            
            
            if (list.count == 0) {
                [self.dataSourseArr removeAllObjects];
                [self.tableView reloadData];
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:@"温馨提示" message:@"没有内容" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            
            
            [self.tableView reloadData];
            
            
            
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
