//
//  ChooseVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2020/1/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ChooseVC.h"
#import "ChooseCell.h"
#import "SliderCell.h"
#import "SliderModel.h"

@interface ChooseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIButton *sureBtn;
@property (nonatomic , strong) UITableView *tableView;

-(void)initUI;
-(void)initDataSouce;

@end

@implementation ChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"搜索条件";
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(action_right) forControlEvents:UIControlEventTouchUpInside];
    [self initUI];
    [self initDataSouce];
}

#pragma mark   ---------      init        --------

-(void)initUI
{
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.tableView];
}

-(void)initDataSouce
{
    
    SliderModel *model = [[SliderModel alloc]init];
    model.title = @"面积";
    model.minValue = 0;
    model.maxValue = 500;
    model.minSelectValue = 0;
    model.maxSelectValue = 500;
    NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
    customFormatter.positiveSuffix = @"㎡";
    model.minFormatter = customFormatter;
    model.maxFormatter = customFormatter;
    
    SliderModel *model2 = [[SliderModel alloc]init];
    model2.title = @"总价";
    model2.minValue = 0;
    model2.maxValue = 1000;
    model2.minSelectValue = 0;
    model2.maxSelectValue =1000;
    NSNumberFormatter *customFormatter2 = [[NSNumberFormatter alloc] init];
    customFormatter2.positiveSuffix = @"万";
    model2.minFormatter = customFormatter2;
    model2.maxFormatter = customFormatter2;
    
    _dataSouse = [@[model,model2] mutableCopy];
    
    
}

#pragma mark   ---------      action        -------

- (void)action_right
{
    [self initDataSouce];
    [self.tableView reloadData];
}

-(void)action_sure
{
    NSLog(@"开始搜索");
    NSLog(@"%@",_dataSouse);
    
    
}

#pragma mark   ---------      delegate        --------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouse.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*SIZE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SliderCell"];
        if (!cell) {
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SliderCell"];
        }
    [cell setSlidermodel:_dataSouse[indexPath.row]];
    WS(weakSelf);
    cell.sliderblock = ^(SliderModel * _Nonnull value) {
        [weakSelf.dataSouse replaceObjectAtIndex:indexPath.row withObject:value];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark   ---------      lazyload        --------
-(UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(0, SCREEN_Height-TAB_BAR_MORE-40*SIZE,360*SIZE,40*SIZE+TAB_BAR_MORE);
        [_sureBtn setTitle:@"开始搜索" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:CLBlueBtnColor];
    }
    return _sureBtn;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_MORE-40*SIZE) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
