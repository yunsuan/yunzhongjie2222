//
//  SecondRoomHouseCell.h
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondRoomHouseCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *houseL;

@property (nonatomic, strong) UILabel *gradeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *siteL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic , strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
