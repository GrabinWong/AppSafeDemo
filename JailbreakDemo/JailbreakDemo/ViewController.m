//
//  ViewController.m
//  JailbreakDemo
//
//  Created by Grabin on 2017/12/27.
//  Copyright © 2017年 GrabinWong. All rights reserved.
//

#import "ViewController.h"
#import "DeviceSafeTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self AppSafeDetection];
}


/** App安全检测 */
- (void)AppSafeDetection
{
    // 判断安装包是否被篡改,被篡改则无法使用app
    if ([DeviceSafeTool isDocumentHasBeenTamper]) {
        [self ipaIsTampering];
        return;
    }
    // 判断是否是越狱环境
    if ([DeviceSafeTool isDeviceJailbreak]) {
        [self deviceHasBeenJailbreak];
    }
}

/** ipa被篡改 */
- (void)ipaIsTampering
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"危险警告" message:@"您使用的App已被篡改，危险系数高，请从正规渠道下载。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        exit(0);
    }];
    [alertController addAction:quitAction];
    [self presentViewController:alertController animated:YES completion:nil]
    ;
}

/** 设备是越狱手机 */
- (void)deviceHasBeenJailbreak
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"危险警告" message:@"当前App处于越狱环境，请谨慎使用。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续使用" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        exit(0);
    }];
    
    [alertController addAction:continueAction];
    [alertController addAction:quitAction];
    [self presentViewController:alertController animated:YES completion:nil]
    ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
