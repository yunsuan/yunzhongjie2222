//
//  WorkWorkingConfirmAgentCell.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkWorkingConfirmAgentCell.h"

@implementation WorkWorkingConfirmAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.workWorkingConfirmAgentCellBlock) {
        
        self.workWorkingConfirmAgentCellBlock();
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"经纪人：%@",dataDic[@"name"]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",dataDic[@"tel"]];
//    _roleL.text = [NSString stringWithFormat:@"角色：%@",dataDic[@""]];
    _timeL.text = [NSString stringWithFormat:@"入职时间：%@",dataDic[@"entry_time"]];
//    _projectL.text = [NSString stringWithFormat:@"申请项目：%@",dataDic[@""]];
    _storeL.text = [NSString stringWithFormat:@"所属门店：%@",dataDic[@"store_name"]];
}

- (void)setQuitDic:(NSDictionary *)quitDic{
    
    _nameL.text = [NSString stringWithFormat:@"经纪人：%@",quitDic[@"name"]];
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",quitDic[@"tel"]];
    //    _roleL.text = [NSString stringWithFormat:@"角色：%@",dataDic[@""]];
    _timeL.text = [NSString stringWithFormat:@"离职时间：%@",quitDic[@"entry_time"]];
    //    _projectL.text = [NSString stringWithFormat:@"申请项目：%@",dataDic[@""]];
    _storeL.text = [NSString stringWithFormat:@"所属门店：%@",quitDic[@"store_name"]];
}

- (void)initUI{
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
//    _sexImg = [[UIImageView alloc] init];
//    [self.contentView addSubview:_sexImg];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CLTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_phoneL];
    
//    _roleL = [[UILabel alloc] init];
//    _roleL.textColor = CLTitleLabColor;
//    _roleL.font = [UIFont systemFontOfSize:13 *SIZE];
//    [self.contentView addSubview:_roleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
//    _projectL = [[UILabel alloc] init];
//    _projectL.textColor = CLTitleLabColor;
//    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
//    [self.contentView addSubview:_projectL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = CLTitleLabColor;
    _storeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_storeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"审核" forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo (200 *SIZE);
    }];
    
//    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
//        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.width.height.mas_equalTo (12 *SIZE);
//    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo (200 *SIZE);
    }];
    
//    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(12 *SIZE);
//        make.top.equalTo(self->_phoneL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_lessThanOrEqualTo (200 *SIZE);
//    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo (200 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_storeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo (200 *SIZE);
    }];
    
//    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(12 *SIZE);
//        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_lessThanOrEqualTo (200 *SIZE);
//    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
