//
//  WaitAgentManageVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkWaitAgentManageVC.h"

#import "WorkWaitAgentCell.h"
#import "WorkWorkingDimissionView.h"
//#import "WorkWaitConfirmAgentCell.h"

@interface WorkWaitAgentManageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation WorkWaitAgentManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self RequestMethod];
}

-(void)initDateSouce
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"dimission" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:MiddleAgentGetExlist_URL parameters:dic success:^(id resposeObject) {
        
        [self->_MainTableView.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                self->_MainTableView.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self->_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:MiddleAgentGetExlist_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
                self->_MainTableView.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        else{
            
            self->_page -= 1;
            [self->_MainTableView.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        self->_page -= 1;
        [self->_MainTableView.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_MainTableView reloadData];
}

#pragma mark  ---  delegate   ---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkWaitAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkWaitAgentCell"];
    if (!cell) {
        
        cell = [[WorkWaitAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkWaitAgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.workWaitAgentCellBlock = ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *agree = [UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"remark":@"",@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"id"]],@"type":@"1",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_type"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
        
        UIAlertAction *refuse = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            WorkWorkingDimissionView *view = [[WorkWorkingDimissionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            view.refuseL.text = @"拒绝原因";
            __strong __typeof(&*view)strongView = view;
            view.workWorkingDimissionViewBlock = ^{
                
            
                [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"remark":strongView.markTV.text,@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"id"]],@"type":@"0",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_type"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
                        [self showContent:@"该申请已拒绝"];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:agree];
        [alert addAction:refuse];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
    //    //    if (_dataArr[indexPath.row][@"need_confirm"]) {
    //    //
    //    //        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
    //    //    }else{
    //    //
    //    //        nextVC.needConfirm = @"1";
    //    //    }
    //    //
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initUI
{
    
    
    [self.view addSubview:self.MainTableView];
}


-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
        _MainTableView.backgroundColor = CLBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}

@end
