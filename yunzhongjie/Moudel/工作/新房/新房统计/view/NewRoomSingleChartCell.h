//
//  NewRoomSingleChartCell.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SingleBarChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomSingleChartCell : UITableViewCell

@property (nonatomic, strong) SingleBarChartView *singleBarChartView;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
