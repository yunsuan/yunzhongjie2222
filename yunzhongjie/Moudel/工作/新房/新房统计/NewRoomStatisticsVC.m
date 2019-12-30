//
//  NewRoomStatisticsVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomStatisticsVC.h"

#import "BaseHeader.h"
#import "TitleRightBtnHeader.h"

#import "TypeTagCollCell.h"

#import "NewRoomCustomAnalysisCell.h"
#import "NewRoomSingleChartCell.h"
#import "NewRoomMutiLineCell.h"

@interface NewRoomStatisticsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *table;

@end

@implementation NewRoomStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionConfirmMethod) name:@"PhoneConfirm" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionConfirmAllMethod) name:@"PhoneAllConfirm" object:nil];
    _titleArr = @[@"今日",@"本月",@"累计"];
}

- (void)ActionConfirmMethod{
    
    //    [_confirmPhoneWaitVC RequestMethod];
//    [_confirmPhoneUseVC RequestMethod];
//    [_confirmPhoneFailVC RequestMethod];
}

- (void)ActionConfirmAllMethod{
    
//    [_confirmPhoneWaitVC RequestMethod];
//    [_confirmPhoneUseVC RequestMethod];
//    [_confirmPhoneFailVC RequestMethod];
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeTagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TypeTagCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
        
    }
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
    cell.line.frame = CGRectMake(46 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE);
    
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2 || section == 1) {
        
//        if ([_status isEqualToString:@"1"]) {
//
//            return [_dataDic[@"company"] count] > 3? 3:[_dataDic[@"company"] count];
//        }else if([_status isEqualToString:@"2"]){
//
//            return [_monthDic[@"company"] count] > 3? 3:[_monthDic[@"company"] count];
//        }else{
//
//            return [_yearDic[@"company"] count] > 3? 3:[_yearDic[@"company"] count];
//        }
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section != 0) {
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        if (section == 2) {
            
            header.titleL.text = @"分销公司排行榜";
            header.addBtn.hidden = YES;
            
            header.titleRightBtnHeaderMoreBlock = ^{
                
                
            };
        }else{
            
            header.titleL.text = @"年度趋势图";
            header.addBtn.hidden = YES;
            
//            [header.moreBtn setTitle:[NSString stringWithFormat:@"%@年 >",_year] forState:UIControlStateNormal];
            header.moreBtn.titleLabel.font = FONT(13 *SIZE);
            
            header.titleRightBtnHeaderMoreBlock = ^{
                
//                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:self->_yearArr];
//                view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                    self->_year = MC;
//                    [tableView reloadData];
//                    [self RequestMethod];
//                };
//                [self.view addSubview:view];
//                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
//
//                view.dateblock = ^(NSDate *date) {
//
//                    self->_year = [_yearMatter stringFromDate:date];
//                    [tableView reloadData];
//                    [self RequestMethod];
//                };
//                [self.view addSubview:view];
            };
        }
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 0) {
            
            header.titleL.text = @"客户分析表";
        }
       
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 || indexPath.section == 1) {
        
        return UITableViewAutomaticDimension;
    }
    return 240 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 || indexPath.section == 1) {
        
        NewRoomCustomAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomCustomAnalysisCell"];
        if (!cell) {
            
            cell = [[NewRoomCustomAnalysisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomCustomAnalysisCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        if ([_status isEqualToString:@"1"]) {
//
//            cell.titleL.text = _dataDic[@"company"][indexPath.row][@"name"];
//        }else if ([_status isEqualToString:@"2"]) {
//
//            cell.titleL.text = _monthDic[@"company"][indexPath.row][@"name"];
//        }else{
//
//            cell.titleL.text = _yearDic[@"company"][indexPath.row][@"name"];
//        }

        return cell;
    }else{
        
        if (indexPath.section == 0) {
            
            NewRoomSingleChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomSingleChartCell"];
            if (!cell) {
                
                cell = [[NewRoomSingleChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomSingleChartCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            cell.singleBarChartView.delegate = self;
//            cell.channelSingleChartCellBlock = ^(NSInteger index) {
                
//                ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//                nextVC.index = index;
//                nextVC.project_id = self->_project_id;
//                if ([self->_status isEqualToString:@"1"]) {
//
//                    nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//                }else if ([self->_status isEqualToString:@"2"]){
//
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"yyyy-MM-01"];
//                    nextVC.date = [formatter stringFromDate:[NSDate date]];
//                }
//                [self.navigationController pushViewController:nextVC animated:YES];
//            };
            
//            if ([_status isEqualToString:@"1"]) {
//
//                if (_dataDic.count) {
//
//                    cell.dataDic =  _dataDic[@"currentDayCount"];
//                }else{
//
//                    cell.dataDic = @{};
//                }
//
//            }else if ([_status isEqualToString:@"2"]) {
//
//                if (_monthDic.count) {
//
//                    cell.dataDic =  _monthDic[@"currentMonthCount"];
//                }else{
//
//                    cell.dataDic = @{};
//                }
//
//            }else{
//
//                if (_yearDic.count) {
//
//                    cell.dataDic = _yearDic[@"totalCount"];
//                }else{
//
//                    cell.dataDic = @{};
//                }
//            }
            
            return cell;
        }else{
            
            NewRoomMutiLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomMutiLineCell"];
            if (!cell) {
                
                cell = [[NewRoomMutiLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomMutiLineCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            if ([_status isEqualToString:@"1"]) {
//
//                cell.dataDic = _dataDic;
//            }else if ([_status isEqualToString:@"2"]) {
//
//                cell.dataDic = _monthDic;
//            }else{
//
//                cell.dataDic = _yearDic;
//            }
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
//        ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//        nextVC.index = 0;
//        nextVC.project_id = self->_project_id;
//        if ([self->_status isEqualToString:@"1"]) {
//
//            nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//        }
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"统计报表";
//    self.line.hidden = YES;
    
    //    self.rightBtn.hidden = NO;
    //    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    //    [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[TypeTagCollCell class] forCellWithReuseIdentifier:@"TypeTagCollCell"];
    [self.view addSubview:_segmentColl];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStyleGrouped];
    //    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
