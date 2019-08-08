//
//  CustomerListVC.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomerListVCBlock)(void);

@interface CustomerListVC : BaseViewController

@property (nonatomic, copy) CustomerListVCBlock customerListVCBlock;

@property (nonatomic , strong) NSString *need_id;
@property (nonatomic , strong) NSString *urlStr;
@property (nonatomic , strong) NSString *start_time;
@property (nonatomic , strong) NSString *end_time;
@property (nonatomic , strong) NSString *type;
@property (nonatomic, strong) NSString *project_id;
//@property (nonatomic , strong) NSString *Mtype;


@end

NS_ASSUME_NONNULL_END
