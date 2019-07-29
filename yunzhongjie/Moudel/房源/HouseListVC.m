//
//  HouseListVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseListVC.h"
#import "HouseCell.h"
#import "HouseDetail.h"

@interface HouseListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *_datasource;
    NSString *_page;
    NSString *_searchStr;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UISearchBar *searchbar;
@end

@implementation HouseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    _page = @"1";
    _searchStr = @"";
    [self RequestWithPage:@"1"];
}

-(void)RequestWithPage:(NSString *)page
{
    [BaseRequest GET:HouseList_URL
              parameters:@{
                           @"page":page,
                           @"search":_searchStr
                           }
                 success:^(id resposeObject) {
                     NSLog(@"%@",resposeObject);
                     if ([resposeObject[@"code"] integerValue]==200) {
                         if ([page isEqualToString:@"1"]) {
    
    
                             _datasource = [self SetData:resposeObject[@"data"][@"data"]];
                             [_table reloadData];
                             [self.table.mj_footer endRefreshing];
                         }
                         else{
                             NSMutableArray *dataarr =resposeObject[@"data"][@"data"];
                             if (dataarr.count>0) {
                                 [_datasource addObjectsFromArray:[self SetData:dataarr]];
                                  [self.table.mj_footer endRefreshing];
                                 [_table reloadData];
                             }
                             else{
                                  [self.table.mj_footer endRefreshingWithNoMoreData];
                             }
    
                         }
                     }
                     else{
    
                         [self showContent:resposeObject[@"msg"]];
                         [self.table.mj_footer endRefreshing];
    
    
                     }
                     [self.table.mj_header endRefreshing];
                 }
                 failure:^(NSError *error) {
    
                     [self showContent:@"网络错误"];
                      [self.table.mj_footer endRefreshing];
                     [self.table.mj_header endRefreshing];
    
                 }];
}

-(NSMutableArray *)SetData:(NSMutableArray *)data
{
    NSMutableArray * arr =  [NSMutableArray array];
    for (int i= 0; i<data.count; i++) {
        NSDictionary *datadic  =  data[i];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:datadic[@"img_url"] forKey:@"img_url"];
        [dic setValue:datadic[@"absolute_address"] forKey:@"adress"];
        [dic setValue:datadic[@"project_name"] forKey:@"project_name"];
        NSArray *agent = datadic[@"agnet"];
        if (agent.count>0) {
            NSString *agent_name = [NSString stringWithFormat:@"驻场人员:%@", agent[0][@"name"]];
            if(agent.count>1)
            {
            for (int j= 1 ; j<agent.count; j++) {
                agent_name = [NSString stringWithFormat:@"%@,%@",agent_name,agent[j][@"name"]];
            }
            }
            [dic setValue:agent_name forKey:@"agent"];
        }
        else{
            [dic setValue:[NSString stringWithFormat:@"驻场人员：无"] forKey:@"agent"];
        }
        [dic setValue:[NSString stringWithFormat:@"%@",datadic[@"start"]] forKey:@"start"];
        if ([datadic[@"start"] integerValue]==1) {
            [dic setValue:[NSString stringWithFormat:@"%@起",datadic[@"act_start"]] forKey:@"time"];
        }
        else{
            [dic setValue:[NSString stringWithFormat:@"%@-%@",datadic[@"act_start"],datadic[@"act_end"]] forKey:@"time"];
        }
        [dic setValue:datadic[@"project_id"] forKey:@"project_id"];
        [dic setValue:datadic[@"star"] forKey:@"star"];
        [dic setValue:datadic[@"rule_id"] forKey:@"rule_id"];
        [arr addObject:dic];
    }
    
    return arr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseCell"];
    if (!cell) {
        
        cell = [[HouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HouseCell"];
    }
    if (![_datasource[indexPath.row][@"img_url"] isEqualToString:@""]) {
        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_datasource[indexPath.row][@"img_url"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                cell.headerImg.image = [UIImage imageNamed:@"project_def"];
            }
        }];
    }
    else{
        cell.headerImg.image = [UIImage imageNamed:@"project_def"];
    }
    
    cell.companyL.text = _datasource[indexPath.row][@"project_name"];
    cell.adressL.text = _datasource[indexPath.row][@"adress"];
    cell.nameL.text = _datasource[indexPath.row][@"agent"];
    cell.timeL.text = _datasource[indexPath.row][@"time"];
    [cell.levelview SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[_datasource[indexPath.row][@"star"] integerValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseDetail *next_vc = [[HouseDetail alloc]init];
    next_vc.project_id = _datasource[indexPath.row][@"project_id"];
    next_vc.rule_id =_datasource[indexPath.row][@"rule_id"];
    next_vc.start = _datasource[indexPath.row][@"start"];
    
    [self.navigationController pushViewController:next_vc animated:YES];
    
}

-(void)initUI{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0,40*SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT-40*SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        self->_page =@"1";
        [self.table.mj_header beginRefreshing];
        [self RequestWithPage:@"1"];
        
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        NSInteger page = [self->_page integerValue];
        page++;
        self->_page = [NSString stringWithFormat:@"%ld",page];
        [self.table.mj_footer beginRefreshing];
        [self RequestWithPage:self->_page];
    }];

    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 40*SIZE)];
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.delegate = self;
    //    _searchbar.backgroundImage = [[UIImage alloc] init];
    _searchbar.barTintColor = [UIColor whiteColor];
    _searchbar.backgroundColor = CLBackColor;
    _searchbar.placeholder = @"请输入项目名称";
    //    _searchbar.showsCancelButton = YES;
    _searchbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchbar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _page = @"1";
    _searchStr = searchBar.text;
    [self RequestWithPage:_page];
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
    _page = @"1";
    _searchStr = @"";
    [self RequestWithPage:_page];
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


@end
