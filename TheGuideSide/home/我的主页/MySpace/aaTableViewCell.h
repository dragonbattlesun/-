//
//  aaTableViewCell.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/25.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceStatus.h"
@interface aaTableViewCell : UITableViewCell
-(void)setData:(SpaceStatus *)space;
-(void)SetImageList:(NSString *)ImageList;
-(void)DownloadImage:(NSString*)ImageUrl;
@end
