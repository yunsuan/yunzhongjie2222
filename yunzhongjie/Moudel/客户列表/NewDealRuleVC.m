//
//  NewDealRuleVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/8/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewDealRuleVC.h"

@interface NewDealRuleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation NewDealRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"佣金规则";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorColor = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
