//
//  MessageSHCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MessageSHCell.h"

@implementation MessageSHCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    if (self.sureBtnBlock) {
        
        self.sureBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"attribute"][@"is_read"] integerValue] == 0) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _titleL.text = @"合同审核";
//     [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]]];
    _nameL.text = [NSString stringWithFormat:@"买家：%@",dataDic[@"client_name"]];
    _projectL.text =  [NSString stringWithFormat:@"合同编号：%@",dataDic[@"deal_code"]];
//    _batchL.text = [NSString stringWithFormat:@"排号批次：%@",dataDic[@"batchInfo"]];
    _roomL.text = [NSString stringWithFormat:@"业主：%@",dataDic[@"owner_name"]];
    _desipotL.text = [NSString stringWithFormat:@"买方佣金：%@",dataDic[@"hosue_type"]];
    _donePriceL.text = [NSString stringWithFormat:@"卖方佣金：%@",dataDic[@"contract_time"]];
    _allPriceL.text = [NSString stringWithFormat:@"成交价：%@万",dataDic[@"deal_money"]];
    _payWayL.text = [NSString stringWithFormat:@"成交时间：%@",dataDic[@"pay_way"]];
    _consultantL.text = [NSString stringWithFormat:@"经纪人：门店-某某：%@",dataDic[@"agent_name"]];
}

- (void)setTitle:(NSString *)title{
    
    _titleL.text = title;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
//    _headImg = [[UIImageView alloc] init];
//    _headImg.image = IMAGE_WITH_NAME(@"laidian");
//    [_whiteView addSubview:_headImg];
    
    _readImg = [[UIImageView alloc] init];
    _readImg.image = IMAGE_WITH_NAME(@"SMS");
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _projectL = label;
                [_whiteView addSubview:_projectL];
                break;
            }
            case 1:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                break;
            }
            case 2:
            {
                _roomL = label;
                [_whiteView addSubview:_roomL];
                break;
            }
            case 3:
            {
                _desipotL = label;
                [_whiteView addSubview:_desipotL];
                break;
            }
            case 4:
            {
                _allPriceL = label;
                [_whiteView addSubview:_allPriceL];
                break;
            }
            case 5:
            {
                _donePriceL = label;
                [_whiteView addSubview:_donePriceL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [_whiteView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _consultantL = label;
                [_whiteView addSubview:_consultantL];
                break;
            }
            default:
                break;
        }
    }
    
    
    _auditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _auditBtn.layer.cornerRadius = 2 *SIZE;
    _auditBtn.layer.borderWidth = SIZE;
    _auditBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    _auditBtn.clipsToBounds = YES;
    _auditBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_auditBtn setTitle:@"审核" forState:UIControlStateNormal];
    [_auditBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [_whiteView addSubview:_auditBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(354 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
//    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
//        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
//        make.width.height.mas_equalTo(51 *SIZE);
//    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(self->_whiteView).offset(63 *SIZE);
//        make.top.equalTo(self->_whiteView).offset(30 *SIZE);
//        make.width.mas_equalTo(200 *SIZE);
        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_readImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-7 *SIZE);
        make.top.equalTo(self->_whiteView).offset(31 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(7 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
//    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
//        make.top.equalTo(self->_batchL.mas_bottom).offset(8 *SIZE);
//        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
//    }];
    
    [_desipotL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_roomL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_allPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_desipotL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_donePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_allPriceL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_donePriceL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_consultantL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_payWayL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
        make.bottom.equalTo(self->_whiteView).offset(-18 *SIZE);
    }];
    
    [_auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-8 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-15 *SIZE);
        make.width.mas_equalTo(73 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}
@end
