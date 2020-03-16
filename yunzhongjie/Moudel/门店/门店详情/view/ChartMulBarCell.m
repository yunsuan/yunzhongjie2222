//
//  ChartMulBarCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/12/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChartMulBarCell.h"
#import "MutiBarChartView.h"


@interface ChartMulBarCell ()

@property (nonatomic, strong) MutiBarChartView *mutiBarChartView;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, assign) NSInteger level;
@end

@implementation ChartMulBarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    

        _mutiBarChartView.xValuesArr = [@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"] mutableCopy];

    _mutiBarChartView.barWidth = 10;
    _mutiBarChartView.yAxiasValus= 2;
        _mutiBarChartView.yValuesArr = @[@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"],@[@"3",@"6",@"9"]];
    
    _mutiBarChartView.gapWidth = 10;
    _mutiBarChartView.yAxiasCount = 5;
    _mutiBarChartView.unit= @"个";
    _mutiBarChartView.  showEachYValus =  NO;
    _mutiBarChartView.legendTitlesArr = @[@"推荐客户",@"来访客户",@"成交客户"];


}

- (void)initUI{
    
    _mutiBarChartView = [[MutiBarChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 240 *SIZE)];
    _mutiBarChartView.backgroundColor = CLWhiteColor;
    //    barChartView.yScaleValue=60;
    _mutiBarChartView.barColorArr = [CLArr mutableCopy];
    [self.contentView addSubview:_mutiBarChartView];
}

@end
