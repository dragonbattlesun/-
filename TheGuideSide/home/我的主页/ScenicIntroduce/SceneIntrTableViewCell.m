//
//  SceneIntrTableViewCell.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/21.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "SceneIntrTableViewCell.h"
#import "CWStarRateView.h"
#import "SceneModel.h"
@implementation SceneIntrTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    
    
    _IconImage= [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 60, 60)];
    CALayer * l = [_IconImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:30.0];
    _IconImage.userInteractionEnabled = YES;
    [self.contentView addSubview:_IconImage];
    
    _PlayBegin=[[UIButton alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    
    [_PlayBegin setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    _PlayBegin.selected = NO;
    [_PlayBegin setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [_IconImage addSubview:_PlayBegin];
    [_PlayBegin addTarget:self action:@selector(playerRecord:) forControlEvents:UIControlEventTouchUpInside];
  
    
    _ScenicName = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 280, 30)];
    [_ScenicName setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_ScenicName];
    
    
    //星星
    
    _Mp3URL =[[UILabel alloc] init];
    [_Mp3URL setHidden:YES];
    [_Mp3URL setEnabled:NO];
    [self.contentView addSubview:_Mp3URL];
    _starRate = [[CWStarRateView alloc] initWithFrame:CGRectMake(75, 40, 60, 10) numberOfStars:5 imageName:@"xxh"];
    [_starRate setAllowIncompleteStar:YES];
    [_starRate setScorePercent:1.0];
    [self.contentView addSubview:_starRate];
    
    _ScenicDesc = [[UILabel alloc]initWithFrame:CGRectMake(75, 50, kScreenWidth-100, 50)];
    [_ScenicDesc setFont:[UIFont systemFontOfSize:13]];
    [_ScenicDesc setNumberOfLines:2];
    [_ScenicDesc setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_ScenicDesc];
    
   
    _PublishDate = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width -50 , 10, 40, 50)];
    [_PublishDate setTextColor:[UIColor grayColor]];
    [_PublishDate setNumberOfLines:2];
    [_PublishDate setLineBreakMode:NSLineBreakByWordWrapping];
    [_PublishDate setFont:[UIFont systemFontOfSize:11]];
    [self.contentView addSubview:_PublishDate];
    
    NSArray *arr = [NSArray arrayWithObjects:@"sj",@"xin22",@"ai_11_06",@"shijian", nil];
    for (int i = 0; i < 4; i++) {
        
        _SmallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(75+(i*60), 100, 10, 10)];
        [_SmallIcon setImage:[UIImage imageNamed:[arr objectAtIndex:i]]];
        [self.contentView addSubview:_SmallIcon];
        if(i==0)
        {
            _PlayCount= [[UILabel alloc]initWithFrame:CGRectMake(95+(i*60), 95, 40, 20)];
            [_PlayCount setFont:[UIFont systemFontOfSize:11]];
            [_PlayCount setTextColor:[UIColor grayColor]];
            [self.contentView addSubview:_PlayCount];
        }
        else if(i==1)
        {
            _CommentCount= [[UILabel alloc]initWithFrame:CGRectMake(95+(i*60), 95, 40, 20)];
            [_CommentCount setTextColor:[UIColor grayColor]];
            [_CommentCount setFont:[UIFont systemFontOfSize:11]];
            [self.contentView addSubview:_CommentCount];
        }else if(i==2)
        {
            _LikeCount= [[UILabel alloc]initWithFrame:CGRectMake(95+(i*60), 95, 40, 20)];
            [_LikeCount setTextColor:[UIColor grayColor]];
            [_LikeCount setFont:[UIFont systemFontOfSize:11]];
            [self.contentView addSubview:_LikeCount];
        }else
        {
            _PlayTime= [[UILabel alloc]initWithFrame:CGRectMake(95+(i*60), 95, 40, 20)];
            [_PlayTime setTextColor:[UIColor grayColor]];
            [_PlayTime setFont:[UIFont systemFontOfSize:11]];
            [self.contentView addSubview:_PlayTime];
        }

    }
    
}

#pragma 
-(void)setData:(SceneModel *)Model{

    
    [self.ScenicName setText:Model.Name];
    [self.ScenicDesc setText:Model.Introduction];
    [self.starRate setScorePercent:Model.ScenicRating];
    [self.PlayCount setText:[self GetCountForString:Model.PlayCount]];
    [self.CommentCount setText:[self GetCountForString:Model.PraiseCount]];
    [self.LikeCount setText:[self GetCountForString:Model.LoveCount]];
    [self.PlayTime setText:[YjlyRequest SecondToTime:Model.Datetime]];
    [self.Mp3URL setText:[NSString stringWithFormat:@"%@%@",DomainURL,Model.URL]];
    NSString *temp=[YjlyRequest GetTimeSpan:Model.CreateTime DateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    [self.PublishDate setText:[NSString stringWithFormat:@"%@\r\n原创",temp]];
    if (![Model.PicSrc isEqualToString:@""]) {
        
        NSString *iconUrl=[[YjlyRequest GetArray:Model.PicSrc SpliteSymbol:@","] objectAtIndex:0];
        
        [_IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DomainURL,iconUrl]] placeholderImage:[UIImage imageNamed:@"defaultuser"] options:SDWebImageDelayPlaceholder];
    }else
    {
        [_IconImage setImage:[UIImage imageNamed:@"defaultuser"]];
    }
    
}
-(void)playerRecord:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(tableViewCell:Player:)]) {
        [self.delegate tableViewCell:self  Player: button];
    }
}




/**
 *  初始化ICON
 *
 *  @param iconImage <#iconImage description#>
 */
- (void)configWithIcon:(NSString *)iconImageUrl
{
   
    
    UIImage *myCachedImage = [[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:iconImageUrl];
    
    if (!myCachedImage) {
        
        [self.IconImage sd_setImageWithURL:[NSURL URLWithString:iconImageUrl] placeholderImage:[UIImage imageNamed:@"defaultuser"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [[SDImageCache sharedImageCache] storeImage:image forKey:iconImageUrl];
        }];
    }
    
    
    
}

/**
 *  Description
 *
 *  @param DownloadImage
 */
- (void)configWithIconUseAnimate:(UIImage *)DownloadImage
{
   
        _IconImage.alpha = 0.6;
        _IconImage.image = DownloadImage;
        
        [UIView animateWithDuration:0.4 animations:^{
            _IconImage.alpha = 1;
        }];
    
}
-(NSString*)GetCountForString:(NSInteger)Count
{
    NSString * CommentCount=[NSString stringWithFormat:@"%zd",Count];
    if ([CommentCount length] == 5) {
        CommentCount=[NSString stringWithFormat:@"%d %d万",Count/1000,Count%1000];
        return CommentCount;
    }else
    {
        return CommentCount;
    }
}

@end
