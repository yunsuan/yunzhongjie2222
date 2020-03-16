//
//  SliderModel.h
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SliderModel : BaseModel
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign)  float minValue;

@property (nonatomic, assign)  float maxValue;

@property (nonatomic, strong) NSNumberFormatter *minFormatter;

@property (nonatomic, strong) NSNumberFormatter *maxFormatter;

@property (nonatomic, assign)  float minSelectValue;

@property (nonatomic, assign)  float maxSelectValue;


@end

NS_ASSUME_NONNULL_END
