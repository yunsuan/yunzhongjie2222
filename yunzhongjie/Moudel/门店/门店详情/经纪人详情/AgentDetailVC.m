//
//  AgentDetailVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentDetailVC.h"
#import "StoreCountHeader.h"
#import "StoreCountCell.h"
#import "SecondHandCell.h"

@interface AgentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    //    NSArray *_datasource;
    NSMutableArray *_secondArr;
    NSMutableArray *_rentArr;
    NSMutableArray *_countArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation AgentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self Post];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _countArr = [@[@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"}] mutableCopy];
    
    _rentArr = [@[@{@"title":@"新增客户",@"content":@"7"},@{@"title":@"新增客户",@"content":@"3"},@{@"title":@"新增客户",@"content":@"2"},@{@"title":@"回访客户",@"content":@"2"},@{@"title":@"回访客户",@"content":@"1"},@{@"title":@"回访客户",@"content":@"1"},@{@"title":@"新增房源",@"content":@"6"},@{@"title":@"新增房源",@"content":@"4"},@{@"title":@"新增房源",@"content":@"0"},@{@"title":@"房源维护",@"content":@"5"},@{@"title":@"房源维护",@"content":@"2"},@{@"title":@"房源维护",@"content":@"1"},@{@"title":@"成交套数",@"content":@"2"},@{@"title":@"成交套数",@"content":@"1"},@{@"title":@"成交套数",@"content":@"1"}] mutableCopy];
    _secondArr=
    [@[@{@"title":@"新增客户",@"content":@"7"},@{@"title":@"新增客户",@"content":@"3"},@{@"title":@"新增客户",@"content":@"2"},@{@"title":@"回访客户",@"content":@"2"},@{@"title":@"回访客户",@"content":@"1"},@{@"title":@"回访客户",@"content":@"1"},@{@"title":@"新增房源",@"content":@"6"},@{@"title":@"新增房源",@"content":@"4"},@{@"title":@"新增房源",@"content":@"0"},@{@"title":@"房源维护",@"content":@"5"},@{@"title":@"房源维护",@"content":@"2"},@{@"title":@"房源维护",@"content":@"1"},@{@"title":@"成交套数",@"content":@"2"},@{@"title":@"成交套数",@"content":@"1"},@{@"title":@"成交套数",@"content":@"1"}] mutableCopy];
}

-(void)Post{
    [BaseRequest GET:AgentDetail_URL
          parameters:@{
                       @"store_id":_store_id,
                       @"agent_id":_agent_id
                       }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue]==200) {
                     NSLog(@"%@",resposeObject);
                     [self SetDataBydata:resposeObject[@"data"]];
                 }
                 else{
                     [self showContent:resposeObject[@"msg"]];
                 }
                 [self.table.mj_header endRefreshing];
             }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
                 [self.table.mj_header endRefreshing];
             }];
}

-(void)SetDataBydata:(NSDictionary *)datadic
{
    _countArr = [@[@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"recommend"][@"all"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"recommend"][@"month"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"recommend"][@"day"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"visit"][@"all"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"visit"][@"month"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"visit"][@"day"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"new"][@"deal"][@"all"]]},@{@"title":@"成交客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"new"][@"deal"][@"month"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"new"][@"deal"][@"day"]]}] mutableCopy];
    
    _secondArr =
       [@[@{@"title":@"新增客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take"][@"all"]]},@{@"title":@"新增客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take"][@"month"]]},@{@"title":@"新增客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take"][@"day"]]},@{@"title":@"回访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take_follow"][@"all"]]},@{@"title":@"回访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take_follow"][@"month"]]},@{@"title":@"回访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_take_follow"][@"day"]]},@{@"title":@"新增房源",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_house"][@"all"]]},@{@"title":@"新增房源",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_house"][@"month"]]},@{@"title":@"新增房源",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_house"][@"day"]]},@{@"title":@"房源维护",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_survey"][@"all"]]},@{@"title":@"房源维护",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_survey"][@"month"]]},@{@"title":@"房源维护",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_survey"][@"day"]]},@{@"title":@"成交套数",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_deal"][@"all"]]},@{@"title":@"成交套数",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_deal"][@"month"]]},@{@"title":@"成交套数",@"content":[NSString stringWithFormat:@"%@",datadic[@"house_deal"][@"day"]]}] mutableCopy];
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section ==0) {
        return 210*SIZE;

    }
    else{
        return 350*SIZE;
    }
        
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 0) {

                StoreCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCountCell"];
                if (!cell) {
                    cell = [[StoreCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCountCell"];
                }
                [cell.btn1 SettitleL:_countArr[0][@"title"] contentL:_countArr[0][@"content"]];
                [cell.btn2 SettitleL:_countArr[1][@"title"] contentL:_countArr[1][@"content"]];
                [cell.btn3 SettitleL:_countArr[2][@"title"] contentL:_countArr[2][@"content"]];
                [cell.btn4 SettitleL:_countArr[3][@"title"] contentL:_countArr[3][@"content"]];
                [cell.btn5 SettitleL:_countArr[4][@"title"] contentL:_countArr[4][@"content"]];
                [cell.btn6 SettitleL:_countArr[5][@"title"] contentL:_countArr[5][@"content"]];
                [cell.btn7 SettitleL:_countArr[6][@"title"] contentL:_countArr[6][@"content"]];
                [cell.btn8 SettitleL:_countArr[7][@"title"] contentL:_countArr[7][@"content"]];
                [cell.btn9 SettitleL:_countArr[8][@"title"] contentL:_countArr[8][@"content"]];
        //        cell.btnblock = ^(NSInteger tag) {
        //            NSLog(@"tag = %ld",tag);
        //            [self btntouch:tag];
         
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
    }
    else if(indexPath.section == 1){
            SecondHandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondHandCell"];
            if (!cell) {
                cell = [[SecondHandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondHandCell"];
            }
             [cell.btn1 SettitleL:_secondArr[0][@"title"] contentL:_secondArr[0][@"content"]];
            [cell.btn2 SettitleL:_secondArr[1][@"title"] contentL:_secondArr[1][@"content"]];
            [cell.btn3 SettitleL:_secondArr[2][@"title"] contentL:_secondArr[2][@"content"]];
            [cell.btn4 SettitleL:_secondArr[3][@"title"] contentL:_secondArr[3][@"content"]];
            [cell.btn5 SettitleL:_secondArr[4][@"title"] contentL:_secondArr[4][@"content"]];
            [cell.btn6 SettitleL:_secondArr[5][@"title"] contentL:_secondArr[5][@"content"]];
            [cell.btn7 SettitleL:_secondArr[6][@"title"] contentL:_secondArr[6][@"content"]];
            [cell.btn8 SettitleL:_secondArr[7][@"title"] contentL:_secondArr[7][@"content"]];
            [cell.btn9 SettitleL:_secondArr[8][@"title"] contentL:_secondArr[8][@"content"]];
             [cell.btn10 SettitleL:_secondArr[9][@"title"] contentL:_secondArr[9][@"content"]];
             [cell.btn11 SettitleL:_secondArr[10][@"title"] contentL:_secondArr[10][@"content"]];
             [cell.btn12 SettitleL:_secondArr[11][@"title"] contentL:_secondArr[11][@"content"]];
            [cell.btn13 SettitleL:_secondArr[12][@"title"] contentL:_secondArr[12][@"content"]];
            [cell.btn14 SettitleL:_secondArr[13][@"title"] contentL:_secondArr[13][@"content"]];
            [cell.btn15 SettitleL:_secondArr[14][@"title"] contentL:_secondArr[14][@"content"]];
            
            cell.btnblock = ^(NSInteger tag) {
                NSLog(@"tag = %ld",tag);
    //            [self btntouch:tag];
            };
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            SecondHandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondHandCell"];
                   if (!cell) {
                       cell = [[SecondHandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondHandCell"];
                   }
                    [cell.btn1 SettitleL:_secondArr[0][@"title"] contentL:_secondArr[0][@"content"]];
                   [cell.btn2 SettitleL:_secondArr[1][@"title"] contentL:_secondArr[1][@"content"]];
                   [cell.btn3 SettitleL:_secondArr[2][@"title"] contentL:_secondArr[2][@"content"]];
                   [cell.btn4 SettitleL:_secondArr[3][@"title"] contentL:_secondArr[3][@"content"]];
                   [cell.btn5 SettitleL:_secondArr[4][@"title"] contentL:_secondArr[4][@"content"]];
                   [cell.btn6 SettitleL:_secondArr[5][@"title"] contentL:_secondArr[5][@"content"]];
                   [cell.btn7 SettitleL:_secondArr[6][@"title"] contentL:_secondArr[6][@"content"]];
                   [cell.btn8 SettitleL:_secondArr[7][@"title"] contentL:_secondArr[7][@"content"]];
                   [cell.btn9 SettitleL:_secondArr[8][@"title"] contentL:_secondArr[8][@"content"]];
                    [cell.btn10 SettitleL:_secondArr[9][@"title"] contentL:_secondArr[9][@"content"]];
                    [cell.btn11 SettitleL:_secondArr[10][@"title"] contentL:_secondArr[10][@"content"]];
                    [cell.btn12 SettitleL:_secondArr[11][@"title"] contentL:_secondArr[11][@"content"]];
                   [cell.btn13 SettitleL:_secondArr[12][@"title"] contentL:_secondArr[12][@"content"]];
                   [cell.btn14 SettitleL:_secondArr[13][@"title"] contentL:_secondArr[13][@"content"]];
                   [cell.btn15 SettitleL:_secondArr[14][@"title"] contentL:_secondArr[14][@"content"]];
                   cell.selectionStyle = UITableViewCellSelectionStyleNone;
                   return cell;
        }
    

}

-(void)btntouch:(NSInteger )tag
{
    //    NSString *end_time = [self gettime:[NSDate date]];
    NSString *end_time = @"";
    NSString *start_time = @"";
    NSString *type = @"store_id";
    NSString *url = StoreDealCustomerList_URL;
    //    NSTimeInterval month = 24 * 60 * 60 *30;
    if (tag/10 == 0) {
        //        type = @"0";
        NSString *url = StoreRecommendCustomerList_URL;
        if (tag==0) {
            
        }
        else if(tag == 1)
        {
            
            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];
            
            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    else if(tag/10 == 1){
        //        type = @"1";
        url = StoreVisitCustomerList_URL;
        
        if (tag==10) {
            
        }
        else if(tag == 11)
        {
            
            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:1 withObject:@"01"];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];
            
            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    else{
        
        if (tag==20) {
            
        }
        else if(tag == 21)
        {
            
            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:1 withObject:@"01"];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];
            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    
//    CustomerListVC *next_vc = [[CustomerListVC alloc]init];
//    next_vc.urlStr = url;
//    next_vc.type = type;
//    next_vc.need_id = self.store_id;
//    next_vc.end_time = end_time;
//    next_vc.start_time = start_time;
//    [self.navigationController pushViewController:next_vc animated:YES];
    
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if(section ==0)
//        return 85*SIZE;
//    else
        return 35*SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
        StoreCountHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreCountHeader"];
        if (!header) {
            header = [[StoreCountHeader alloc]initWithReuseIdentifier: @"StoreCountHeader"];
         
        }
    if (section==0) {
        header.titelL.text = @"新房";
        header.countL.text = _agent_count;
    }
    else if (section == 1)
    {
        header.titelL.text = @"二手房";
        header.countL.text = @"二手房排名：1";
        
    }
    else{
        header.titelL.text = @"租房";
        header.countL.text = @"租房排名：2";
    }
        
        
        return header;
//    }
}

- (void)initUI{
    self.navBackgroundView.hidden = NO;
//    self.leftButton.hidden = YES;
    self.titleLabel.text = @"经纪人详情";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    //    _table.rowHeight = UITableViewAutomaticDimension;
    //    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        //        self->_page =@"1";
        [self.table.mj_header beginRefreshing];
        [self Post];
        
    }];
    
}


@end
