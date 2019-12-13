//
//  CustomerListCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomerListCell.h"

@implementation CustomerListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.customerListCellAddBlock) {
        
        self.customerListCellAddBlock();
    }
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    _titelL =[[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 350*SIZE, 14*SIZE)];
//    _titelL.text = @"号码判重";
    _titelL.textColor = CLTitleLabColor;
    _titelL.font = FONT(13);
    [self addSubview:_titelL];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 30*SIZE, 350*SIZE, 14*SIZE)];
//    _nameL.text = @"姓名：李想";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 50*SIZE, 350*SIZE, 13*SIZE)];
//    _phoneL.text = @"客户电话：18381383883";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 70*SIZE, 350*SIZE, 13*SIZE)];
//    _timeL.text = @"失效时间：2019.01.01 17:40";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    [self addSubview:_timeL];
    
    _infoL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 90*SIZE, 350*SIZE, 13*SIZE)];
    //    _timeL.text = @"失效时间：2019.01.01 17:40";
    _infoL.font = FONT(12);
    _infoL.textColor = CLContentLabColor;
    [self addSubview:_infoL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(270 *SIZE, 85 *SIZE, 70 *SIZE, 23 *SIZE);
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"转成交" forState:UIControlStateNormal];
    _addBtn.hidden = YES;
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.clipsToBounds = YES;
    [_addBtn setBackgroundColor:CLBlueBtnColor];
    [self.contentView addSubview:_addBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 114*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    

}

@end
