//
//  SecondRoomHouseVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondRoomHouseVC.h"

#import "SecondRoomHouseCell.h"

@interface SecondRoomHouseVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation SecondRoomHouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondRoomHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondRoomHouseCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    
}

@end
