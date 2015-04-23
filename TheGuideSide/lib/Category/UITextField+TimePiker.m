//
//  UITextField+TimePiker.m
//  banshui
//
//  Created by niexinrong on 14-2-11.
//  Copyright (c) 2014年 JichaoXing. All rights reserved.
//

#import "UITextField+TimePiker.h"

@implementation UITextField (TimePiker)


- (void)initTimePiker2
{
    

        //self.text = @"2013-12000";
        self.borderStyle = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//竖向居中显示
        UIToolbar * accessBar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actFinishInPut:)];
        [accessBar2 setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
        UIDatePicker * date2 = [[UIDatePicker alloc]init];
        date2.datePickerMode = UIDatePickerModeDate;
        self.inputView = date2;
        self.inputAccessoryView = accessBar2;

    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];

    self.text=[NSString stringWithFormat:@"%@",loctime];
    
    //return self;
}

-(void)actFinishInPut:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    UIDatePicker * date2 = (UIDatePicker *)self.inputView;
    NSString *locationString = [formatter stringFromDate:date2.date];
    self.text = locationString;
    [self endEditing:YES];

}

-(void)initTimePiker3
{

        //self.text = @"2013-12-11";
        self.borderStyle = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//竖向居中显示
        UIToolbar * accessBar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actFinishInPut3:)];
        [accessBar2 setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
        UIDatePicker * date2 = [[UIDatePicker alloc]init];
        date2.datePickerMode = UIDatePickerModeDate;
        self.inputView = date2;
        self.inputAccessoryView = accessBar2;
        
    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];
    
    self.text=[NSString stringWithFormat:@"%@",loctime];


}


//月初

-(void)initTimePiker4
{
    
    //self.text = @"2013-12-11";
    self.borderStyle = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//竖向居中显示
    UIToolbar * accessBar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actFinishInPut3:)];
    [accessBar2 setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
    UIDatePicker * date2 = [[UIDatePicker alloc]init];
    date2.datePickerMode = UIDatePickerModeDate;
    self.inputView = date2;
    self.inputAccessoryView = accessBar2;
    
    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-1"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];
    
    self.text=[NSString stringWithFormat:@"%@",loctime];
    
    
}


//月末
-(void)initTimePiker5
{
    
    //self.text = @"2013-12-11";
    self.borderStyle = UITextFieldViewModeAlways;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//竖向居中显示
    UIToolbar * accessBar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actFinishInPut3:)];
    [accessBar2 setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
    UIDatePicker * date2 = [[UIDatePicker alloc]init];
    date2.datePickerMode = UIDatePickerModeDate;
    self.inputView = date2;
    self.inputAccessoryView = accessBar2;
    
    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-30"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];
    
    self.text=[NSString stringWithFormat:@"%@",loctime];
    
    
}

-(void)actFinishInPut3:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    UIDatePicker * date2 = (UIDatePicker *)self.inputView;
    NSString *locationString = [formatter stringFromDate:date2.date];
    self.text = locationString;
    [self resignFirstResponder];
    [self endEditing:YES];
    
}


@end
