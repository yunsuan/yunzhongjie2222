//
//  SecondRoomContractVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondRoomContractVC.h"
#import "ContractDetailVC.h"
#import "ContractSignListCell.h"

@interface SecondRoomContractVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate>
{
    NSArray *_dataArr;
    NSString *_page;
    NSString *_search;
}
    @property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UITableView *table;


@end

@implementation SecondRoomContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    _search = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SearchMethod:) name:@"protocolSearch" object:nil];
    _dataArr = @[];
    _page =@"1";
    [self postWithpage:_page];
}

- (void)SearchMethod:(NSNotification *)noti{
    
    //    _content = noti.userInfo[@"content"];
    [self postWithpage:_page];
}

-(void)postWithpage:(NSString *)page{
    
    
    
    
//    if (![self isEmpty:self.search]) {
        
//        [dic setObject:self.search forKey:@"search"];
//    }
    [BaseRequest GET: SecondRoomdealList_URL parameters:@{@"page":page,
                                                          @"search":_search
    } success:^(id resposeObject) {
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] ==200) {
            if ([page integerValue]==1) {
                _dataArr = resposeObject[@"data"][@"data"];
                if ([resposeObject[@"data"][@"total"] integerValue]==0||[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });

                }
            }else
            {
                _dataArr = [_dataArr arrayByAddingObjectsFromArray:resposeObject[@"data"][@"data"]];
                if ([_page integerValue]>=[resposeObject[@"data"][@"total"] integerValue]) {
                    dispatch_async(dispatch_get_main_queue(), ^{

                        _table.mj_footer.state = MJRefreshStateNoMoreData;
                    });
                }
            }
            [_table reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContractSignListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContractSignListCell"];
    if (!cell) {
        
        cell = [[ContractSignListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContractSignListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.statusL.text = _dataArr[indexPath.row][@"state_name"];
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContractDetailVC *next_vc = [[ContractDetailVC alloc]init];
    next_vc.deal_id = _dataArr[indexPath.row][@"deal_id"];
    next_vc.state =[_dataArr[indexPath.row][@"need_check"] integerValue];
    next_vc.log_id = _dataArr[indexPath.row][@"log_id"];
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"二手合同";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+40*SIZE, SCREEN_Width, SCREEN_Height-NAVIGATION_BAR_HEIGHT-40*SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.mj_header= [GZQGifHeader headerWithRefreshingBlock:^{
        _page =@"1";
        [self postWithpage:_page];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        NSInteger i = [_page integerValue];
        i++;
        [self postWithpage:[NSString stringWithFormat:@"%ld",(long)i]];
    }];
    
    [self.view addSubview:_table];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (![self isEmpty:textField.text]) {
        
        _search = textField.text;
        _page = @"1";
        [self postWithpage:@"1"];
    }else{
        
        _search = @"";
    }
    return YES;
}


//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    _page = @"1";
//    _search = searchBar.text;
//    [self postWithpage:_page];
//    [searchBar setShowsCancelButton:NO animated:YES];
//    [searchBar resignFirstResponder];
//    self.table.allowsSelection=YES;
//    self.table.scrollEnabled=YES;
//    //    [self.tableDate removeAllObjects];
//    //    [self.tableDate addObjectsFromArray:results];
//    //    [self.tableView reloadData];
//
//}
//
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text=@"";
//    _page = @"1";
//    _search = @"";
//    [self postWithpage:_page];
//    [searchBar setShowsCancelButton:NO animated:YES];
//    [searchBar resignFirstResponder];
//    self.table.allowsSelection=YES;
//    self.table.scrollEnabled=YES;
//}
//
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar setShowsCancelButton:YES animated:YES];
//    //     _searchbar.showsCancelButton = YES;
//    self.table.allowsSelection=NO;
//    self.table.scrollEnabled=NO;
//}

@end
