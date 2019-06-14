//
//  StoreVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreVC.h"
#import "StoreCell.h"
#import "StoreHeader.h"
#import "StoreDetailVC.h"

@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource>
{

    NSArray *_datasource;
//    NSString *_storecount;
//    NSString *_agentcount;
    NSInteger _storecount;
    NSInteger _agentcount;
}

@property (nonatomic, strong) UITableView *table;


@end

@implementation StoreVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Post];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
//    _datasource = @[@"",@"",@""];

    
}

-(void)Post{

    
    _storecount = 0;
    _agentcount = 0;
    [BaseRequest GET:StoreList_URL parameters:@{@"store_id":[UserModel defaultModel].store_id} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
         [self.table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue]==200) {
            _datasource= [self SetData:resposeObject[@"data"]];
            [_table reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

-(NSMutableArray *)SetData:(NSMutableArray *)data
{
    NSMutableArray * arr =  [NSMutableArray array];
    _storecount = data.count;
    for (int i= 0; i<data.count; i++) {
        
        NSDictionary *datadic  =  data[i];
        _agentcount = _agentcount + [datadic[@"agent_num"] integerValue];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:datadic[@"longitude"] forKey:@"longitude"];
        [dic setValue:datadic[@"latitude"] forKey:@"latitude"];
        [dic setValue:datadic[@"store_id"] forKey:@"store_id"];
        [dic setValue:datadic[@"store_name"] forKey:@"store_name"];
        [dic setValue:datadic[@"address"] forKey:@"address"];
        [dic setValue:datadic[@"store_code"] forKey:@"store_code"];
        [dic setValue:datadic[@"store_code"] forKey:@"store_code"];
        [dic setValue:[NSString stringWithFormat:@"%@",datadic[@"contact"]] forKey:@"contact"];
        [dic setValue:[NSString stringWithFormat:@"%@",datadic[@"contact_tel"]] forKey:@"contact_tel"];
//        NSArray *agent = datadic[@"agnet"];
//        if (agent.count>0) {
//            NSString *agent_name = [NSString stringWithFormat:@"店长:%@", agent[0][@"name"]];
//            NSString *agent_tel = [NSString stringWithFormat:@"联系方式:%@", agent[0][@"tel"]];
//            for (int j= 1 ; j<agent.count; j++) {
//                agent_name = [NSString stringWithFormat:@"%@,%@",agent_name,agent[i][@"name"]];
//                agent_tel = [NSString stringWithFormat:@"%@,%@",agent_tel,agent[i][@"tel"]];
//            }
//            [dic setValue:agent_name forKey:@"name"];
//            [dic setValue:agent_tel forKey:@"tel"];
//
//        }
//        else{
//            [dic setValue:[NSString stringWithFormat:@"店长：无"] forKey:@"name"];
//            [dic setValue:[NSString stringWithFormat:@"联系方式：无"] forKey:@"tel"];
//        }
        [arr addObject:dic];
    }
    
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 95*SIZE;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    if (!cell) {
        
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyL.text = _datasource[indexPath.row][@"store_name"];
    cell.adressL.text = _datasource[indexPath.row][@"address"];
    cell.nameL.text = [NSString stringWithFormat:@"负责人：%@",_datasource[indexPath.row][@"contact"]] ;
    cell.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",_datasource[indexPath.row][@"contact_tel"]] ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailVC *next_vc = [[StoreDetailVC alloc]init];
    next_vc.store_id = _datasource[indexPath.row][@"store_id"];
    next_vc.store_code = [NSString stringWithFormat:@"门店编号：%@",_datasource[indexPath.row][@"store_code"]];
    next_vc.store_name =    [NSString stringWithFormat:@"门店名称：%@",_datasource[indexPath.row][@"store_name"]];
    next_vc.store_adress = [NSString stringWithFormat:@"门店地址：%@",_datasource[indexPath.row][@"address"]];
    next_vc.agent_num = [NSString stringWithFormat:@"经纪人总数%ld",_agentcount];
    next_vc.longitude = _datasource[indexPath.row][@"longitude"];
    next_vc.latitude =  _datasource[indexPath.row][@"latitude"];
    next_vc.contact = _datasource[indexPath.row][@"contact"];
    next_vc.contact_tel = _datasource[indexPath.row][@"contact_tel"];
    
    [self.navigationController pushViewController:next_vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25*SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreHeader"];
    if (!header) {
        header = [[StoreHeader alloc]initWithReuseIdentifier: @"StoreHeader"];
    }
    header.storeL.text = [NSString stringWithFormat:@"门店总数:%ld",_storecount];
    header.agentL.text =[NSString stringWithFormat:@"经纪人总数:%ld",_agentcount];
    return header;
    
}

- (void)initUI{
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"门店";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
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
