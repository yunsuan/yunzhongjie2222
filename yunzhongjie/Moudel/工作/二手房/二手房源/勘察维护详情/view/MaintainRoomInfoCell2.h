//
//  MaintainRoomInfoCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZQFlowLayout.h"

@interface MaintainRoomInfoCell2 : UITableViewCell

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

- (void)SetData:(NSArray *)data;

- (void)SetSelfArr:(NSArray *)data;

//@property (nonatomic, strong) TagView *tagView;

@end
