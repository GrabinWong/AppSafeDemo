//
//  DetectJailbreakTool.h
//  JailbreakDemo
//
//  Created by Grabin on 2017/12/27.
//  Copyright © 2017年 GrabinWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceSafeTool : NSObject

/** 当前设备是否越狱 */
+ (BOOL)isDeviceJailbreak;

/** 文件是否被篡改 */
+ (BOOL)isDocumentHasBeenTamper;

@end
