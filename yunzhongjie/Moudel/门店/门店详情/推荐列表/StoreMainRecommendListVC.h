//
//  StoreMainRecommendListVC.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/12/17.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreMainRecommendListVCBlock)(void);

@interface StoreMainRecommendListVC : BaseViewController

@property (nonatomic, copy) StoreMainRecommendListVCBlock storeMainRecommendListVCBlock;

@property (nonatomic , strong) NSString *need_id;
@property (nonatomic , strong) NSString *urlStr;
@property (nonatomic , strong) NSString *start_time;
@property (nonatomic , strong) NSString *end_time;
@property (nonatomic , strong) NSString *type;
@property (nonatomic, strong) NSString *project_id;

@end

NS_ASSUME_NONNULL_END
