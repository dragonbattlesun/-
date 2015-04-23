//
//  RoutLineTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/27.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "RoutLineTableViewCell.h"

@interface RoutLineTableViewCell ()
@property(nonatomic,strong) UIView * lineView ;
@property(nonatomic,strong) UILabel * dateLabel;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel * TitleName;
@property(nonatomic,strong) UILabel *content;


@end
@implementation RoutLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)addView{
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 25, 10)];
    _dateLabel.textColor =[UIColor grayColor];
    _dateLabel.font = FontS(12);
    [self.contentView addSubview:_dateLabel];
    
    
    UIImageView *circleView = [[UIImageView alloc]initWithFrame:CGRectMake(33, 0, 5, 5)];
    circleView.image = [UIImage imageNamed:@"kongjian_yuandian"];
    [self.contentView addSubview:circleView];
    // self.circleView = circleView;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = WJColor(43, 147, 248);
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 90, 80)];
    _imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:_imageV action:@selector(pictureBecomeBig)];
    [_imageV addGestureRecognizer:tap];

    [self.contentView addSubview:_imageV];
    
    
    
    _TitleName = [[UILabel alloc]initWithFrame:CGRectMake(150, 0,  kScreenWidth-155,40)];
    _TitleName.numberOfLines = 0;
    _TitleName.lineBreakMode = NSLineBreakByTruncatingTail;
    _TitleName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_TitleName];
    
    
    
    _content = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, kScreenWidth-155, 60)];
    
    _content.textColor =[UIColor grayColor];
    _content.font = [UIFont systemFontOfSize:14];
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_content];
    
    
}

-(void)SetCellValue:(RecommendTravalModel *) model
{
    _dateLabel.text =[YjlyRequest PageIndexToString:model.ID];
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.Mark2] placeholderImage:[UIImage imageNamed:@"defaultuser"]];
    
    [_TitleName setText:model.MainTitle];
    
    [_content setText:model.QualityType];
}




-(void)layoutSubviews{
    self.lineView.frame = CGRectMake(35, 5, 1, self.bounds.size.height-5);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)SetImageList:(NSString *)ImageURL
{
    @try {
        
        NSArray *ImageList=[YjlyRequest GetArray:ImageURL SpliteSymbol:@","];
        
        if([ImageList count] > 0)
        {
            for (int i=0; i< 1; i++) {
                
                NSString *url=[NSString stringWithFormat:@"%@%@",DomainURL,[ImageList objectAtIndex:i ]];
                NSURL *ImageUrl= [NSURL URLWithString:url];
                
                
                
                BOOL IsCache= [[SDImageCache sharedImageCache]diskImageExistsWithKey:url];
                
                if (IsCache) {
                    UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
                    _imageV.image =image;
                }else
                {
                    
                    [_imageV sd_setImageWithURL:ImageUrl placeholderImage:[UIImage imageNamed:@"defaultUser"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        if (image != nil) {
                            [[SDImageCache sharedImageCache] storeImage:image forKey:[ImageList objectAtIndex:i ] toDisk:YES];
                            
                            BOOL IsExite= [[SDImageCache sharedImageCache] diskImageExistsWithKey:url];
                            
                            NSLog(@"图片缓存 %hhd",IsExite);
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
