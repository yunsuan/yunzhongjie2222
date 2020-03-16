//
//  ChartVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChartVC.h"
#import "BaseHeader.h"
#import "DateChooseView.h"
#import "SinglePickView.h"
#import "ChartMulBarCell.h"

@interface ChartVC ()<UITableViewDataSource,UITableViewDelegate>
{
//    NSString *_project_id;
//    NSString *_year;
//    NSArray *_titleArr;
//    NSMutableDictionary *_dataDic;
//    NSMutableDictionary *_monthDic;
//    NSMutableDictionary *_yearDic;
//    NSMutableArray *_yearArr;
//    //    NSMutableArray *_monthArr;
//    NSDateFormatter *_formatter;
//    NSDateFormatter *_yearMatter;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation ChartVC

 -(void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}

- (void)initDataSource{
    
//    _status = @"1";
//    _titleArr = @[@"今日统计",@"本月统计",@"累计统计"];
//    _dataDic = [@{} mutableCopy];
//    _monthDic = [@{} mutableCopy];
//    _yearDic = [@{} mutableCopy];
//
//
//    _yearArr = [@[] mutableCopy];
//
//    _formatter = [[NSDateFormatter alloc] init];
//    [_formatter setDateFormat:@"YYYY-MM-dd"];
//
//    _yearMatter = [[NSDateFormatter alloc] init];
//    [_yearMatter setDateFormat:@"YYYY"];
//
//    _year = [_yearMatter stringFromDate:[NSDate date]];
//    for (int i = 0; i < 10; i++) {
//
//        [_yearArr addObject:@{@"param":[NSString stringWithFormat:@"%ld",[_year integerValue] - i],@"id":[NSString stringWithFormat:@"%ld",[_year integerValue] - i]}];
//    }
}
//
//- (void)RequestMethod{
//
//    [BaseRequest GET:ProjectClientCount_URL parameters:@{@"project_id":_project_id,@"sell_count":_status,@"year":_year} success:^(id  _Nonnull resposeObject) {
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if ([self->_status isEqualToString:@"1"]) {
//
//                self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
//            }else if([self->_status isEqualToString:@"2"]) {
//
//                self->_monthDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
//            }else{
//
//                self->_yearDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
//            }
//            [self->_table reloadData];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//        [self showContent:@"网络错误"];
//    }];
//}

//- (void)valueChanged:(UISegmentedControl *)sender{
//
////    NSLog(@"%@",sender.)
//    if (sender.selectedSegmentIndex == 0) {
//
//        _status = @"1";
//        if (!_dataDic.count) {
//
//            [self RequestMethod];
//        }
//        [_table reloadData];
//    }else{
//
//        _status = @"0";
//        if (!_yearDic.count) {
//
//            [self RequestMethod];
//        }
//        [_table reloadData];
//    }
//}


//- (void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index{
//
//    WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section == 2) {
//
//        if ([_status isEqualToString:@"1"]) {
//
//            return [_dataDic[@"company"] count] > 3? 3:[_dataDic[@"company"] count];
//        }else if([_status isEqualToString:@"2"]){
//
//            return [_monthDic[@"company"] count] > 3? 3:[_monthDic[@"company"] count];
//        }else{
//
//            return [_yearDic[@"company"] count] > 3? 3:[_yearDic[@"company"] count];
//        }
//    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        header.titleL.text = @"新房";

        return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        return UITableViewAutomaticDimension;
    }
    return 240 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        ChartMulBarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChartMulBarCell"];
        if (!cell) {
            
            cell = [[ChartMulBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChartMulBarCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataDic:@{}];
        return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
//        ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//        nextVC.index = 0;
//        nextVC.project_id = self->_project_id;
//        if ([self->_status isEqualToString:@"1"]) {
//
//            nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//        }
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    
   
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT ) style:UITableViewStyleGrouped];
//    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}


@end
