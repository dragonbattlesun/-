//
//  aaTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/25.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//
#define kSpaceDateFont [UIFont systemFontOfSize:12]
#define kSpaceContentFont [UIFont systemFontOfSize:15]
#define ContentWidth 250
#define pic 5
#define  picWidth 55
#import "aaTableViewCell.h"
@interface aaTableViewCell ()
@property(nonatomic,strong) UIView * lineView ;
@property(nonatomic,strong) UILabel * Space_date;
@property(nonatomic,strong) UIImageView * circleImage;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) UIButton * fullBtn ;
@property(nonatomic,strong) UIImageView *imageIcon;
@property(nonatomic,strong) UIView * ImageList ;
@property(nonatomic,strong) UIImageView *image1;
@property(nonatomic,strong) UIImageView *image2;
@property(nonatomic,strong) UIImageView *image3;
@property(nonatomic,strong) UIImageView *image4;

@end

@implementation aaTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addView{

    _Space_date = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, 40, 10)];
    _Space_date.textColor =[UIColor lightGrayColor];
    _Space_date.font = FontS(12);
    [self.contentView addSubview:_Space_date];
    
    _circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(45, 0, 5, 5)];
    _circleImage.image = [UIImage imageNamed:@"kongjian_yuandian"];
    [self.contentView addSubview:_circleImage];
    
    _lineView =[[UIView alloc] initWithFrame:CGRectMake(47, 15, 2, 150)];
    
    [_lineView setBackgroundColor:WJColor(43, 147, 248)];
    [self.contentView addSubview:_lineView];
    _contentLabel =[[UILabel alloc] initWithFrame:CGRectMake(_circleImage.frame.origin.x+_circleImage.frame.size.width+10, 10, ContentWidth, 40)];
    [_contentLabel setTextColor:[UIColor lightGrayColor]];
    [_contentLabel setFont:[UIFont systemFontOfSize:13]];
    [_contentLabel setNumberOfLines:0];//UILineBreakModeWordWrap
    [_contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_contentLabel];
    
    _ImageList=[[UIView alloc] initWithFrame:CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y+_contentLabel.size.height+pic, _contentLabel.frame.size.width, picWidth+pic*2)];
    [self.contentView addSubview:_ImageList];
    
    
    
    
    
    
    CGSize size=CGSizeMake(1, _ImageList.frame.origin.y+_ImageList.frame.size.height);
    
    [_lineView setSize:size];
    
    
    
    
    
    
    
    
    
    
    for (int i = 0; i < 4  ; i ++) {
        UIImageView*imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake((picWidth+pic)*i, pic, picWidth, picWidth)];
        imageIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:imageIcon action:@selector(pictureBecomeBig)];
        [imageIcon addGestureRecognizer:tap];
        [_ImageList addSubview:imageIcon];

        if (i == 0) {
            self.image1 = imageIcon;
        }
        if (i == 1) {
            self.image2 = imageIcon;
        }if (i == 2) {
            self.image3 = imageIcon;
        }if (i == 3) {
            self.image4 = imageIcon;
        }

    }

  
    
}
-(void)setData:(SpaceStatus *)space{
    
    CGRect rect=[self frame];
    
    _Space_date.text=space.date;
    _contentLabel.text = space.content;
    
    CGSize size = CGSizeMake(ContentWidth, MAXFLOAT);
    size=[YjlyRequest boundingRectWith:space.content Size:size TextFont:[UIFont systemFontOfSize:15]];
    [_contentLabel setSize:size];
    
    CGPoint point=CGPointMake(_lineView.origin.x+15, _contentLabel.frame.origin.y+size.height+10);
    [_ImageList setOrigin:point];
  
    [self SetImageList:space.imgUrls];
    rect.size.height = _ImageList.frame.origin.y+_ImageList.frame.size.height-10;
    CGSize lineSize =CGSizeMake(1, MAXFLOAT);
    [_lineView setSize:lineSize];
    self.frame =rect;
    
}

/**
 *  重新布局
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(47, 5, 1, self.bounds.size.height-5);
    [_contentLabel setOrigin:CGPointMake(_circleImage.frame.origin.x+_circleImage.frame.size.width+10, _circleImage.frame.origin.y-3)];
    [_ImageList setOrigin:CGPointMake(_ImageList.frame.origin.x, _contentLabel.frame.origin.y+_contentLabel.frame.size.height)];
}
-(void)SetImageList:(NSString *)ImageURL
{
    NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
    if (ImageList.count == 0) return;
    for (int i=0; i< [ImageList count]; i++) {
        NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:i ]];
        NSURL *ImageUrl= [NSURL URLWithString:url];
               [_imageIcon sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];

    }
    if (ImageList.count ==0 ) {
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.image4.hidden = YES;

    }
    
    if (ImageList.count == 1) {
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:0 ]];
        NSURL *ImageUrl= [NSURL URLWithString:url];
        [self.image1 sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        self.image1.hidden  = NO;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.image4.hidden = YES;
    }
    
    
    
    if (ImageList.count == 2) {
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:0 ]];
        NSURL *ImageUrl= [NSURL URLWithString:url];
        [self.image1 sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        
        
        NSString *url2=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:1 ]];
        NSURL *ImageUrl2= [NSURL URLWithString:url2];
        [self.image2 sd_setImageWithURL:ImageUrl2 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = YES;
        self.image4.hidden = YES;
    }

    
    
    if (ImageList.count == 3) {
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:0 ]];
        NSURL *ImageUrl= [NSURL URLWithString:url];
        [self.image1 sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        
        
        NSString *url2=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:1 ]];
        NSURL *ImageUrl2= [NSURL URLWithString:url2];
        [self.image2 sd_setImageWithURL:ImageUrl2 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        NSString *url3=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:2 ]];
        NSURL *ImageUrl3= [NSURL URLWithString:url3];
        [self.image3 sd_setImageWithURL:ImageUrl3 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];

        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = YES;
    }

    
    
    if (ImageList.count == 4) {
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:0 ]];
        NSURL *ImageUrl= [NSURL URLWithString:url];
        [self.image1 sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        
        
        NSString *url2=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:1 ]];
        NSURL *ImageUrl2= [NSURL URLWithString:url2];
        [self.image2 sd_setImageWithURL:ImageUrl2 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        NSString *url3=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:2 ]];
        NSURL *ImageUrl3= [NSURL URLWithString:url3];
        [self.image3 sd_setImageWithURL:ImageUrl3 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        
        NSString *url4=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:3 ]];
        NSURL *ImageUrl4= [NSURL URLWithString:url4];
        [self.image4 sd_setImageWithURL:ImageUrl4 placeholderImage:[UIImage imageNamed:@"kjtp_jiazai_03"]];
        
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = NO;
    }
    

    
}
//-(void)SetImageList:(NSString *)ImageURL
//{
//    @try {
//        
//        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
//        
//        if([ImageList count] > 0)
//        {
//            for (int i=0; i< [ImageList count]; i++) {
//                
//                NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:i ]];
//                NSURL *ImageUrl= [NSURL URLWithString:url];
//                _imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake((picWidth+pic)*i, pic, picWidth, picWidth)];
//                _imageIcon.userInteractionEnabled = YES;
//                UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:_imageIcon action:@selector(pictureBecomeBig)];
//                [_imageIcon addGestureRecognizer:tap];
//                
//                [_ImageList addSubview:_imageIcon];
//                
//                BOOL IsCache= [[SDImageCache sharedImageCache]diskImageExistsWithKey:url];
//                
//                if (IsCache) {
//                    
//                    UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
//                    _imageIcon.image =image;
//                }else
//                {
//                    
//                    [_imageIcon sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"defaultUser"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                        
//                        if (image != nil&&![[SDImageCache sharedImageCache] diskImageExistsWithKey:url]) {
//                            [[SDImageCache sharedImageCache] storeImage:image forKey:[ImageList objectAtIndex:i ] toDisk:YES];
//                            
//                            BOOL IsExite= [[SDImageCache sharedImageCache] diskImageExistsWithKey:url];
//                            
//                            NSLog(@"缓存图片 %@ %hhd",url,IsExite);
//                        }
//                        
//                    }];
//                }
//                
//            }
//            
//        }
//    }
//    @catch (NSException *exception) {
//        
//        NSLog(@"%@",exception);
//    }
//    @finally {
//        
//        
//    }
//    
//}
//

-(void)DownloadImage:(NSString*)ImageUrl
{
    @try {
        
        NSArray *ImageList=[YjlyRequest GetArray:ImageUrl SpliteSymbol:@","];
        
        if([ImageList count] > 0)
        {
            for (int i=0; i< [ImageList count]; i++) {
                
                NSString *url=[NSString stringWithFormat:@"http://%@%@",DomainURL,[ImageList objectAtIndex:i ]];
                NSURL *ImageUrl= [NSURL URLWithString:url];
    
                SDWebImageManager *ImageManager=[SDWebImageManager sharedManager];
                BOOL IsCache= [[SDImageCache sharedImageCache]diskImageExistsWithKey:url];
                
                if (!IsCache) {
                    
                    [ImageManager downloadImageWithURL:ImageUrl options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                        [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
                    }];
                }
            }
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        
    }
}

@end
