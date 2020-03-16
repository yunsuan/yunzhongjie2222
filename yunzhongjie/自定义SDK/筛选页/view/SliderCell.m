//
//  SliderCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SliderCell.h"
@interface SliderCell()<TTRangeSliderDelegate>

@end


@implementation SliderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    [self addSubview:self.slider];
    [self addSubview:self.titleLab];
}

-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum
{
    _Slidermodel.minSelectValue = selectedMinimum;
    _Slidermodel.maxSelectValue = selectedMaximum;
    
    if (self.sliderblock != nil && _Slidermodel != nil) {
        self.sliderblock(_Slidermodel);
       }
}

//-(void)SetSliderValueByModel:(SliderModel *)model
//{
//    _slider.maxValue = model.maxValue;
//    _slider.minValue = model.minValue;
//    _slider.maxFormatter = model.maxFormatter;
//    _slider.minFormatter = model.minFormatter;
//    _slider.selectedMinimum = model.minSelectValue;
//    _slider.selectedMaximum = model.maxSelectValue;
//    _titleLab.text = model.title;
//}
//

-(TTRangeSlider *)slider
{
    if (!_slider) {
        _slider = [[TTRangeSlider alloc]initWithFrame:CGRectMake(0, 30*SIZE, 360*SIZE  , 50*SIZE)];
        _slider.delegate = self;
        
    }
    return _slider;
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 340*SIZE, 15*SIZE)];
        _titleLab.textColor = CLTitleLabColor;
        _titleLab.font =[UIFont systemFontOfSize:14*SIZE];
    }
    return _titleLab;
}

-(void)setSlidermodel:(SliderModel *)Slidermodel
{
    _Slidermodel = Slidermodel;
    _slider.maxValue = Slidermodel.maxValue;
    _slider.minValue = Slidermodel.minValue;
    _slider.maxFormatter = Slidermodel.maxFormatter;
    _slider.minFormatter = Slidermodel.minFormatter;
    _slider.selectedMinimum = Slidermodel.minSelectValue;
    _slider.selectedMaximum = Slidermodel.maxSelectValue;
    _titleLab.text = Slidermodel.title;
    
}

@end
