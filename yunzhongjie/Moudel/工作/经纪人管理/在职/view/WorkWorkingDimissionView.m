//
//  WorkWorkingDimissionView.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkWorkingDimissionView.h"

@implementation WorkWorkingDimissionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self removeFromSuperview];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (_markTV.text.length) {
        
        if (self.workWorkingDimissionViewBlock) {
            
            self.workWorkingDimissionViewBlock();
        }
        [self removeFromSuperview];
    }else{
        
        [MBProgressHUD showError:@"请输入离职原因"];
    }
    
}

- (void)initUI{
    
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    alphaView.userInteractionEnabled = YES;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 206 *SIZE, 250 *SIZE, 137 *SIZE)];
    
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24 *SIZE, 250 *SIZE, 13 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:14 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"离职申请";
    [_whiteView addSubview:label];
    
    _markTV = [[UITextView alloc] initWithFrame:CGRectMake(25 *SIZE, 40 *SIZE, 200 *SIZE, 50 *SIZE)];
    _markTV.keyboardType = UIKeyboardTypeDefault;
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.layer.borderWidth = SIZE;
    _markTV.clipsToBounds = YES;
    _markTV.layer.cornerRadius = 3 *SIZE;
    [_whiteView addSubview:_markTV];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(25 *SIZE, 100 *SIZE, 200 *SIZE, 37 *SIZE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    _recommendBtn.tag = 1;
    [_recommendBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:CLBlueBtnColor];
    [_whiteView addSubview:_recommendBtn];
}

@end
