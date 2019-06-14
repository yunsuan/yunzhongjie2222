//
//  AgentVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentVC.h"
#import "AgentCell.h"
#import "AgentDetailVC.h"

@interface AgentVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSArray * _datasource;
    NSString* _searchStr;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UISearchBar *searchbar;



@end

@implementation AgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self Post];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _datasource =[NSMutableArray array];
}

-(void)Post
{
    [BaseRequest GET:AgentList_URL
          parameters:@{
                       @"store_id":_store_id
                       }
             success:^(id resposeObject) {
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
    for (int i= 0; i<data.count; i++) {
        NSDictionary *datadic  =  data[i];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:datadic[@"agent_id"] forKey:@"agent_id"];
        [dic setValue:datadic[@"name"] forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"联系方式:%@",datadic[@"tel"]] forKey:@"tel"];
        [dic setValue:[NSString stringWithFormat:@"入职时间:%@",datadic[@"update_time"]] forKey:@"update_time"];
//        [dic setValue:datadic[@"update_time"] forKey:@"update_time"];
        [dic setValue:[NSString stringWithFormat:@"新房排名%d",i+1] forKey:@"count"];
//        [dic setValue:datadic[@"count"] forKey:@"count"];
        [arr addObject:dic];
    }
    return arr;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    _page = @"1";
    _searchStr = searchBar.text;
    [self Post];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.table.allowsSelection=YES;
    self.table.scrollEnabled=YES;
    //    [self.tableDate removeAllObjects];
    //    [self.tableDate addObjectsFromArray:results];
    //    [self.tableView reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
//    _page = @"1";
    _searchStr = @"";
    [self Post];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.table.allowsSelection=YES;
    self.table.scrollEnabled=YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    //     _searchbar.showsCancelButton = YES;
    self.table.allowsSelection=NO;
    self.table.scrollEnabled=NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90*SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgentDetailVC *next_vc = [[AgentDetailVC alloc]init];
    next_vc.store_id = _store_id;
    next_vc.agent_id = _datasource[indexPath.row][@"agent_id"];
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell"];
    if (!cell) {
        
        cell = [[AgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyL.text = _datasource[indexPath.row][@"name"];
    cell.adressL.text = _datasource[indexPath.row][@"tel"];
    cell.newcountL.text = _datasource[indexPath.row][@"count"];
    cell.phoneL.text = _datasource[indexPath.row][@"update_time"];
    
    return cell;
}

- (void)initUI{

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 40*SIZE, SCREEN_Width, SCREEN_Height- NAVIGATION_BAR_HEIGHT  - TAB_BAR_MORE-40*SIZE) style:UITableViewStylePlain];
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
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 40*SIZE)];
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.delegate = self;
//    _searchbar.backgroundImage = [[UIImage alloc] init];
    _searchbar.barTintColor = [UIColor whiteColor];
    _searchbar.backgroundColor = CLBackColor;
    _searchbar.placeholder = @"请输入姓名/电话";
//    _searchbar.showsCancelButton = YES;
    _searchbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchbar];
    
    
}



@end
