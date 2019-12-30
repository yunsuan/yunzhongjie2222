//
//  StatisticsReportCompanyVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StatisticsReportCompanyVC.h"

#import "BlueTitleRightBtnHeader.h"
#import "StatisticsReportCompanyCell.h"

@interface StatisticsReportCompanyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation StatisticsReportCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BlueTitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleRightBtnHeader"];
    if (!header) {
        
        header = [[BlueTitleRightBtnHeader alloc] initWithReuseIdentifier:@"BlueTitleRightBtnHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"日报";
    }else if (section == 1){
        
        header.titleL.text = @"日报";
    }else if (section == 2){
        
        header.titleL.text = @"日报";
    }else{
        
        header.titleL.text = @"日报";
    }
    
    [header.moreBtn setTitle:@"2019-10-10" forState:UIControlStateNormal];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StatisticsReportCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatisticsReportCompanyCell"];
    if (!cell) {
        
        cell = [[StatisticsReportCompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StatisticsReportCompanyCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = @"asdasdasdkasdjasdkjalskdjalskdjaklsdjaklsdjlkasjd";
    
    return cell;
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
