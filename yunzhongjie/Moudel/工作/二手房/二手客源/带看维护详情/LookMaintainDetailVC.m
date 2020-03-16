//
//  LookMaintainDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailVC.h"
//#import "AddContractVC.h"

//#import "LookMaintainDetailAddFollowVC.h"
#import "LookMaintainDetailLookRecordVC.h"
#import "LookMaintainCustomDetailVC.h"
//#import "LookMaintainModifyCustomDetailVC.h"
#import "AbandonLookMaintainVC.h"

#import "LookMaintainDetailHeader.h"
#import "LookMaintainDetailRoomCell.h"
#import "LookMaintainDetailContactCell.h"
#import "AddPeopleCell.h"
#import "LookMaintainAddFollowCell.h"
#import "LookMaintainDetailFollowCell.h"
#import "SinglePickView.h"
#import "DropBtn.h"

@interface LookMaintainDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _index;
    NSString *_takeId;
    NSMutableArray *_contactArr;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_followArr;
    NSMutableDictionary *_needInfoDic;
    NSMutableArray *_takeHouseArr;
    NSArray *_agentArr;
}
@property (nonatomic, strong) UITableView *mainTable;
@property ( nonatomic , strong ) UIView *maskView;
@property ( nonatomic , strong ) UIView *tanchuanView;
@property (nonatomic , strong) DropBtn *chooseBtn;

@end

@implementation LookMaintainDetailVC

- (instancetype)initWithTakeId:(NSString *)takeId
{
    self = [super init];
    if (self) {
        
        _takeId = takeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{

    _contactArr = [@[] mutableCopy];
    _baseInfoDic = [@{} mutableCopy];
    _followArr = [@[] mutableCopy];
    _needInfoDic = [@{} mutableCopy];
    _takeHouseArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:SecondRoomCustomermDetail_URL parameters:@{@"take_id":_takeId} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self SetData:resposeObject[@"data"]];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"base_info"]];
    [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [_baseInfoDic setObject:@"" forKey:key];
        }else{
            
            [_baseInfoDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
    }];
    
    _contactArr = [NSMutableArray arrayWithArray:data[@"contact"]];
    _followArr = [NSMutableArray arrayWithArray:data[@"follow"]];
    _needInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"need_info"]];
    [_needInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"pay_type"] || [key isEqualToString:@"match_tags"] || [key isEqualToString:@"shop_type"]) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_needInfoDic setObject:@[] forKey:key];
            }
        }else{
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_needInfoDic setObject:@"" forKey:key];
            }else{
                
                [_needInfoDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }
    }];
    _takeHouseArr = [NSMutableArray arrayWithArray:data[@"take_house"]];
    
    [_mainTable reloadData];
    self.rightBtn.hidden = NO;
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *protocol = [UIAlertAction actionWithTitle:@"分配" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BaseRequest GET:SecondRoomAgentList_URL parameters:nil success:^(id resposeObject) {
            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue]==200) {
                NSArray *arr = resposeObject[@"data"];
                NSMutableArray *temp=[@[] mutableCopy];
                for (int i= 0; i<arr.count; i++) {
                    NSMutableDictionary *dic = [@{} mutableCopy];
                    [dic setValue:[NSString stringWithFormat:@"%@/%@",arr[i][@"store_name"],arr[i][@"agent_name"]] forKey:@"param"];
                    [dic setValue:arr[i][@"agent_id"] forKey:@"id"];
                    [temp addObject:dic];
                }
                _agentArr = [temp copy];
                [self.view addSubview:self.maskView];
                [self.view addSubview:self.tanchuanView];
            }
            else{
                [self showContent:resposeObject[@"msg"]];
            }

            
        } failure:^(NSError *error) {
            [self showContent:@"网络错误！"];
        }];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alert addAction:protocol];

    [alert addAction:cancel];

    [self.navigationController presentViewController:alert animated:YES completion:^{

        
    }];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (_baseInfoDic.count) {

        if (_index == 0) {
            
            return 2;
        }
        return 2;
    }else{

        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_index == 0) {
        
        if (section == 0) {
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }else{
            
            return _takeHouseArr.count;
        }
    }else if (_index == 1){
        
        if (section == 0) {
            
            return _contactArr.count;
        }else{
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }
    }else{
        
        if (section == 0) {
            
            if ([self.edit integerValue]) {
                
                return 1;
            }
            return 0;
        }else{
            
            return _followArr.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (_index == 0) {
            
            return SIZE;
        }else{
            
            return CGFLOAT_MIN;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {

        LookMaintainDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LookMaintainDetailHeader"];
        if (!header) {
            
            header = [[LookMaintainDetailHeader alloc] initWithReuseIdentifier:@"LookMaintainDetailHeader"];
        }
        header.dataDic = _baseInfoDic;
        header.needDic = _needInfoDic;
        header.wayL.text = _agent;
        [header.roomBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.roomBtn setTitleColor:CL86Color forState:UIControlStateNormal];
        [header.contactBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.contactBtn setTitleColor:CL86Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:COLOR(219, 219, 219, 1)];
        [header.followBtn setTitleColor:CL86Color forState:UIControlStateNormal];
        
        if (_takeHouseArr.count) {
            
            [header.roomBtn setTitle:[NSString stringWithFormat:@"带看房源(%ld)",_takeHouseArr.count] forState:UIControlStateNormal];
        }else{
            
            [header.roomBtn setTitle:@"带看房源(0)" forState:UIControlStateNormal];
        }
        [header.followBtn setTitle:@"跟进记录" forState:UIControlStateNormal];
        [header.contactBtn setTitle:@"联系人信息" forState:UIControlStateNormal];
        if (_index == 0) {
            
            [header.roomBtn setBackgroundColor:CLBlueBtnColor];
            [header.roomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_index == 2){
            
            [header.followBtn setBackgroundColor:CLBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.contactBtn setBackgroundColor:CLBlueBtnColor];
            [header.contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.lookMaintainDetailHeaderBlock = ^(NSInteger index) {
            
            _index = index;
            if (index == 1) {
                
                
            }else if (index == 2){
                
                
            }
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_index == 0) {

        if (indexPath.section == 0) {

            NSString * Identifier = @"LookMaintainAddFollowCell";
            LookMaintainAddFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {

                cell = [[LookMaintainAddFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addLabel.text = @"添加带看";

            return cell;
        }else{

            NSString * Identifier = @"LookMaintainDetailRoomCell";
            LookMaintainDetailRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[LookMaintainDetailRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _takeHouseArr[indexPath.row];
            return cell;
        }
    }else{

        if (_index == 1) {

            if (indexPath.section == 0) {
                
                NSString * Identifier = @"LookMaintainDetailContactCell";
                LookMaintainDetailContactCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainDetailContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.tag = indexPath.row;
                cell.dataDic = _contactArr[indexPath.row];
                if (indexPath.row == 0) {
                    
                    cell.typeL.text = @"主权益人";
                    cell.upBtn.hidden = YES;
                    cell.downBtn.hidden = YES;
                }else{
                    
                    cell.typeL.text = @"附权益人";
                    cell.upBtn.hidden = NO;
                    cell.downBtn.hidden = YES;
//                    if (indexPath.row == _contactArr.count - 1) {
//
//                        cell.downBtn.hidden = YES;
//                    }else{
//
//                        cell.downBtn.hidden = NO;
//                    }
                }
                
                cell.lookMaintainDetailContactCellBlock = ^(NSInteger index, NSInteger btn) {
                    
                    if (btn == 0){
                        
                        if (index == 0) {
                            
                            
                        }else{
                            
//                            [BaseRequest GET:TakeMaintainContactChangeSort_URL parameters:@{@"contact_id":_contactArr[index][@"contact_id"],@"top_contact_id":_contactArr[0][@"contact_id"]} success:^(id resposeObject) {
//
//                                NSLog(@"%@",resposeObject);
//                                if ([resposeObject[@"code"] integerValue] == 200) {
//
////                                    [_contactArr exchangeObjectAtIndex:index withObjectAtIndex:(index - 1)];
//                                    [self RequestMethod];
//                                    [_mainTable reloadData];
//                                }else{
//
//                                    [self showContent:resposeObject[@"msg"]];
//                                }
//                            } failure:^(NSError *error) {
//
//                                NSLog(@"%@",error);
//                                [self showContent:@"网络错误"];
//                            }];
                        }
                    }else{
                        
                        if (index == _contactArr.count - 1) {
                            
                            
                        }else{
                            
//                            [BaseRequest GET:TakeMaintainContactChangeSort_URL parameters:@{@"contact_id":_contactArr[index][@"contact_id"],@"top_contact_id":_contactArr[0][@"contact_id"]} success:^(id resposeObject) {
//
//                                NSLog(@"%@",resposeObject);
//                                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                                    [self RequestMethod];
////                                    [_contactArr exchangeObjectAtIndex:index withObjectAtIndex:(index + 1)];
//                                    [_mainTable reloadData];
//                                }else{
//
//                                    [self showContent:resposeObject[@"msg"]];
//                                }
//                            } failure:^(NSError *error) {
//
//                                NSLog(@"%@",error);
//                                [self showContent:@"网络错误"];
//                            }];
                        }
                    }
                };
                return cell;
            }else{
                
                AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddPeopleCell"];
                if (!cell) {
                    
                    cell = [[AddPeopleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPeopleCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.addImg.image = [UIImage imageNamed:@"add10"];
                
                return cell;
            }
        }else{

            if (indexPath.section == 0) {
                
                NSString * Identifier = @"LookMaintainAddFollowCell";
                LookMaintainAddFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainAddFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.addLabel.text = @"添加跟进记录";
                return cell;
            }else{
                
                NSString * Identifier = @"LookMaintainDetailFollowCell";
                LookMaintainDetailFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
                if (!cell) {
                    
                    cell = [[LookMaintainDetailFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.dataDic = _followArr[indexPath.row];
                
                return cell;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
//
        if (indexPath.section == 0) {
////
////            [BaseRequest GET:HouseTakeColumnConfig_URL parameters:@{@"type":@"1"} success:^(id resposeObject) {
////
////                if ([resposeObject[@"code"] integerValue] == 200) {
////
////                    NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
////                    [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
////                    LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
////                    nextVC.property = _needInfoDic[@"property_type"];
////                    nextVC.status = @"2";
////                    nextVC.columnDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
////                    nextVC.lookMaintainDetailAddFollowVCBlock = ^{
////
////                        [self RequestMethod];
////                    };
////                    [self.navigationController pushViewController:nextVC animated:YES];
//                }else{
//
////                    NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
////                    [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
////                    LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
////                    nextVC.property = _needInfoDic[@"property_type"];
////                    nextVC.status = @"2";
////                    nextVC.lookMaintainDetailAddFollowVCBlock = ^{
////
////                        [self RequestMethod];
////                    };
////                    [self.navigationController pushViewController:nextVC animated:YES];
////                }
////            } failure:^(NSError *error) {
////
////                NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
////                [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
////                LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
////                nextVC.property = _needInfoDic[@"property_type"];
////                nextVC.status = @"2";
////                nextVC.lookMaintainDetailAddFollowVCBlock = ^{
////
////                    [self RequestMethod];
////                };
////                [self.navigationController pushViewController:nextVC animated:YES];
////            }];
        }else{
//
            LookMaintainDetailLookRecordVC *nextVC = [[LookMaintainDetailLookRecordVC alloc] initWithData:_takeHouseArr[indexPath.row]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
//    }else if (_index == 1){
//
//        if (indexPath.section == 0) {
//
//            LookMaintainCustomDetailVC *nextVC = [[LookMaintainCustomDetailVC alloc] initWithDataDic:_contactArr[indexPath.row]];
//            nextVC.lookMaintainCustomDetailVCBlock = ^{
//
//                [self RequestMethod];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            LookMaintainModifyCustomDetailVC *nextVC = [[LookMaintainModifyCustomDetailVC alloc] init];
//            nextVC.houseId = _baseInfoDic[@"take_id"];
//            nextVC.status = @"添加";
//            nextVC.lookMaintainModifyCustomDetailVCBlock = ^(NSDictionary *dic) {
//
////                if (self.maintainDetailVCBlock) {
////
////                    self.maintainDetailVCBlock();
////                }
//                [self RequestMethod];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    }else{
//
//        if (indexPath.section == 0) {
//
//            [BaseRequest GET:HouseTakeColumnConfig_URL parameters:@{@"type":@"1"} success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
//                    [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
//                    LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
//                    nextVC.columnDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
//                    nextVC.property = _needInfoDic[@"property_type"];
//                    nextVC.lookMaintainDetailAddFollowVCBlock = ^{
//
//                        [self RequestMethod];
//                    };
//                    [self.navigationController pushViewController:nextVC animated:YES];
//                }else{
//
//                    NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
//                    [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
//                    LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
//                    nextVC.property = _needInfoDic[@"property_type"];
//                    nextVC.lookMaintainDetailAddFollowVCBlock = ^{
//
//                        [self RequestMethod];
//                    };
//                    [self.navigationController pushViewController:nextVC animated:YES];
//                }
//            } failure:^(NSError *error) {
//
//                NSMutableDictionary *tempDic = [_needInfoDic mutableCopy];
//                [tempDic setObject:_baseInfoDic[@"client_level"] forKey:@"client_level"];
//                LookMaintainDetailAddFollowVC *nextVC = [[LookMaintainDetailAddFollowVC alloc] initWithTakeId:_takeId dataDic:tempDic];
//                nextVC.property = _needInfoDic[@"property_type"];
//                nextVC.lookMaintainDetailAddFollowVCBlock = ^{
//
//                    [self RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }];
//        }else{
//
//
//        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 1) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                return NO;
            }
            return YES;
        }else{
            
            return NO;
        }
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [self alertControllerWithNsstring:@"温馨提示" And:@"你确定要删除联系人?" WithCancelBlack:^{
//        
//        
//    } WithDefaultBlack:^{
//        
//        [BaseRequest POST:TakeMaintainContactDelete_URL parameters:@{@"contact_id":_contactArr[indexPath.row][@"contact_id"]} success:^(id resposeObject) {
//            
//            if ([resposeObject[@"code"] integerValue] == 200) {
//                
//                [self RequestMethod];
//            }else{
//                
//                [self showContent:resposeObject[@"msg"]];
//            }
//        } failure:^(NSError *error) {
//            
//            [self showContent:@"网络错误"];
//        }];
//    }];
}


- (void)initUI{

    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"带看详情";
    
//    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1-1"] forState:UIControlStateNormal];

    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _mainTable.estimatedRowHeight = 367 *SIZE;
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedSectionHeaderHeight = 584 *SIZE;
    //    _customDetailTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _mainTable.backgroundColor = CLBackColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

-(UIView *)tanchuanView
{
    if (!_tanchuanView) {
        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(46*SIZE, 300*SIZE, 268*SIZE, 180*SIZE)];
        _tanchuanView.backgroundColor = [UIColor whiteColor];
        _tanchuanView.layer.masksToBounds = YES;
        _tanchuanView.layer.cornerRadius = 3*SIZE;
        [self initTanchuanView];
//        [self initFJXQ];
    }
    return _tanchuanView;
}

-(void)initTanchuanView{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*SIZE, 268*SIZE, 20*SIZE)];
    title.text = @"分配";
    title.font = [UIFont boldSystemFontOfSize:17*SIZE];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:title];
    
    UILabel *strat = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 77*SIZE, 110*SIZE, 15*SIZE)];
    strat.text = @"经纪人:";
    strat.font = FONT(12);
//    strat.textAlignment = NSTextAlignmentCenter;
    strat.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:strat];
 
    
    _chooseBtn  = [[DropBtn alloc]initWithFrame:CGRectMake(60 *SIZE,  70 *SIZE, 180 *SIZE, 33 *SIZE)];
//   _chooseBtn.content.text = _agentArr[0][@"param"];
//    _chooseBtn->str = _agentArr[0][@"id"];

    [_chooseBtn addTarget:self action:@selector(action_choose) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuanView addSubview:_chooseBtn];
    
 
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0 *SIZE,  140 *SIZE, 134 *SIZE, 40 *SIZE)];
    btn1.backgroundColor = CLLightGrayColor;
    [btn1 addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [_tanchuanView addSubview:btn1];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(134 *SIZE,  140 *SIZE, 134 *SIZE, 40 *SIZE)];
    btn.backgroundColor = CLBlueBtnColor;
    [btn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [_tanchuanView addSubview:btn];
}

-(void)action_choose
{
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:self->_agentArr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        _chooseBtn.content.text = MC;
        _chooseBtn->str = ID;
            };
    [self.view addSubview:view];
}


-(void)action_sure
{
    if (_chooseBtn->str) {
        [BaseRequest GET:SecondRoomCustomerAssign_URL
              parameters:@{
            @"take_id":_takeId,
             @"agent_id":_chooseBtn->str
                            }
                 success:^(id resposeObject){
                if ([resposeObject[@"code"] integerValue] ==200) {
                    [self maskViewTap];
                    [self showContent:@"分配成功"];
                }else{
                    [self showContent:resposeObject[@"msg"]];
                }
            }
                 failure:^(NSError *error) {
                [self showContent:@"网络错误"];
        }];
    }
    else{
        [self showContent:@"请先选择一名经纪人"];
    }
    
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


- (void)maskViewTap {
    [self.tanchuanView removeFromSuperview];
    //    [self.guanbi removeFromSuperview];
    self.tanchuanView = nil;
    [self.maskView removeFromSuperview];
//    _fjxx = nil;
}


@end
