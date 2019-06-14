//
//  WorkWorkingAgentManageVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/6/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkWorkingAgentManageVC.h"

//#import "WorkWaitAgentCell.h"
#import "WorkWorkingDimissionView.h"
#import "WorkWorkingConfirmAgentCell.h"

@interface WorkWorkingAgentManageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation WorkWorkingAgentManageVC

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
    [BaseRequest GET:AgentGetPayrollList_URL parameters:dic success:^(id resposeObject) {
        
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
    [BaseRequest GET:AgentGetPayrollList_URL parameters:dic success:^(id resposeObject) {
        
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
    
    WorkWorkingConfirmAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkWorkingConfirmAgentCell"];
    if (!cell) {
        
        cell = [[WorkWorkingConfirmAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkWorkingConfirmAgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    [cell.confirmBtn setTitle:@"离职" forState:UIControlStateNormal];
    [cell.confirmBtn setBackgroundColor:CLLightGrayColor];
    
    cell.workWorkingConfirmAgentCellBlock = ^{
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"离职" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *store = [UIAlertAction actionWithTitle:@"仅离职门店" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            WorkWorkingDimissionView *view = [[WorkWorkingDimissionView alloc] initWithFrame:self.view.frame];
            __strong __typeof(&*view)strongView = view;
            view.workWorkingDimissionViewBlock = ^{
                
                [_dataArr removeObjectAtIndex:indexPath.row];
                [_MainTableView reloadData];
                [BaseRequest POST:MiddleAgentQuit_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"remarks":strongView.markTV.text,@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"id"]],@"type":@"1"} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            };
            [self.view addSubview:view];
        }];
        
        UIAlertAction *company = [UIAlertAction actionWithTitle:@"离职公司" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            WorkWorkingDimissionView *view = [[WorkWorkingDimissionView alloc] initWithFrame:self.view.frame];
            __strong __typeof(&*view)strongView = view;
            view.workWorkingDimissionViewBlock = ^{
                
                [_dataArr removeObjectAtIndex:indexPath.row];
                [_MainTableView reloadData];
                
                [BaseRequest POST:MiddleAgentQuit_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"remarks":strongView.markTV.text,@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"id"]],@"type":@"1"} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            };
            [self.view addSubview:view];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:store];
        [alert addAction:company];
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
    
    //    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
    //        self.rightBtn.hidden = NO;
    //    }else{
    //        self.rightBtn.hidden = YES;
    //    }
    
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
