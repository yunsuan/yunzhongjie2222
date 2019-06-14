//
//  StoreMainVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreMainVC.h"
#import "StoreMannerCell.h"
#import "StoreInfoHeader.h"
#import "StoreCountHeader.h"
#import "StoreCountCell.h"
#import "CustomerListVC.h"


@interface StoreMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
//    NSArray *_datasource;
    NSMutableArray *_countArr;
}


@property (nonatomic, strong) UITableView *table;

@end

@implementation StoreMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self Post];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
        _countArr = [@[@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"}] mutableCopy];
}

-(void)Post{
    [BaseRequest GET:StoreDetail_URL
          parameters:@{
                    @"store_id":_store_id
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
     _countArr = [@[@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"all"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"month"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"day"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"all"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"month"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"day"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"all"]]},@{@"title":@"成交客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"deal"][@"month"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"day"]]}] mutableCopy];
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return 1;
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 64*SIZE;
    }
    else{
        return 210*SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        StoreMannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreMannerCell"];
        if (!cell) {
            cell = [[StoreMannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreMannerCell"];
            cell.nameL.text = _contact;
            cell.phoneL.text = _contact_tel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
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
        cell.btnblock = ^(NSInteger tag) {
            NSLog(@"tag = %ld",tag);
            [self btntouch:tag];
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSString *phone = _contact_tel;
        if (phone.length) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
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
    
    CustomerListVC *next_vc = [[CustomerListVC alloc]init];
    next_vc.urlStr = url;
    next_vc.type = type;
    next_vc.need_id = self.store_id;
    next_vc.end_time = end_time;
    next_vc.start_time = start_time;
    [self.navigationController pushViewController:next_vc animated:YES];
    
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section ==0)
        return 85*SIZE;
    else
        return 40*SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        StoreInfoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreInfoHeader"];
        if (!header) {
            header = [[StoreInfoHeader alloc]initWithReuseIdentifier: @"StoreInfoHeader"];
            header.storenumL.text = _store_code;
            header.storenameL.text =_store_name;
            header.storeadressL.text = _store_adress;
            header.peoplenumL.text = _agent_num;
            header.latitude = _latitude;
            header.longitude = _longitude;
            
        }
//        cell set
        return header;
    }else{
        StoreCountHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreCountHeader"];
        if (!header) {
            header = [[StoreCountHeader alloc]initWithReuseIdentifier: @"StoreCountHeader"];
        
        }
        
        return header;
    }
}

- (void)initUI{

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
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
