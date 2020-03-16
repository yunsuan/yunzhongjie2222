//
//  SliderCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRangeSlider.h"
#import "SliderModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^Sliderblock)(SliderModel * value);

@interface SliderCell : UITableViewCell
@property (nonatomic , strong) Sliderblock sliderblock;
@property (nonatomic , strong) TTRangeSlider *slider;
@property (nonatomic , strong) UILabel* titleLab;
@property (nonatomic , strong) SliderModel* Slidermodel;

@end

NS_ASSUME_NONNULL_END
