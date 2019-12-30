//
//  StatisticsReportCompanyCell.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StatisticsReportCompanyCell.h"

@implementation StatisticsReportCompanyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_contentL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(40 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
    }];
}

@end
