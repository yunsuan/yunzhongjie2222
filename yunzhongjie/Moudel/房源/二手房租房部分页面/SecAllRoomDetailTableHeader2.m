//
//  SecAllRoomDetailTableHeader2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomDetailTableHeader2.h"

@implementation SecAllRoomDetailTableHeader2

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.secAllRoomDetailMoreBlock) {
        
        _moreBtn.userInteractionEnabled = NO;
        self.secAllRoomDetailMoreBlock();
        _moreBtn.userInteractionEnabled = YES;
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"小区详情 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    //    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(325 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(20 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(13 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(SIZE));
    }];
}

@end
