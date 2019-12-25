//
//  StoreMainRecommendListCell.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/12/17.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreMainRecommendListCellAddBlock)(void);

@interface StoreMainRecommendListCell : UITableViewCell

@property (nonatomic, copy) StoreMainRecommendListCellAddBlock storeMainRecommendListCellAddBlock;

@property (nonatomic , strong) UILabel *titelL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) UILabel *infoL;
@property (nonatomic , strong) UILabel *timeL;
@property (nonatomic , strong) UILabel *statusL;
@property (nonatomic , strong) UILabel *companyL;
@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
