//
//  MessageCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MessageCellSureBtnBlock)(NSInteger index);

@interface MessageCell : UITableViewCell

@property (nonatomic, copy) MessageCellSureBtnBlock messageCellSureBtnBlock;

@property (nonatomic , strong) UILabel *titelL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) UILabel *infoL;
@property (nonatomic , strong) UILabel *timeL;
@property (nonatomic , strong) UILabel *isEmL;
@property (nonatomic , strong) UILabel *companyL;
@property (nonatomic , strong) UIButton *assistBtn;
@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
