//
//  WorkWaitConfirmAgentCell.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkWaitConfirmAgentCellBlock)(void);

@interface WorkWaitConfirmAgentCell : UITableViewCell

@property (nonatomic, copy) WorkWaitConfirmAgentCellBlock workWaitConfirmAgentCellBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
