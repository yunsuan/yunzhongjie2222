//
//  LookMaintainCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainCell.h"

@implementation LookMaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeL.text = [NSString stringWithFormat:@"客源编号：%@",dataDic[@"take_code"]];
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"name"]];
    
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _genderImg.image = [UIImage imageNamed:@"man"];
    }else if ([dataDic[@"sex"] integerValue] == 1){
        
        _genderImg.image = [UIImage imageNamed:@"girl"];
    }else{
        
        _genderImg.image = [UIImage imageNamed:@""];
    }
    _phoneL.text = [NSString stringWithFormat:@"客户来源：%@-%@",dataDic[@"source"],dataDic[@"get_way"]];
    
    if ([dataDic[@"property_type"] length] ) {
        
        _contentL.text = dataDic[@"property_type"];
    }
    if (dataDic[@"price_max"]) {
        
        _contentL.text = [NSString stringWithFormat:@"%@,%@-%@万",_contentL.text,dataDic[@"price_min"],dataDic[@"price_max"]];
    }
    
    if (dataDic[@"area_max"] ) {
        
        _contentL.text = [NSString stringWithFormat:@"%@,%@-%@㎡",_contentL.text,dataDic[@"area_min"],dataDic[@"area_max"]];
    }
    

    _customL.text = [NSString stringWithFormat:@"客户等级：%@",dataDic[@"client_level"]];
    _matchL.text = [NSString stringWithFormat:@"带看进度：%@",dataDic[@"current_state"]];
    _numL.text = [NSString stringWithFormat:@"带看次数：%@",dataDic[@"house_take_num"]];
    _progressL.text = [NSString stringWithFormat:@"经纪人：%@",dataDic[@"butter_name"]];
    NSString *str = [NSString stringWithFormat:@"登记时间：%@",dataDic[@"create_time"]];
     str = [str substringWithRange:NSMakeRange(0, 15)];
    _timeL.text = str;
    
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CLTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_codeL];
//    _codeL.text =@"客源编号:z24347892423";
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CL86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
//    _nameL.text =@"客户姓名:张三";
    
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    _genderImg.image = [UIImage imageNamed:@"girl"];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CL86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_phoneL];
//    _phoneL.text =@"客户来源：自行添加？";
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CL86Color;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contentL];
//    _contentL.text = @"商铺,0-100万，0-99㎡";
    
    _customL = [[UILabel alloc] init];
    _customL.textColor = CL86Color;
    _customL.textAlignment = NSTextAlignmentRight;
    _customL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_customL];
//    _customL.text =@"客户等级：A";
    
    _matchL = [[UILabel alloc] init];
    _matchL.textColor = CL86Color;
    _matchL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_matchL];
//    _matchL.text =@"带看进度：复看";
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = CL86Color;
    _numL.textAlignment = NSTextAlignmentRight;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
//    _numL.text =@"超期时间：2019/02/01？";
    
    _progressL = [[UILabel alloc] init];
    _progressL.textColor = CL86Color;
    _progressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_progressL];
//    _progressL.text =@"归属人：张三";
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CL86Color;
    _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
//    _timeL.text =@"登记时间：2019/02/01";
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nameL.mas_right).offset(6 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(15 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_matchL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_customL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_progressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_matchL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_matchL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_progressL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
