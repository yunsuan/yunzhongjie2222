//
//  SecondRoomHouseCell.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondRoomHouseCell.h"

@implementation SecondRoomHouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            image =[UIImage imageNamed:@"default_1"];
        }
    }];
        _projectL.text   =  dataDic[@"project_name"];
//        _typeL.text      =  dataDic[@"hide"];
        _statusL.text    =  dataDic[@"state"];
        _propertyL.text  =  dataDic[@"hide"];
        _houseL.text     =  dataDic[@"house_type_id"];
        _gradeL.text     =  dataDic[@"level"];
        _priceL.text     =  dataDic[@"price"];
        _areaL.text      =  dataDic[@"build_area"];
        _siteL.text      =  dataDic[@"store_name"];
        _timeL.text      =  dataDic[@"create_time"];
   
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    _headImg.image = [UIImage imageNamed:@"default"];
       
        _projectL =[[UILabel alloc] init];
        _projectL.textColor = CLTitleLabColor;
        _projectL.font = [UIFont systemFontOfSize:14 *SIZE];
//        _projectL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_projectL];
//        _projectL.text = @"云算大楼";

    
//         _typeL= [[UILabel alloc] init];
//        _typeL.textColor = CL86Color;
//        _typeL.backgroundColor = [UIColor clearColor];
//        _typeL.font = [UIFont systemFontOfSize:10 *SIZE];
//        _typeL.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:_typeL];
//        _typeL.text = @"公盘";

    
        _statusL = [[UILabel alloc] init];
//        _statusL.textColor = CLGreenColor;
//    _statusL.backgroundColor = [UIColor clearColor];
        _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
        _statusL.textAlignment = NSTextAlignmentCenter;
        _statusL.backgroundColor = COLOR(0, 0, 0, 0.3);
        _statusL.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_statusL];
//        _statusL.text = @"有效";
    
        _propertyL= [[UILabel alloc] init];
        _propertyL.textColor = CL86Color;
    _propertyL.backgroundColor = [UIColor clearColor];
        _propertyL.font = [UIFont systemFontOfSize:12 *SIZE];
        _propertyL.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_propertyL];
//        _propertyL.text = @"住宅";

    _houseL = [[UILabel alloc] init];
    _houseL.textColor = CL86Color;
    _houseL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_houseL];
//    _houseL.text = @"2栋2单元 402  3室2厅1厨2卫";
    
    _gradeL = [[UILabel alloc] init];
    _gradeL.textColor = [UIColor redColor];
    _gradeL.textAlignment = NSTextAlignmentRight;
    _gradeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_gradeL];
//    _gradeL.text =@"房源等级：A";

    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = [UIColor redColor];
//    _priceL.textAlignment = NSTextAlignmentRight;
    _priceL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_priceL];
//    _priceL.text =@"120万";
    
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CL86Color;
    _areaL.textAlignment = NSTextAlignmentRight;

    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_areaL];
//    _areaL.text = @"110㎡";
    
    _siteL = [[UILabel alloc] init];
    _siteL.textColor = CLContentLabColor;
    _siteL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_siteL];
//    _siteL.text = @"成都市-高新区-链家门店";

    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
     _timeL.textAlignment = NSTextAlignmentRight;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
//    _timeL.text = @"2018/12/20(2天未跟进)";
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.height.with.mas_equalTo(70 *SIZE);
        make.width.with.mas_equalTo(70 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(90 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-70 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10*SIZE);
        make.top.equalTo(self.contentView).offset(60 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_houseL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(90 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_gradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(_projectL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(90 *SIZE);
        make.top.equalTo(_gradeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
         
         make.right.equalTo(self.contentView).offset(-10 *SIZE);
         make.top.equalTo(_gradeL.mas_bottom).offset(10 *SIZE);
         make.width.mas_equalTo(200 *SIZE);
     }];
     
    [_siteL mas_makeConstraints:^(MASConstraintMaker *make) {
         
         make.left.equalTo(self.contentView).offset(90 *SIZE);
         make.top.equalTo(_areaL.mas_bottom).offset(10 *SIZE);
         make.width.mas_equalTo(200 *SIZE);
     }];
     
    

    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
        make.height.mas_equalTo(0.5*SIZE);
    }];
}

@end
