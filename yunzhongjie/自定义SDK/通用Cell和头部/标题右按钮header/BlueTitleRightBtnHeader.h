//
//  BlueTitleRightBtnHeader.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlueTitleRightBtnHeaderBlock)(void);

@interface BlueTitleRightBtnHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, copy) BlueTitleRightBtnHeaderBlock blueTitleRightBtnHeaderBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
