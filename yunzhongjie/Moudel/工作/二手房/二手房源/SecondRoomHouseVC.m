//
//  SecondRoomHouseVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondRoomHouseVC.h"

#import "SecondRoomHouseCell.h"
#import "MaintainDetailVC.h"

@interface SecondRoomHouseVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
{
    
    NSMutableArray *_dataArr;
    NSString *_page;
    NSString *_search;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;
@end

@implementation SecondRoomHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    _search = @"";
    [self postWithpage:@"1"];
}

-(void)postWithpage:(NSString *)page{
    
    [BaseRequest GET:SecondRoomHouseList_URL
              parameters:@{
                           @"page":page,
                           @"search":_search
                           }
                 success:^(id resposeObject) {
                     NSLog(@"%@",resposeObject);
                     if ([resposeObject[@"code"] integerValue]==200) {
                         if ([page isEqualToString:@"1"]) {
    
    
                             _dataArr = [self SetData:resposeObject[@"data"][@"data"]];
                             [_table reloadData];
                             [self.table.mj_footer endRefreshing];
                         }
                         else{
                             NSMutableArray *dataarr =resposeObject[@"data"][@"data"];
                             if (dataarr.count>0) {
                                 [_dataArr addObjectsFromArray:[self SetData:dataarr]];
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
        [dic setValue:datadic[@"survey_id"] forKey:@"survey_id"];
        [dic setValue:datadic[@"house_id"] forKey:@"house_id"];
        [dic setValue:datadic[@"type"] forKey:@"type"];
        [dic setValue:datadic[@"img_url"] forKey:@"img_url"];
        [dic setValue:datadic[@"project_name"] forKey:@"project_name"];
        if ([datadic[@"hide"] integerValue]==0) {
            [dic setValue:@"公盘" forKey:@"hide"];
        }
        else if ([datadic[@"hide"] integerValue]==2)
        {
            [dic setValue:@"共享盘" forKey:@"hide"];
        }
        else{
            [dic setValue:@"私盘" forKey:@"hide"];
        }
        
        [dic setValue:datadic[@"state"] forKey:@"state"];
        [dic setValue:datadic[@"property_type"] forKey:@"property_type"];
        [dic setValue:datadic[@"house_type_id"] forKey:@"house_type_id"];
        [dic setValue:[NSString stringWithFormat:@"房源等级：%@",datadic[@"level"]] forKey:@"level"];
        [dic setValue:[NSString stringWithFormat:@"%@万",datadic[@"price"]] forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@㎡",datadic[@"build_area"]] forKey:@"build_area"];
        
        [dic setValue:[NSString stringWithFormat:@"%@/%@",datadic[@"store_name"],datadic[@"agent_name"]] forKey:@"store_name"];
        [dic setValue:datadic[@"create_time"] forKey:@"create_time"];
         [dic setValue:[NSString stringWithFormat:@"经纪人：%@",datadic[@"agent_name"]] forKey:@"agent"];
        [arr addObject:dic];
    }
    [self.table reloadData];
    return arr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondRoomHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondRoomHouseCell"];
    if (!cell) {
        
        cell = [[SecondRoomHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondRoomHouseCell"];
    }
    [cell setDataDic:_dataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     MaintainDetailVC *nextVC = [[MaintainDetailVC alloc] initWithSurveyId:_dataArr[indexPath.row][@"survey_id"] houseId:_dataArr[indexPath.row][@"house_id"] type:[_dataArr[indexPath.row][@"type"] integerValue] ];
    nextVC.edit = NO;
    nextVC.agent =_dataArr[indexPath.row][@"agent"];
    nextVC.maintainDetailVCBlock = ^{
            [self postWithpage:_page];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
    
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




- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"二手房源";
    
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
        _page =[NSString stringWithFormat:@"%ld",(long)i];
    [self postWithpage:[NSString stringWithFormat:@"%ld",(long)i]];
    }];
        
    [self.view addSubview:_table];
}

@end
