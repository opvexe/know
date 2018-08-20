//
//  AppDelegate.m
//  ConfirmDemon
//
//  Created by FaceBook on 2018/8/9.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer * myTimer;
@property(nonatomic,assign)NSInteger time;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

UIBackgroundTaskIdentifier _backgroundTask;
//UIBackgroundTaskIdentifier bgTask;
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//
//    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//
//        [application endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    }];
//
//    if (bgTask == UIBackgroundTaskInvalid) {
//        NSLog(@"后台任务开启错误");
//    }
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        NSTimeInterval timeRemain = 0;
//        do {
//            if (bgTask!=UIBackgroundTaskInvalid) {
////                timeRemain = [application backgroundTimeRemaining];
////                NSLog(@"timeRemain:%f",timeRemain);
//                NSLog(@"300==========");
//            }
//        } while (bgTask!=UIBackgroundTaskInvalid&&timeRemain==300);
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//
//            if (bgTask!=UIBackgroundTaskInvalid) {
//
//
//                [application endBackgroundTask:bgTask];
//                bgTask = UIBackgroundTaskInvalid;
//            }
//
//        });
//
//
//
//    });
//}
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self beginBackgroundTask];
//    int count = 0;
//    while (YES) {
//        NSLog(@"%d",count);
//        count ++;
//        [NSThread sleepForTimeInterval:1];
//         NSTimeInterval backgroundTimeRemanging = [[UIApplication sharedApplication] backgroundTimeRemaining];
//         NSLog(@"Background Timer Remaining = %.02f Seconds", backgroundTimeRemanging);
//    }
////    [self endBackgroundTask];
//}
//
//- (void)beginBackgroundTask
//{
//    _backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        [self endBackgroundTask];
//    }];
//}
//
//- (void)endBackgroundTask
//{
//    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
//    _backgroundTask = UIBackgroundTaskInvalid;
//}


//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//
//    self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
//        [self endBackgroundTask];
//    }];
//
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
//                                                    target:self
//                                                  selector:@selector(timerMethod:)
//                                                  userInfo:nil
//                                                   repeats:YES];
//    self.time = 1;
//}
//
//
//- (void)timerMethod:(NSTimer *)paramSender{
//    NSTimeInterval backgroundTimeRemanging = [[UIApplication sharedApplication] backgroundTimeRemaining];
//    if ( backgroundTimeRemanging == DBL_MAX) {
//        NSLog(@"Background Time Remaining = Undeterminded");
//    }
//    //--显示后台任务还剩余的时间
//    NSLog(@"Background Timer Remaining = %.02f Seconds", backgroundTimeRemanging);
//    self.time ++ ;
//    NSLog(@"%ld",self.time);
//}
//
//
//- (void)endBackgroundTask{
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    __weak AppDelegate *weakSelf = self;
//    dispatch_async(mainQueue, ^{
//        AppDelegate * strongSelf = weakSelf;
//        if ( strongSelf != nil) {
//            [strongSelf.myTimer invalidate];
//            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
//            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
//        }
//    });
//}


//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//
//    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
//        [self endBackgroundTask];
//
//    }
//}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


UIBackgroundTaskIdentifier bgTaskIdentifier;
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    bgTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        
        NSLog(@"Starting background task with %f seconds remaining", application.backgroundTimeRemaining);
        
        if (bgTaskIdentifier != UIBackgroundTaskInvalid)
        {
            [application endBackgroundTask:bgTaskIdentifier];
            bgTaskIdentifier = UIBackgroundTaskInvalid;
        }
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //// 30
        NSTimer* timer = [NSTimer timerWithTimeInterval:10.0
                                                 target:self
                                               selector:@selector(timerHandle)
                                               userInfo:nil
                                                repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop]run];
        
    });
}




- (void)timerHandle
{
    NSLog(@"timerHandle");
    
}


@end
