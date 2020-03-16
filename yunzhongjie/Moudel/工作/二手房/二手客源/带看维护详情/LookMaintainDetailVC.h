//
//  LookMaintainDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookMaintainDetailVCBlock)(void);

@interface LookMaintainDetailVC : BaseViewController

@property (nonatomic, copy) LookMaintainDetailVCBlock lookMaintainDetailVCBlock;

@property (nonatomic, strong) NSString *edit;
@property (nonatomic, strong) NSString *agent;
//@property (nonatomic, strong) NSString *surveyId;

- (instancetype)initWithTakeId:(NSString *)takeId;

@end

NS_ASSUME_NONNULL_END
