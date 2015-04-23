//
//  MethodDetailCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "MethodDetailCell.h"
@interface MethodDetailCell ()
@property(nonatomic,weak) UIView * lineView ;
@property(nonatomic,weak) UILabel * dateLabel;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *content;
@property(nonatomic,strong)UILabel *Title;

@end
@implementation MethodDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addView{
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 20, 10)];
    
    dateLabel.textColor =[UIColor grayColor];
    dateLabel.font = FontS(12);
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UIImageView *circleView = [[UIImageView alloc]initWithFrame:CGRectMake(33, 0, 5, 5)];
    circleView.image = [UIImage imageNamed:@"kongjian_yuandian"];
    [self.contentView addSubview:circleView];
    // self.circleView = circleView;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = WJColor(43, 147, 248);
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 90, 80)];
    _imageV.image = [UIImage imageNamed:@"defaultUser"];
    _imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:_imageV action:@selector(pictureBecomeBig)];
    [_imageV addGestureRecognizer:tap];
    [self.contentView addSubview:_imageV];
    
    _Title = [[UILabel alloc]initWithFrame:CGRectMake(145, 0,  kScreenWidth-155,20)];
    //_Title.text = @"北京-日本";
    //lab.textColor =[UIColor <#lab#>];
    _Title.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_Title];
    
    
    
    _content = [[UILabel alloc]initWithFrame:CGRectMake(145, 20, kScreenWidth-155, 60)];
    
    _content.textColor =[UIColor grayColor];
    _content.font = [UIFont systemFontOfSize:14];
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_content];
    
}

-(void)setCellModel:(TravelGuideModel*) model
{
    if ([model.Image isEqualToString:@""]) {
        
        [_imageV setHidden:YES];
        
        //        [_Title setOrigin:CGPointMake(50, _Title.frame.origin.y)];
        [_Title setFrame:CGRectMake(50, _Title.frame.origin.y, kScreenWidth - 60, _Title.frame.size.height)];
        //        [_content setOrigin:CGPointMake(50, _content.frame.origin.y)];
        [_content setFrame:CGRectMake(50, _content.frame.origin.y, kScreenWidth - 60, _content.frame.size.height)];
        
    }else
    {
        [_imageV setHidden:NO];
        
        [_Title setOrigin:CGPointMake(145, _Title.frame.origin.y)];
        
        [_content setOrigin:CGPointMake(145, _content.frame.origin.y)];
        
    }
    
    [_dateLabel setText:[YjlyRequest PageIndexToString:model.ID]];
    
    [_Title setText:model.Title];
    
    [_content setText:model.Mark];
    
}

-(void)layoutSubviews{
    self.lineView.frame = CGRectMake(35, 5, 1, self.bounds.size.height-5);
}


-(void)SetImageList:(NSString *)ImageURL DefaultIcon:(NSString*)DefaultIcon
{
    @try {
        
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        
        if([ImageList count] > 0)
        {
            for (int i=0; i< 1; i++) {
                
                NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:i ]];
                NSURL *ImageUrl= [NSURL URLWithString:url];
                
                
                BOOL IsCache= [[SDImageCache sharedImageCache] diskImageExistsWithKey:url];
                
                NSLog(@"图片%@ 缓存 URL：%@ ",IsCache ==0 ?@"已经":@"未",url);
                
                
                if (IsCache) {
                    UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
                    _imageV.image =image;
                    
                }else
                {
                    
                    
                    [_imageV sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:DefaultIcon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        if (![[SDImageCache sharedImageCache] diskImageExistsWithKey:url]&&image != nil) {
                            
                            [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
                            
                        }else
                        {
                            NSLog(@"图片缓存 %hhd",[[SDImageCache sharedImageCache] diskImageExistsWithKey:url]);
                        }
                        
                        
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
