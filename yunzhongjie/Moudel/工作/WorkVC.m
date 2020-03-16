//
//  WorkVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkVC.h"
//#import "PowerMannerger.h"
//综合管理
#import "WorkAgentManageVC.h"
#import "StatisticsReportVC.h"
//新房
#import "WorkPhoneConfirmVC.h"
#import "WorkRecommendVC.h"
#import "NewRoomStatisticsVC.h"
//二手房
#import "SecondRoomHouseVC.h"
#import "SecondRoomCustomVC.h"
#import "SecondRoomContractVC.h"
#import "SecondRoomAuditVC.h"
//租房
#import "RentRoomHouseVC.h"
#import "RentRoomCustomVC.h"
#import "RentRoomContractVC.h"
#import "RentRoomAuditVC.h"

#import "BaseHeader.h"
#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_projectArr;
    NSArray *_contentArr;
    NSArray *_headerArr;
    
    NSArray *_showArr;
    NSMutableArray *_powerArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation WorkVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"dimission" object:nil];
//    if ([UserModel defaultModel].agent_company_info_id) {
    
        _imgArr = @[@[@"laifang",@"ys_find"],@[@"recommended",@"client",@"Clinchadeal"],@[@"maintenance",@"paihao",@"contract"],@[@"rotational"]];
      _titleArr = @[@[@"经纪人管理",@"统计报表"],@[@"号码判重",@"新房推荐"],@[@"二手房源",@"二手客源",@"二手合同",]];
//    _titleArr = @[@[@"经纪人管理",@"统计报表"],@[@"号码判重",@"新房推荐",@"新房统计"],@[@"二手房源",@"二手客源",@"二手合同",],@[@"租房房源",@"租房客源",@"租房合同"]];
    _contentArr = @[@[@"",@""],@[@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""]];
//    _headerArr =@[@"综合管理",@"新房",@"二手房",@"租房"];
    _headerArr =@[@"综合管理",@"新房",@"二手房"];

//    }
//    _projectArr = [UserModel defaultModel].project_list;
//    _showArr = [PowerModel defaultModel].WorkListPower;
}


- (void)RequestMethod{
//
//    if ([[UserModel defaultModel].projectinfo count]) {
//
        [BaseRequest GET:MiddleWorkButterCount_URL parameters:@{} success:^(id  _Nonnull resposeObject) {

            [self->_table.mj_header endRefreshing];
            if ([resposeObject[@"code"] integerValue] == 200) {

                //            [UserModel defaultModel].projectPowerDic = resposeObject[@"data"];
                self->_contentArr = @[@[[NSString stringWithFormat:@"待审核%@，在职%@，离职%@",resposeObject[@"data"][@"agent"][@"ex"],resposeObject[@"data"][@"agent"][@"payroll"],resposeObject[@"data"][@"agent"][@"quit"]],@""],@[[NSString stringWithFormat:@"今日新增%@，累计%@，无效%@",resposeObject[@"data"][@"tel_check"][@"value"],resposeObject[@"data"][@"tel_check"][@"total"],resposeObject[@"data"][@"tel_check"][@"disabled"]],[NSString stringWithFormat:@"累计%@，到访%@，无效%@",resposeObject[@"data"][@"recommend_count"],resposeObject[@"data"][@"value"],resposeObject[@"data"][@"valueDisabled"]],@""],@[[NSString stringWithFormat:@"今日勘察%@，累计勘察%@",resposeObject[@"data"][@"house_check"][@"today"],resposeObject[@"data"][@"house_check"][@"total"]],[NSString stringWithFormat:@"今日带看%@，累计带看%@",resposeObject[@"data"][@"house_take"][@"today"],resposeObject[@"data"][@"house_take"][@"total"]],[NSString stringWithFormat:@"今日合同%@，累计合同%@",resposeObject[@"data"][@"house_deal"][@"today"],resposeObject[@"data"][@"house_deal"][@"total"]],@""],@[@"",@"",@"",@""]];
                [self->_table reloadData];
//                [self SetData:resposeObject[@"data"]];

            }else{

                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {

            [self->_table.mj_header endRefreshing];
            [self showContent:@"网路错误"];
        }];
//    }
//
}

- (void)SetData:(NSDictionary *)data{
    
//        for (int i = 0; i < _titleArr.count; i++) {
//
//            [_showArr replaceObjectAtIndex:i withObject:@0];
//            [_powerArr replaceObjectAtIndex:i withObject:@{}];
//        }
        NSLog(@"%@",data);
        NSArray *arr = data[@"app_operate"];
        for (int i = 0 ; i < arr.count; i++) {
    
            for (int j = 0; j < _titleArr.count; j++) {
    
                if ([arr[i][@"type"] containsString:_titleArr[j]]) {
    
//                    [_showArr replaceObjectAtIndex:j withObject:@1];
//                    [_powerArr replaceObjectAtIndex:j withObject:arr[i]];
                }
            }
        }
//
//        if ([data[@"duty_operate"] integerValue] == 1) {
//
//            [_showArr replaceObjectAtIndex:9 withObject:@1];
//        }
//
//        if ([data[@"is_butter"] integerValue] == 1) {
//
//            [_showArr replaceObjectAtIndex:1 withObject:@1];
//            [_showArr replaceObjectAtIndex:2 withObject:@1];
//        }
//
//        if ([data[@"person_check"] integerValue] == 1) {
//
//            [_showArr replaceObjectAtIndex:8 withObject:@1];
//        }
    
    [_table reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {

        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }

    header.titleL.text =_headerArr[section];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([_showArr[indexPath.row] integerValue] == 1) {
    
        return UITableViewAutomaticDimension;
//    }else{
//
//        return 0;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell SetImg:_imgArr[indexPath.section][indexPath.row] title:_titleArr[indexPath.section][indexPath.row] content:_contentArr[indexPath.section][indexPath.row]];
//    if ([_showArr[indexPath.row] integerValue] == 1) {
//
//        cell.hidden = NO;
//    }else{
//
//        cell.hidden = YES;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        if (indexPath.row == 0) {

                WorkAgentManageVC *nextVC = [[WorkAgentManageVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            StatisticsReportVC *nextVC = [[StatisticsReportVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0){
            
            WorkPhoneConfirmVC *nextVC = [[WorkPhoneConfirmVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){
            
            WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            NewRoomStatisticsVC *nextVC = [[NewRoomStatisticsVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            SecondRoomHouseVC *nextVC = [[SecondRoomHouseVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){
            
            SecondRoomCustomVC *nextVC = [[SecondRoomCustomVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){
            
            SecondRoomContractVC *nextVC = [[SecondRoomContractVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            SecondRoomAuditVC *nextVC = [[SecondRoomAuditVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else{
        
        if (indexPath.row == 0) {
            
            RentRoomHouseVC *nextVC = [[RentRoomHouseVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){
            
            RentRoomCustomVC *nextVC = [[RentRoomCustomVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){
            
            RentRoomContractVC *nextVC = [[RentRoomContractVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            RentRoomAuditVC *nextVC = [[RentRoomAuditVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
//    else if(indexPath.row == 3){
//        NSLog(@"1");

//        VisitCustomVC *nextVC = [[VisitCustomVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
//        nextVC.powerDic = [PowerModel defaultModel].visitPower;//_powerArr[3];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
//    else{
//        NSLog(@"1");
//
////
//        AuditTaskVC *nextVC = [[AuditTaskVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
}

- (void)initUI{
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
}
@end

