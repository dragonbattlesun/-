//
//  AppDelegate.m
//  TheGuideSide
//
//  Created by yanjinglvyou on 15/3/17.
//  Copyright (c) 2015年 wangfengjing. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "APService.h"
#import "NavViewController.h"
#import "MYViewController.h"
#import "HomeViewController.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HYBUMAnalyticsHelper.h"
#import "MobClick.h"
#import "UMFeedback.h"
#import "RomoteMessage.h"
#import "Harpy.h"
@interface AppDelegate ()<CLLocationManagerDelegate>
@property (nonatomic,retain)CLLocationManager* locationManager;
@property(nonatomic,strong) NSString *push;

@end

@implementation AppDelegate

- (void)locate

{
    // 判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init] ;
        // 设置定位精度，十米，百米，最好
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        // 你要加上  //适配IOS8.0 定位服务
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if(version >8.0 || version == 8.0)
        {
            [ self.locationManager requestAlwaysAuthorization];
        }

        self.locationManager.delegate = self;
        
    }else {
        
        //提示用户无法进行定位操作
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  
                                  @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }
    
    // 开始定位
    
    [self.locationManager startUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    
    
    
    
    
    
    NSLog(@"%d", [locations count]);
    
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    // 旧的经度：116.454478,旧的纬度：39.895506
    
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信息
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
     {
         
         if (array.count > 0)
             
         {
             
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的所有信息显示到label上
             
             NSLog(@"placemark.name==%@",placemark.name);

             //获取城市
             
             NSString *city = placemark.locality;
             NSLog(@"placemark.city==%@",city);

             if (!city) {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 
                 city = placemark.administrativeArea;
                 return ;
             }
             //             NSLog(@"-------222222-----%@",placemark.addressDictionary);
             
             //            self.locationlab.text = city; //北京市市辖区
             [ DefaultSingleton sharedInstance].locationCity = [[placemark addressDictionary] objectForKey:@"State"];
             NSLog(@"-----------------1111111-----------------%@---",[DefaultSingleton sharedInstance].locationCity);
             // self.locationManager.delegate = nil ;// 设置代理方发

             
         }
         
         else if (error == nil && [array count] == 0)
             
         {
             
             NSLog(@"No results were returned.");
             
         }
         
         else if (error != nil)
             
         {
             
             NSLog(@"An error occurred = %@", error);
             
         }
         
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.locationManager stopUpdatingLocation];

    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@" 定位error");

    if (error.code == kCLErrorDenied) {
        NSLog(@"-----提示用户出错原因-------%d",error.code);
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //定位
    [self locate];
    [Harpy checkVersion];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];

    
    
    
    
    
    
    
    
    
    //友盟统计
    //  友盟的方法本身是异步执行，所以不需要再异步调用

    [HYBUMAnalyticsHelper UMAnalyticStart];
    [UMFeedback setAppkey:@"5527374ffd98c5669000157c"];
    
    
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"1111112==%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    [MobClick event:@"Forward"];

    
    
    
 
    //友盟分享
    [UMSocialData setAppKey:@"5527374ffd98c5669000157c"];
   //微信
//    AppID：wxb43691caadea944f
//    AppSecret：d572e0f94b4ab2dd5d09878042c4f605
    [UMSocialWechatHandler setWXAppId:@"wxb43691caadea944f" appSecret:@"d572e0f94b4ab2dd5d09878042c4f605" url:@"http://www.yanjinglvyou.com"];
    
    //qq
    [UMSocialQQHandler setQQWithAppId:@"1104490656" appKey:@"Mi9eroPEyiXjfsKw" url:@"http://www.yanjinglvyou.com"];
     //新浪
    //[UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.yanjinglvyou.com"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.yanjinglvyou.com"];

    
    
    NSUserDefaults *defult = [NSUserDefaults  standardUserDefaults];
    [defult objectForKey:@"JehovahLogin"];
    NSString *login = [defult objectForKey:@"JehovahLogin"];
    if ([login isEqualToString:@"Jehovah"]) {
       [UserDefaults removeObjectForKey:@"guid"];
        
        
        NSString *guid = [UserDefaults objectForKey:@"guid"];
        if (guid.length > 0 ) {  //如果guid存在，（用户没有退出）
            HomeViewController *home = [[HomeViewController alloc]init];
            self.window.rootViewController = [[NavViewController alloc]initWithRootViewController:home];
        }else{//用户退出情况
            LoginViewController *loginView = [[[LoginViewController alloc]init]init];
            self.navView  = [[NavViewController alloc]initWithRootViewController:loginView];
            self.window.rootViewController = self.navView;

        }
        
        
        
    }else{
        
        MYViewController *appStartController = [[MYViewController alloc] init];
        self.window.rootViewController = appStartController;
        //加上后只走一次
        NSUserDefaults *defult = [NSUserDefaults  standardUserDefaults];
        [defult setObject:@"Jehovah" forKey:@"JehovahLogin"];
        [defult synchronize];
}

    
    
    //self.window.rootViewController = [[MYViewController alloc]init];
    
    
    [self.window makeKeyAndVisible];

   
    
    
    
    
    //处理远程推送
    if (launchOptions != nil)
    {
        NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
     NSLog(@"Launched from push notification: %@", dictionary);
            [self addMessageFromRemoteNotification:dictionary updateUI:NO];
        }
    }
    
    if (launchOptions) {
        NSString *pushString =  [NSString stringWithFormat:@"%@", launchOptions];
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSString *url= [[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"url"];
        appDelegate.push= url;
        
    }
    
   // [self jpush:launchOptions];
    
    return YES;
}
// 获取到deviceToken就会调用
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"----didRegisterForRemoteNotificationsWithDeviceToken----%@",deviceToken);
    // Required
    // 传递获取到得deviceToken给Jpush, Jpush会自动帮我们管理deviceToken
    [APService registerDeviceToken:deviceToken];
}

/*
 在iOS7以前, 只要程序在前台或者后台接收到远程推送过来的通知就会调用
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"在iOS7以前  Received notification: %@", userInfo);
    [self addMessageFromRemoteNotification:userInfo updateUI:YES];
   
    // Required
    [APService handleRemoteNotification:userInfo];
}

// iOS7以后调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    /*
     2015-04-14 13:20:56.419 燕京旅游后台版[4600:2096449]   iOS7以后调用  Received notification: {
     "_j_msgid" = 735766190;
     aps =     {
     alert = "\U8fd9\U79cd";
     badge = 1;
     sound = default;
     };
     }
     */ 
    if (application.applicationState==UIApplicationStateActive) {//程序在前台时，收到消息的点击事件
        NSLog(@"----------------UIApplicationStateActive-----------------------------------------------");;
        
    }else if (application.applicationState == UIApplicationStateInactive){//程序在后台时，收到消息的点击事件

        NSLog(@"----------------UIApplicationStateInactive-----------------------------------------------");;

    }    
    
    NSLog(@"  iOS7以后调用  Received notification: %@", userInfo);

    NSNumber *contentid = userInfo[@"content-id"];
    if (contentid) {
        completionHandler(UIBackgroundFetchResultNewData);

    }else{
        completionHandler(UIBackgroundFetchResultFailed);

    }
 /*
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    // 每次处理完推送过来的通知, 都"必须"告诉系统是否处理成功
    // 1.方便程序在后台更新数据
    // 2.系统会更具状态判断是否处理成功
    completionHandler(UIBackgroundFetchResultNewData);
  */
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "YJLY.TheGuideSide" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TheGuideSide" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TheGuideSide.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark 对极光推送来的数据处理
-(void)addMessageFromRemoteNotification:(NSDictionary *)userInfo updateUI:(BOOL)updateUI
{
    
    /*
     推送信息的JSON的格式看起来是这样的：{
     "aps":
     {
     "alert": "SENDER_NAME: MESSAGE_TEXT",
     "sound": "default"
     },
     } 
     */
    RomoteMessage* message = [[RomoteMessage alloc] init];
    message.date = [NSDate date];
    
    NSString* alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    
    NSMutableArray* parts = [NSMutableArray arrayWithArray:[alertValue componentsSeparatedByString:@": "]];
    message.senderName = [parts objectAtIndex:0];
    [parts removeObjectAtIndex:0];
    message.text = [parts componentsJoinedByString:@": "];
   
    
//    int index = [dataModel addMessage:message];
    
//    if (updateUI)
//        [self.chatViewController didSaveMessage:message atIndex:index];
//    
    
       //--------------------------------------
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"guid"] = [UserDefaults objectForKey:@"guid"];
    dic[@"JPushNum"] = @"";
    NSString *urlString =[YjlyRequest UrlParamer:@"Update" CmdName:@"GjPush" Parameter:dic];
     MKNetworkEngine *engine = YJLY_MKNetWork;
    
    MKNetworkOperation *operation=[engine operationWithPath:urlString params:nil];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [MBProgressHUD hideHUD];
        NSDictionary *jsonData=(NSDictionary*)[completedOperation responseJSON];
        
        //判断是否返回json数据
        if(jsonData !=nil && [[jsonData objectForKey:@"state"] isEqualToString:@"0"])
        {
            NSDictionary    *DataSource=[YjlyRequest dictionaryWithJsonString:[jsonData objectForKey:@"value"]];
            NSLog(@"%@",jsonData);
            
        }else
        {
            [MBProgressHUD showError:[jsonData objectForKey:@"msg"]];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
//        [MBProgressHUD showError:[error localizedFailureReason]];
        [MBProgressHUD showError:[YjlyRequest NSURLError:[error code]]];
        
    }];
    
    [engine enqueueOperation:operation];
    
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
