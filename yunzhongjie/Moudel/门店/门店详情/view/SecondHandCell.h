//
//  SecondHandCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/12/31.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondHandCell : UITableViewCell
typedef void(^BtnBlock)(NSInteger tag);

@property (nonatomic, copy) BtnBlock btnblock;

@property (nonatomic , strong) CountBtn *btn1;
@property (nonatomic , strong) CountBtn *btn2;
@property (nonatomic , strong) CountBtn *btn3;
@property (nonatomic , strong) CountBtn *btn4;
@property (nonatomic , strong) CountBtn *btn5;
@property (nonatomic , strong) CountBtn *btn6;
@property (nonatomic , strong) CountBtn *btn7;
@property (nonatomic , strong) CountBtn *btn8;
@property (nonatomic , strong) CountBtn *btn9;
@property (nonatomic , strong) CountBtn *btn10;
@property (nonatomic , strong) CountBtn *btn11;
@property (nonatomic , strong) CountBtn *btn12;
@property (nonatomic , strong) CountBtn *btn13;
@property (nonatomic , strong) CountBtn *btn14;
@property (nonatomic , strong) CountBtn *btn15;


@end

NS_ASSUME_NONNULL_END
