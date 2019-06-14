//
//  PushSettingVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PushSettingVC.h"

#import "PushSettingCell.h"

@interface PushSettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_setting;
}
@property (nonatomic, strong) UITableView *personTable;

@end

@implementation PushSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self Post];
    [self initUI];
}

- (void)initDataSource{
    
    _setting = [@[@"0",@"0"] mutableCopy];
    _titleArr = @[@"移动审核提醒",@"渠道客户到访确认提醒"];

//    _contentArr = [[NSMutableArray alloc] initWithArray:@[@"云算号",@"",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"******",@""]];
    
}


-(void)Post{
    [BaseRequest GET:GetPush_URL parameters:nil success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue]==200) {
            if ([resposeObject[@"data"][@"check_push"] integerValue]==1) {
                [_setting setObject:@"1" atIndexedSubscript:0];
            }
            if ([resposeObject[@"data"][@"confirm"] integerValue]==1) {
                 [_setting setObject:@"1" atIndexedSubscript:1];
            }
            [self.personTable reloadData];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    
    }];
}


#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __strong PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushSettingCell"];
    if (!cell) {
        
        cell = [[PushSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PushSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
    cell.contentL.hidden = YES;
    cell.headImg.hidden = YES;
    cell.OnOff.hidden = NO;
    cell.rightView.hidden = YES;
    [cell.OnOff setOn:[_setting[indexPath.row] boolValue]];
    cell.pushSettingCellSwitchBlock = ^{
        if (indexPath.row ==0) {
            if (cell.OnOff.on) {
                
                [self SetPushByitem:@"check_push" isOpen:@"0"];
                [cell.OnOff setOn:NO];
                
            }else{
                [self SetPushByitem:@"check_push" isOpen:@"1"];
                [cell.OnOff setOn:YES];
            }
        }
        else{
            if (cell.OnOff.on) {
                [self SetPushByitem:@"confirm" isOpen:@"0"];
                [cell.OnOff setOn:NO];
                
            }else{
                [self SetPushByitem:@"confirm" isOpen:@"0"];
                [cell.OnOff setOn:YES];
            }
        }

//        switch (indexPath.row) {
//            case 0:
//            {
//                if (cell.OnOff.on) {
//
//                    [cell.OnOff setOn:NO];
//                }else{
//
//                    [cell.OnOff setOn:YES];
//                }
//                break;
//            }
//            default:
//                break;
//        }
    };

    return cell;
}

-(void)SetPushByitem:(NSString *)item isOpen:(NSString *)open
{
    [BaseRequest GET:UpdatePush_URL
          parameters:@{
                                                 item:open
                                                 }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue] ==200) {
                     
                 }
                 else
                 {
                     [self showContent:@"msg"];
                 }
                                                 }
             failure:^(NSError *error) {
                 
                 [self showContent:@"网络错误"];
                                                 }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"推送设置";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
}

@end
