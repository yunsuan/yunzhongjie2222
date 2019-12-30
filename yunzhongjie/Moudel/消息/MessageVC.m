//
//  MessageVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "MessageAuditCell.h"

#import "SignSelectWorkerView.h"
#import "WorkWorkingDimissionView.h"
#import "SignFailView.h"
#import "InvalidView.h"

#import "WorkPhoneConfrimWaitDetailVC.h"
#import "WorkRecommendWaitDetailVC.h"
#import "WorkCompleteCustomVC1.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _page;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;


@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"dimission" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
}


- (void)RequestMethod{
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    [BaseRequest GET:MessageList_URL parameters:dic success:^(id resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            if ([resposeObject[@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"]];
                self->_table.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    [BaseRequest GET:MessageList_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"]];
                self->_table.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        else{
            
            self->_page -= 1;
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        self->_page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
    
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self->_dataArr[indexPath.row][@"message_type"] integerValue] == 19){
    
        return 155*SIZE;
    }else{
        
        return 115*SIZE;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self->_dataArr[indexPath.row][@"message_type"] integerValue] == 19){
        
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        if (!cell) {
            
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tag = indexPath.row;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        
        cell.messageCellSureBtnBlock = ^(NSInteger index) {
            
            if ([self->_dataArr[index][@"message_type"] integerValue] == 1) {
                
                if ([self->_dataArr[index][@"need_confirm"] integerValue] == 1) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                            
                            NSLog(@"%@",resposeObject);
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                if ([resposeObject[@"data"][@"agentGroup"] count]) {
                                    
                                    SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                                    __strong __typeof(&*view)strongView = view;
                                    view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                                    view.signSelectWorkerViewBlock = ^{
                                        
                                        NSMutableDictionary *dic;
                                        if (![self isEmpty:strongView.markTV.text]) {
                                            
                                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                        }else{
                                            
                                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId}];
                                        }
                                        [BaseRequest GET:AgentSignValue_URL parameters:dic success:^(id resposeObject) {
                                            
                                            NSLog(@"%@",resposeObject);
                                            if ([resposeObject[@"code"] integerValue] == 200) {
                                                
                                                [self showContent:resposeObject[@"msg"]];
                                                [self RequestMethod];
                                            }else{
                                                
                                                [self showContent:resposeObject[@"msg"]];
                                            }
                                        } failure:^(NSError *error) {
                                            
                                            [self showContent:@"网络错误"];
                                        }];
                                    };
                                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                                }else{
                                    
                                    [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                                        
                                        NSLog(@"%@",resposeObject);
                                        if ([resposeObject[@"code"] integerValue] == 200) {
                                            
                                            [self showContent:resposeObject[@"msg"]];
                                            [self RequestMethod];
                                        }else{
                                            
                                            [self showContent:resposeObject[@"msg"]];
                                        }
                                    } failure:^(NSError *error) {
                                        
                                        [self showContent:@"网络错误"];
                                    }];
                                }
                            }else{
                                
                                [self showContent:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError *error) {
                            
                            [self showContent:@"网络错误"];
                        }];
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"客户无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        SignFailView *view = [[SignFailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                        
                        __strong __typeof(&*view)strongView = view;
                        view.signFailViewBlock = ^{
                            
                            NSMutableDictionary *dic;
                            if (![self isEmpty:strongView.markTV.text]) {
                                
                                dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                            }else{
                                
                                dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId}];
                            }
                            [BaseRequest GET:AgentSignDisabled_URL parameters:dic success:^(id resposeObject) {
                                
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                    [self RequestMethod];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                [self showContent:@"网络错误"];
                            }];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:view];
                    }];
                    
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        NSDictionary *dic = self->_dataArr[index];
                        WorkCompleteCustomVC1 *nextVC = [[WorkCompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"] dataDic:dic];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        InvalidView * invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                        invalidView.client_id = self->_dataArr[indexPath.row][@"client_id"];
                        invalidView.invalidViewBlock = ^(NSDictionary *dic) {
                            
                            [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                                
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self alertControllerWithNsstring:@"失效确认成功" And:@""];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                                    
                                }else{
                                    
                                    [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                [self alertControllerWithNsstring:@"温馨提示" And:@"操作失败" WithDefaultBlack:^{
                                    
                                }];
                            }];
                        };
                        
                        invalidView.invalidViewBlockFail = ^(NSString *str) {
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:str];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:invalidView];
                    }];
                    
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }
                
            }else if ([self->_dataArr[index][@"message_type"] integerValue] == 18){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *unuse = [UIAlertAction actionWithTitle:@"可带看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [BaseRequest GET:ClientTelCheckValue_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr removeObjectAtIndex:indexPath.row];
                            [tableView reloadData];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }];
                
                UIAlertAction *used = [UIAlertAction actionWithTitle:@"不可带看" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请仔细核对，一旦确认该号码重复，将无法再次推荐" WithCancelBlack:^{
                        
                    } WithDefaultBlack:^{
                        
                        [BaseRequest GET:ClientTelCheckDisabled_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [self->_dataArr removeObjectAtIndex:indexPath.row];
                                [tableView reloadData];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                            }else{
                                
                                [self showContent:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError *error) {
                            
                            [self showContent:@"网络错误"];
                        }];
                    }];
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:unuse];
                [alert addAction:used];
                [alert addAction:cancel];
                
                [self.navigationController presentViewController:alert animated:YES completion:^{
                    
                }];
            }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *agree = [UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"remark":@"",@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"auth_id"]],@"type":@"1",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"role"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                        
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
                    
                    WorkWorkingDimissionView *view = [[WorkWorkingDimissionView alloc] initWithFrame:self.view.frame];
                    __strong __typeof(&*view)strongView = view;
                    view.workWorkingDimissionViewBlock = ^{
                        
                        [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"remark":strongView.markTV.text,@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"auth_id"]],@"type":@"0",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"role"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
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
            }
        };
        
        return cell;
    }else{
        
        MessageAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageAuditCell"];
        if (!cell) {
            
            cell = [[MessageAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tag = indexPath.row;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        
        cell.messageAuditCellSureBtnBlock = ^(NSInteger index) {
            
            if ([self->_dataArr[index][@"message_type"] integerValue] == 1) {
                
                if ([self->_dataArr[index][@"need_confirm"] integerValue] == 1) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                            
                            NSLog(@"%@",resposeObject);
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                if ([resposeObject[@"data"][@"agentGroup"] count]) {
                                    
                                    SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                                    __strong __typeof(&*view)strongView = view;
                                    view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                                    view.signSelectWorkerViewBlock = ^{
                                        
                                        NSMutableDictionary *dic;
                                        if (![self isEmpty:strongView.markTV.text]) {
                                            
                                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                        }else{
                                            
                                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId}];
                                        }
                                        [BaseRequest GET:AgentSignValue_URL parameters:dic success:^(id resposeObject) {
                                            
                                            NSLog(@"%@",resposeObject);
                                            if ([resposeObject[@"code"] integerValue] == 200) {
                                                
                                                [self showContent:resposeObject[@"msg"]];
                                                [self RequestMethod];
                                            }else{
                                                
                                                [self showContent:resposeObject[@"msg"]];
                                            }
                                        } failure:^(NSError *error) {
                                            
                                            [self showContent:@"网络错误"];
                                        }];
                                    };
                                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                                }else{
                                    
                                    [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {
                                        
                                        NSLog(@"%@",resposeObject);
                                        if ([resposeObject[@"code"] integerValue] == 200) {
                                            
                                            [self showContent:resposeObject[@"msg"]];
                                            [self RequestMethod];
                                        }else{
                                            
                                            [self showContent:resposeObject[@"msg"]];
                                        }
                                    } failure:^(NSError *error) {
                                        
                                        [self showContent:@"网络错误"];
                                    }];
                                }
                            }else{
                                
                                [self showContent:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError *error) {
                            
                            [self showContent:@"网络错误"];
                        }];
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"客户无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        SignFailView *view = [[SignFailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                        
                        __strong __typeof(&*view)strongView = view;
                        view.signFailViewBlock = ^{
                            
                            NSMutableDictionary *dic;
                            if (![self isEmpty:strongView.markTV.text]) {
                                
                                dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                            }else{
                                
                                dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId}];
                            }
                            [BaseRequest GET:AgentSignDisabled_URL parameters:dic success:^(id resposeObject) {
                                
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                    [self RequestMethod];
                                }else{
                                    
                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                [self showContent:@"网络错误"];
                            }];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:view];
                    }];
                    
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        NSDictionary *dic = self->_dataArr[index];
                        WorkCompleteCustomVC1 *nextVC = [[WorkCompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"] dataDic:dic];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                    
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        InvalidView * invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                        invalidView.client_id = self->_dataArr[indexPath.row][@"client_id"];
                        invalidView.invalidViewBlock = ^(NSDictionary *dic) {
                            
                            [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {
                                
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self alertControllerWithNsstring:@"失效确认成功" And:@""];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                                    
                                }else{
                                    
                                    [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {
                                
                                [self alertControllerWithNsstring:@"温馨提示" And:@"操作失败" WithDefaultBlack:^{
                                    
                                }];
                            }];
                        };
                        
                        invalidView.invalidViewBlockFail = ^(NSString *str) {
                            
                            [self alertControllerWithNsstring:@"温馨提示" And:str];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:invalidView];
                    }];
                    
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
                        
                    }];
                }
                
            }else if ([self->_dataArr[index][@"message_type"] integerValue] == 18){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *unuse = [UIAlertAction actionWithTitle:@"可带看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [BaseRequest GET:ClientTelCheckValue_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr removeObjectAtIndex:indexPath.row];
                            [tableView reloadData];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }];
                
                UIAlertAction *used = [UIAlertAction actionWithTitle:@"不可带看" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"请仔细核对，一旦确认该号码重复，将无法再次推荐" WithCancelBlack:^{
                        
                    } WithDefaultBlack:^{
                        
                        [BaseRequest GET:ClientTelCheckDisabled_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [self->_dataArr removeObjectAtIndex:indexPath.row];
                                [tableView reloadData];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                            }else{
                                
                                [self showContent:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError *error) {
                            
                            [self showContent:@"网络错误"];
                        }];
                    }];
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:unuse];
                [alert addAction:used];
                [alert addAction:cancel];
                
                [self.navigationController presentViewController:alert animated:YES completion:^{
                    
                }];
            }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *agree = [UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"remark":@"",@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"auth_id"]],@"type":@"1",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_type"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                        
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
                    
                    WorkWorkingDimissionView *view = [[WorkWorkingDimissionView alloc] initWithFrame:self.view.frame];
                    __strong __typeof(&*view)strongView = view;
                    view.workWorkingDimissionViewBlock = ^{
                        
                        [BaseRequest POST:MiddleAgentEX_URL parameters:@{@"agent_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_id"]],@"store_id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_id"]],@"remark":strongView.markTV.text,@"id":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"auth_id"]],@"type":@"0",@"store_type":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"store_type"]],@"is_store_staff":[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"is_store_staff"]]} success:^(id resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"dimission" object:nil];
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
            }
        };
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 18) {
        
        WorkPhoneConfrimWaitDetailVC *nextVC = [[WorkPhoneConfrimWaitDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
        //    if (_dataArr[indexPath.row][@"copy_content"]) {
        //
        //        nextVC.content = _dataArr[indexPath.row][@"copy_content"];
        //    }
        
        nextVC.workPhoneConfrimWaitDetailVCBlock = ^{
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1){
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
        if (_dataArr[indexPath.row][@"need_confirm"]) {
            
            nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
        }else{
            
            nextVC.needConfirm = @"1";
        }
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [BaseRequest GET:DeleteMessage_URL parameters:@{@"message_id":[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"message_id"]]} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self RequestMethod];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"消息";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
//    _table.editing = YES;
//    _table.editing= YES;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
    
}

@end
