//
//  MessageCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}

- (void)ActionSureBtn:(UIButton *)btn{
    
    if (self.messageCellSureBtnBlock) {
        
        self.messageCellSureBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _titelL.text = @"门店认证审核";
    _nameL.text = [NSString stringWithFormat:@"申请人：%@",dataDic[@"agent_name"]];
    _phoneL.text = [NSString stringWithFormat:@"联系电话：%@",dataDic[@"agent_tel"]];
    
//    _companyL.text = [NSString stringWithFormat:@"所属门店：%@",dataDic[@""]];
    _infoL.text = [NSString stringWithFormat:@"申请权限：%@",dataDic[@"role"]];
    if ([dataDic[@"is_store_staff"] integerValue] == 1) {
        
        _isEmL.text = @"是否为本店员工：是";
    }else{
        
        _isEmL.text = @"是否为本店员工：否";
    }
    
    
    
    _timeL.text = [NSString stringWithFormat:@"申请时间：%@",dataDic[@"create_time"]];
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];

    _titelL =[[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 350*SIZE, 14*SIZE)];
    _titelL.text = @"号码判重";
    _titelL.textColor = CLTitleLabColor;
    _titelL.font = FONT(13);
    [self addSubview:_titelL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 30*SIZE, 350*SIZE, 13*SIZE)];
    _phoneL.text = @"客户电话：18381383883";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];


    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 50*SIZE, 350*SIZE, 14*SIZE)];
    _nameL.text = @"姓名：李想";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _infoL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 70*SIZE, 350*SIZE, 13*SIZE)];
    _infoL.text = @"角色：勘察，带看，签约，过户";
    _infoL.font = FONT(12);
    _infoL.textColor = CLContentLabColor;
    [self addSubview:_infoL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 110*SIZE, 350*SIZE, 13*SIZE)];
    _timeL.text = @"失效时间：2019.01.01 17:40";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    _timeL.numberOfLines = 0;
    [self addSubview:_timeL];
    
    _isEmL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 90*SIZE, 350*SIZE, 13*SIZE)];
    _isEmL.text = @"失效时间：2019.01.01 17:40";
    _isEmL.font = FONT(12);
    _isEmL.textColor = CLContentLabColor;
    _isEmL.numberOfLines = 0;
    [self addSubview:_isEmL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 134*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
    _assistBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _assistBtn.frame = CGRectMake(240*SIZE, 75*SIZE, 50*SIZE, 25*SIZE);
    _assistBtn.backgroundColor = CLLoginBtnColor;
    [_assistBtn setTitle:@"复制" forState:UIControlStateNormal];
    _assistBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [_assistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:_assistBtn];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(300*SIZE, 95*SIZE, 50*SIZE, 25*SIZE);
    _sureBtn.backgroundColor = CLLoginBtnColor;
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [_sureBtn addTarget:self action:@selector(ActionSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_sureBtn];
    
}
@end
