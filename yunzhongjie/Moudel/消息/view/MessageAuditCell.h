//
//  MessageAuditCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MessageAuditCellSureBtnBlock)(NSInteger index);

@interface MessageAuditCell : UITableViewCell

@property (nonatomic, copy) MessageAuditCellSureBtnBlock messageAuditCellSureBtnBlock;

@property (nonatomic , strong) UILabel *titelL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) UILabel *infoL;
@property (nonatomic , strong) UILabel *timeL;
@property (nonatomic , strong) UIButton *assistBtn;
@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
