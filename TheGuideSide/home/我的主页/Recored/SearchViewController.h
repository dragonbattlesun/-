//
//  SearchViewController.h
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/22.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@protocol SearchViewControllerDelegate <NSObject>

@required

-(void)TableSelectScenic:(SearchModel*) model;

@end
@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *SearchBar;

@property (nonatomic,strong) UITableView *SearchTable;

@property (nonatomic,strong) UIView *SearchView;

@property (nonatomic,strong) UIView *ShowHotScenic;

//@property (nonatomic,strong) NSMutableDictionary *HotKeyWord;

@property (nonatomic,strong) NSMutableArray *HotKeyWord;

@property (nonatomic,strong) UIButton *KeyWordButton;

@property (nonatomic,strong) UIView *lineView;

@property(nonatomic ,strong)UIButton *DefaultButton;

@property(nonatomic ,assign)NSInteger PageIndex;

@property(nonatomic ,assign)BOOL IsShow;
///设置参数
@property(nonatomic,strong) NSMutableDictionary *SearchParater;

@property(nonatomic,strong) NSMutableArray *SourceList;

@property(nonatomic,strong)SearchModel *searchModel;

@property (nonatomic,weak) id<SearchViewControllerDelegate> delegate;
@end
