//
//  PrefixHeader.h
//  易家
//
//  Created by xiaoq on 2017/11/8.
//  Copyright © 2017年 xiaoq. All rights reserved.
//

#ifndef PrefixHeader_pch
#define PrefixHeader_pch


#import "UserModel.h"
//#import "UserInfoModel.h"
#import "UserModelArchiver.h"
//#import "PowerMannerger.h"


#import "NetConfig.h"
#import "BaseRequest.h"


//#import "YBImageBrowser.h"
#import <AFNetworking.h>
#import "MJRefresh.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "MBProgressHUD+GZQ.h"
#import "GZQGifHeader.h"
#import "GZQGifFooter.h"
#import "UIImageView+WebCache.h"

#define YACversion @"1.3.0"
#define LOGINENTIFIER @"logIndentifier"
#define LOGINSUCCESS @"logInSuccessdentifier"


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*self)strongSelf = self;

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

/**
 *  第二部分,关于屏幕尺寸
 */
#define SIZE ([UIScreen mainScreen].bounds.size.width/360)
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define IMAGE_WITH_NAME(x) [UIImage imageNamed:[NSString stringWithFormat:@"%@",x]]

// 状态栏高度
#define STATUS_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
// tabBar高度
#define TAB_BAR_HEIGHT ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
#define TAB_BAR_MORE ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.0 : 0)

//设置字体
#define FONT(a) [UIFont systemFontOfSize:a]

//设置颜色
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green: _G / 255.0f blue:_B / 255.0f alpha:_A]

#define CLBlackColor  [UIColor blackColor]
#define CLBackColor  COLOR(242, 246, 247, 1)
#define CLGreenColor  COLOR(60, 191, 75, 1)
#define CLLoginBtnColor   COLOR(0x1b, 0x80, 0xfe, 1)
#define CLBlueBtnColor   COLOR(27, 152, 255, 1)
#define CLBlueTagColor   COLOR(81, 163, 237, 1)
#define CLBlueBackColor   COLOR(213, 242, 255, 1)
#define CLOrangeColor  COLOR(249, 156, 59, 1)
#define CLYellowColor  COLOR(255, 235, 17, 1)

#define CLTitleLabColor  COLOR(51, 51, 51, 1)
#define CLContentLabColor  COLOR(115, 115, 115, 1)
#define CLPlaceColor  COLOR(217, 208, 208, 1)
#define CLLineColor  COLOR(240, 240, 240, 1)
#define CLLightGrayColor  COLOR(235, 228, 228, 1)
#define CLBorderColor  COLOR(125, 125, 125, 1)

#define CL248Color   COLOR(248, 248, 248, 1)
#define CL240Color   COLOR(240, 240, 240, 1)
#define CL191Color  COLOR(191, 191, 191, 1)
#define CL178Color   COLOR(178, 178, 178, 1)
#define CL170Color   COLOR(170, 170, 170, 1)
#define CL153Color  COLOR(153, 153, 153, 1)
#define CL125Color  COLOR(125, 125, 125, 1)
#define CL102Color  COLOR(102, 102, 102, 1)
#define CL95Color   COLOR(95, 95, 95, 1)
#define CL86Color   COLOR(86, 86, 86, 1)



#define CLWhiteColor  [UIColor whiteColor]
#define CLClearColor [UIColor clearColor]

#endif /* Header_h */
