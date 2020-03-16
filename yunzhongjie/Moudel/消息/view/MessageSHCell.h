//
//  MessageSHCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SureBtnBlock)(NSInteger index);

@interface MessageSHCell : UITableViewCell

@property (nonatomic, copy) SureBtnBlock sureBtnBlock;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *desipotL;

@property (nonatomic, strong) UILabel *allPriceL;

@property (nonatomic, strong) UILabel *donePriceL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *consultantL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UIButton *auditBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
