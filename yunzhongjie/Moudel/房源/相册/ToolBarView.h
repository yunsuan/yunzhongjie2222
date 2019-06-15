//
//  ToolBarView.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBImageBrowserToolBarProtocol.h"



//typedef NS_ENUM(NSInteger, YBImageBrowserToolBarOperationType) {
//    YBImageBrowserToolBarOperationTypeSave,
//    YBImageBrowserToolBarOperationTypeMore,
//    YBImageBrowserToolBarOperationTypeCustom
//};
//
//typedef void(^YBImageBrowserToolBarOperationBlock)(id<YBImageBrowserCellDataProtocol> data);
NS_ASSUME_NONNULL_BEGIN

@interface ToolBarView : UIView<YBImageBrowserToolBarProtocol>
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) CAGradientLayer *gradient;
@property (nonatomic, strong, readonly) UILabel *indexLabel;
@property (nonatomic, strong, readonly) UIButton *operationButton;
@property (nonatomic, strong) UILabel *currentL;
@property (nonatomic, strong) UILabel *allL;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *XGColl;

@end

NS_ASSUME_NONNULL_END
