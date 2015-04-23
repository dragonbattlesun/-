//
//  UIImageView+ImageZoom.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-7.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "UIImageView+ImageZoom.h"
#import <objc/runtime.h>


static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";
@implementation UIImageView (ImageZoom)


static CGRect originalFrame;
UIImageView *showView;


- (id)myCustomProperty
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}

- (void)setMyCustomProperty:(id)myCustomProperty
{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, myCustomProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)pictureBecomeBig
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self.myCustomProperty) {
        showView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:self.myCustomProperty]];
    }else{
        showView = [[UIImageView alloc] initWithImage:self.image];
    }

    [scrollView becomeFirstResponder];
    showView.tag = 10;
    scrollView.directionalLockEnabled = YES;
    scrollView.bounces = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor blackColor];

#pragma mark 处理图
    if (showView.frame.size.width < showView.frame.size.height) {
        if (showView.frame.size.width > [UIScreen mainScreen].bounds.size.width )
        {
            float scale = [UIScreen mainScreen].bounds.size.width/showView.frame.size.width;
            showView.frame = CGRectMake(0, 0, showView.bounds.size.width*scale, showView.bounds.size.height*scale);
        }
    }else if(showView.frame.size.width > showView.frame.size.height)
    {
        if (showView.frame.size.height > [UIScreen mainScreen].bounds.size.height )
        {
            float scale = [UIScreen mainScreen].bounds.size.height/showView.frame.size.height;
            showView.frame = CGRectMake(0, 0, showView.bounds.size.width*scale, showView.bounds.size.height*scale);
        }
    }
    #pragma mark 当图片较小的时候居中
    if (showView.frame.size.height < [UIScreen mainScreen].bounds.size.height) {
        showView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - showView.frame.size.height)/2, showView.frame.size.width, showView.frame.size.height);
    }
    
    if (showView.frame.size.width < [UIScreen mainScreen].bounds.size.width) {
        showView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - showView.frame.size.width)/2,showView.frame.origin.y, showView.frame.size.width, showView.frame.size.height);
    }
    
#pragma mark 根据图片原始尺寸来计算缩放比例;
    scrollView.minimumZoomScale = [UIScreen mainScreen].bounds.size.width/showView.frame.size.width < [UIScreen mainScreen].bounds.size.height/showView.frame.size.height ? [UIScreen mainScreen].bounds.size.width/showView.frame.size.width : [UIScreen mainScreen].bounds.size.height/showView.frame.size.height;
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 1;
    [scrollView addSubview:showView];
#pragma mark 根据图片大小设定滚动区域大小
    scrollView.contentSize = showView.bounds.size;
    
    showView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    //缩放手势手势
    tap.numberOfTapsRequired = 1;

    tap.delegate = self;
    [scrollView addGestureRecognizer:tap];
    UITapGestureRecognizer *tapZoom = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapZoom:)];
    tapZoom.numberOfTapsRequired = 2;
    tapZoom.delegate = self;
    [scrollView addGestureRecognizer:tapZoom];
    
    originalFrame = showView.frame;
    scrollView.zoomScale = scrollView.minimumZoomScale;
    [scrollView viewWithTag:10].center = CGPointMake(scrollView.bounds.size.width/2, scrollView.bounds.size.height/2);
    CGRect windowRect = [self convertRect:self.frame toView:self.window];
    CGRect rect = showView.frame;
    showView.frame = windowRect;
    showView.bounds = CGRectMake(0, 0, 0, 0);
    scrollView.alpha = 0;
    [self.window addSubview:scrollView];
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.alpha = 1;
        showView.frame = rect;
    }];

    //收藏手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(collect:)];
    [scrollView addGestureRecognizer:longPress];
}

-(void)collect:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收藏图片" message:@"存入相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
#pragma mark 收藏图片
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
    }
}

#pragma mark 双击实现缩放
- (void)tapZoom:(UIGestureRecognizer*)gesture
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    UIScrollView *scroll = (UIScrollView *)gesture.view;
    if (scroll.zoomScale==1) {
        [UIView animateWithDuration:1 animations:^{
            scroll.zoomScale = scroll.minimumZoomScale;
            [scroll viewWithTag:10].center = CGPointMake(scroll.bounds.size.width/2, scroll.bounds.size.height/2);
        } completion:^(BOOL finished) {
            
        }];
    }else
    {
        [UIView animateWithDuration:1 animations:^{
            scroll.zoomScale = 1;
        [scroll viewWithTag:10].frame = originalFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark  单击实现退出
- (void)back:(UIGestureRecognizer*)gesture{
    
    [self performSelector:@selector(backDid:) withObject:gesture afterDelay:0.25];
}

- (void)backDid:(UIGestureRecognizer*)gesture
{
    
    CGRect windowRect = [self convertRect:self.frame toView:self.window];
    windowRect = CGRectMake(windowRect.origin.x, windowRect.origin.y, 0, 0);

    [UIView animateWithDuration:0.25 animations:^{
        gesture.view.alpha = 0;
        showView.frame = windowRect;
    }completion:^(BOOL finished) {
        [gesture.view removeFromSuperview];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:10];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *showView = (UIImageView *)[scrollView viewWithTag:10];
    
    #pragma mark 当图片较小的时候居中
    if (showView.frame.size.height < [UIScreen mainScreen].bounds.size.height) {
        showView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - showView.frame.size.height)/2, showView.frame.size.width, showView.frame.size.height);
    }
    if (showView.frame.size.width < [UIScreen mainScreen].bounds.size.width) {
        showView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - showView.frame.size.width)/2,showView.frame.origin.y, showView.frame.size.width, showView.frame.size.height);
    }
}

@end
