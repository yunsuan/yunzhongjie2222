//
//  StatisticsReportStoreVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StatisticsReportStoreVC.h"

#import "myDataGridView.h"
#import "ZQDataGridHeadItemModel.h"
#import "ZQDataGridLeftTableViewCellModel.h"

#import "DateChooseView.h"

@interface StatisticsReportStoreVC ()
{
    
    NSArray *_titleArr;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_rowArr;
}
@property (nonatomic, strong) myDataGridView *dataGridView;

@end

@implementation StatisticsReportStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}

- (void)initDataSource{
    
    
    _titleArr = @[@"推荐",@"到访",@"成交",@"二手进客",@"二手带看",@"二手勘察",@"二手签单",@"租房进客",@"租房带看",@"租房勘察",@"租房签单"];
    _dataArr = [@[] mutableCopy];
    _rowArr = [@[] mutableCopy];
    for (int i = 0; i < _titleArr.count; i++) {
        
        NSMutableArray *tempArr = [@[] mutableCopy];
//        for (int j = 0; j < 8; j++) {
//
//            [tempArr addObject:@"0"];
//        }
        [_dataArr addObject:tempArr];
    }
}

#pragma -mark h获取右侧头部的数据 其类型与右侧的 大cell 类型一致亦可自定义item
- (ZQDataGridRightTableViewCellModel *)getrightHeadModel{
    
    ZQDataGridRightTableViewCellModel * headDataModel = [[ZQDataGridRightTableViewCellModel alloc]init];
    headDataModel.collectionViewCellClass = @"ZQDataGridHeadItemCell";
    headDataModel.setDataMethodName = @"setItemModel:";
    headDataModel.itemModelArray = [self getHeadModelItemArray];
    return headDataModel;
}

#pragma -mark 获取表头数据
- (NSArray *)getHeadModelItemArray{
    NSMutableArray * itemArray = [[NSMutableArray alloc]init];
    
    for ( int i = 0; i < _titleArr.count; i++) {
        ZQDataGridHeadItemModel * itemModel = [[ZQDataGridHeadItemModel alloc]init];
        itemModel.numOfColumnNumIndex = i;
        itemModel.backgroundColor = CLBackColor;
        itemModel.titleString = _titleArr[i];
        [itemArray addObject:itemModel];
    }
    return itemArray;
}

#pragma -mark 获取每列的宽度
- (NSMutableArray *)getColumnWidthArray{
    
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < _titleArr.count; i++) {
        
        if (i > 4) {
            
            [array addObject:@(140 *SIZE)];
        }else{
            
            [array addObject:@(70 *SIZE)];
        }
    }
    return array;
}

#pragma -mark 获取每一行中collocationView item 的小数据源
- (NSArray *)getItemModelArrayWithRowNum:(NSInteger)rowNum{
    NSMutableArray * itemArray = [[NSMutableArray alloc]init];
    for ( int i = 0; i < _titleArr.count; i++) {
        
        if ([_dataArr[i] count]) {
            
            ZQDataGridLeftTableViewCellModel * itemModel = [[ZQDataGridLeftTableViewCellModel alloc]init];
            itemModel.numOfColumnNumIndex = i;
            itemModel.numOfRowIndex = rowNum;
            itemModel.titleString = _dataArr[i][rowNum];
            [itemArray addObject:itemModel];
        }
    }
    return itemArray;
}

#pragma -mark 组装表格数据模型
- (ZQDataGridComponentModel *)getDataModel{
    
    ZQDataGridComponentModel * dataModel = [[ZQDataGridComponentModel alloc]init];
    dataModel.firstRowHeight = 40.0f;
    dataModel.firstColumnWidth = 80.0f;
    dataModel.rowHeight = 70.0f;
    // 获取表格右侧表头数据
    ZQDataGridRightTableViewCellModel * headModel = [self getrightHeadModel];
    
    // 列宽数组
    NSMutableArray * columnWidthArray = [self getColumnWidthArray];
    // 坐标数据模型数组
    NSMutableArray * leftTableDataArray = [[NSMutableArray alloc]init];
    // 右侧数据模型数组
    NSMutableArray * rowDataArray = [[NSMutableArray alloc]init];
    
    // 根据房间数构造需要的行数据
    for (int i = 0 ; i < _rowArr.count; i++) {
        // 左侧列表数据
        ZQDataGridLeftTableViewCellModel * model = [[ZQDataGridLeftTableViewCellModel alloc]init];
        if (i == 7) {
            
            model.titleString = @"汇总";
        }else{
            
            model.titleString = [NSString stringWithFormat:@"%d",i + 1];
        }
        [leftTableDataArray addObject:model];
      
        
        // 右侧列表数据
        ZQDataGridRightTableViewCellModel * rowModel = [[ZQDataGridRightTableViewCellModel alloc]init];
        rowModel.numOfRowIndex = i;
        rowModel.numOfColumnNumIndex = 0;
        rowModel.collectionViewCellClass = @"NomalCollectionViewCell";
        rowModel.setDataMethodName = @"setItemModel:";
        rowModel.itemModelArray = [self getItemModelArrayWithRowNum:i];
        [rowDataArray addObject:rowModel];
    }
    
    dataModel.headDataModel = headModel;
    dataModel.leftTableDataArray = leftTableDataArray;
    dataModel.rowDataArray = rowDataArray;
    dataModel.columnWidthArray = columnWidthArray;
    
    
    return dataModel;
}

#pragma -mark 表格事件处理
- (void)eventDealwithActionType:(ZQDataGridComponentClickType)type row:(NSInteger)row column:(NSInteger)column tagetView:(UIView *)tagetView{
    NSString * moudle = @"";
    if (type == ZQDataGridComponentClickTypeHead) {
        moudle = @"头部视图";
    }else if (type == ZQDataGridComponentClickTypeLeftTab){
        moudle = @"头部左侧列表";
    }else if (type == ZQDataGridComponentClickTypeRightTab){
        moudle = @"头部右侧列表";
    }
    
    NSLog(@"点击了 %@ 行号：%ld 列号：%ld  tagViewClass:%@",moudle,row,column,[tagetView class]);
}

- (void)initUI{
    
    self.titleLabel.text = @"销售明细表";
    
    self.view.backgroundColor = CLWhiteColor;
    
    [self.view addSubview:self.dataGridView];

}

- (myDataGridView *)dataGridView{
    
    if (!_dataGridView) {
        _dataGridView = [[myDataGridView alloc]initWithFrame:self.view.bounds dataSource:[self getDataModel]];
       
        Weak(self);
        _dataGridView.itemClick = ^(ZQDataGridComponentClickType type, NSInteger row, NSInteger column, UIView *tagetView) {
            [weakself eventDealwithActionType:type row:row column:column tagetView:tagetView];
        };
        
//        if (self.type == 5) {
//
//            _dataGridView.rightTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//                NSLog(@"下拉刷新");
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakself.dataGridView.rightTableView.mj_header endRefreshing];
//                });
//            }];
//
//            _dataGridView.rightTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//                NSLog(@"上拉加载");
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakself.dataGridView.rightTableView.mj_footer endRefreshingWithNoMoreData];
//                });
//            }];
//
//            // 不让mj 自适应宽度
//            _dataGridView.rightTableView.mj_header.autoresizingMask = UIViewAutoresizingNone;
//             // 设置mj宽度
//            _dataGridView.rightTableView.mj_header.mj_w = SCREEN_WIDTH;
//            _dataGridView.rightTableView.mj_header.mj_x = -_dataGridView.dataModel.firstColumnWidth;
//
//            _dataGridView.rightTableView.mj_footer.autoresizingMask = UIViewAutoresizingNone;
//            _dataGridView.rightTableView.mj_footer.mj_w = SCREEN_WIDTH;
//            _dataGridView.rightTableView.mj_footer.mj_x = -_dataGridView.dataModel.firstColumnWidth;
//        }
        
        
    }
    return _dataGridView;
}

@end
