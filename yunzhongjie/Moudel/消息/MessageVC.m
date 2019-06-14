//
//  MessageVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"

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
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}


- (void)RequestMethod{
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    [BaseRequest GET:MessageList_URL parameters:dic success:^(id resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        
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
    
    
    return 115*SIZE;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (!cell) {
        
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    [cell SetImg:_imgArr[indexPath.row] title:_titleArr[indexPath.row] content:@""];
    //    if ([_showArr[indexPath.row] integerValue] == 1) {
    //
    //        cell.hidden = NO;
    //    }else{
    //
    //        cell.hidden = YES;
    //    }
    cell.dataDic = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        [self RequestAddMethod];
    }];
    
}

@end
