//
//  ContractDetailVC.h
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//
 
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContractDetailVC : BaseViewController

@property (nonatomic, assign) NSInteger state;

@property (nonatomic , strong) NSString *deal_id;

@property (nonatomic , strong) NSString *log_id;
@end

NS_ASSUME_NONNULL_END

