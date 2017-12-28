//
//  DetectJailbreakTool.m
//  JailbreakDemo
//
//  Created by Grabin on 2017/12/27.
//  Copyright © 2017年 GrabinWong. All rights reserved.
//

// 说明：此类是Grabin查阅资料后写的关于App安全的 越狱检测，以及防ipa篡改检测的方法，在防ipa篡改检测的方法上会有不足，只能判断一般的篡改手法，比较好的处理方式为判断"cryptid"的值，但我能力有限没找到代码获取该值的方式...如果看到此代码的大神，能够有更好的处理方式，麻烦告知,谢谢🙏

#import "DeviceSafeTool.h"

@implementation DeviceSafeTool

// 常见越狱文件
const char *Jailbreak_Tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

char *printEnv(void){
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}

/** 当前设备是否越狱 */
+ (BOOL)isDeviceJailbreak
{
    // 判断是否存在越狱文件
    for (int i = 0; i < 5; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:Jailbreak_Tool_pathes[i]]]) {
            NSLog(@"此设备越狱!");
            return YES;
        }
    }
    // 判断是否存在cydia应用
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        NSLog(@"此设备越狱!");
        return YES;
    }
    
    // 读取系统所有的应用名称
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        NSLog(@"此设备越狱!");
        return YES;
    }
    
    // 读取环境变量
    if(printEnv()){
        NSLog(@"此设备越狱!");
        return YES;
    }
    
    NSLog(@"此设备没有越狱");
    return NO;
}


/** 文件是否被篡改 */
+ (BOOL)isDocumentHasBeenTamper
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:@"SignerIdentity"] != nil)
    {
        return YES;
    }
    return NO;
}


@end
