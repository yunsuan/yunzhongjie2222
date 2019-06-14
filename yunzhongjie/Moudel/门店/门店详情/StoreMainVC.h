//
//  StoreMainVC.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreMainVC : BaseViewController
@property (nonatomic , strong) NSString *store_id;
@property (nonatomic , strong) NSString *store_code;
@property (nonatomic , strong) NSString *store_name;
@property (nonatomic , strong) NSString *store_adress;
@property (nonatomic , strong) NSString *agent_num;
@property (nonatomic , strong) NSString *longitude;
@property (nonatomic , strong) NSString *latitude;
@property (nonatomic , strong) NSString *contact;
@property (nonatomic , strong) NSString *contact_tel;

@end

NS_ASSUME_NONNULL_END
