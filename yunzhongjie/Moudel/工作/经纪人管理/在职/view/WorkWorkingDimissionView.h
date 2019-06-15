//
//  WorkWorkingDimissionView.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkWorkingDimissionViewBlock)(void);

@interface WorkWorkingDimissionView : UIView

@property (nonatomic, copy)  WorkWorkingDimissionViewBlock workWorkingDimissionViewBlock;

@property (nonatomic, strong) UILabel *refuseL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIButton *recommendBtn;

@end

NS_ASSUME_NONNULL_END
