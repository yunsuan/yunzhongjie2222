//
//  StatisticsReportVC.m
//  yunzhongjie
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StatisticsReportVC.h"

#import "StatisticsReportCompanyVC.h"
#import "StatisticsReportStoreVC.h"
#import "StatisticsReportAgentVC.h"

#import "TypeTagCollCell.h"

@interface StatisticsReportVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) StatisticsReportCompanyVC *statisticsReportCompanyVC;

@property (nonatomic, strong) StatisticsReportStoreVC *statisticsReportStoreVC;

@property (nonatomic, strong) StatisticsReportAgentVC *statisticsReportAgentVC;
@end

@implementation StatisticsReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionConfirmMethod) name:@"PhoneConfirm" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionConfirmAllMethod) name:@"PhoneAllConfirm" object:nil];
    _titleArr = @[@"公司",@"门店",@"经纪人"];
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
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
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
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 40 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 40 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _statisticsReportCompanyVC = [[StatisticsReportCompanyVC alloc] init];
    _statisticsReportStoreVC = [[StatisticsReportStoreVC alloc] init];
    _statisticsReportAgentVC = [[StatisticsReportAgentVC alloc] init];
    
    // 添加为self的子控制器
    [self addChildViewController:_statisticsReportCompanyVC];
    [self addChildViewController:_statisticsReportStoreVC];
    [self addChildViewController:_statisticsReportAgentVC];
    
    _statisticsReportCompanyVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _statisticsReportStoreVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _statisticsReportAgentVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_statisticsReportCompanyVC.view];
    [self.scrollView addSubview:_statisticsReportStoreVC.view];
    [self.scrollView addSubview:_statisticsReportAgentVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}
@end
