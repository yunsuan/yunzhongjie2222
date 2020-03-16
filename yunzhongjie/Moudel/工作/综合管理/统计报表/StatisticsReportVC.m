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

@property (nonatomic, strong) StatisticsReportStoreVC *statisticsReportStoreDay;
@property (nonatomic, strong) StatisticsReportStoreVC *statisticsReportStoreMonth;
@property (nonatomic, strong) StatisticsReportStoreVC *statisticsReportStoreAll;

@property (nonatomic, strong) StatisticsReportAgentVC *statisticsReportAgentVC;

@property ( nonatomic , strong ) UIView *maskView;
@property ( nonatomic , strong ) UIView *tanchuanView;
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
    _titleArr = @[@"本日",@"本月",@"累计"];
}

-(void)action_add
{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.tanchuanView];
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
    
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"说明" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    
        [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    
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
//    _statisticsReportCompanyVC = [[StatisticsReportCompanyVC alloc] init];
    _statisticsReportStoreDay = [[StatisticsReportStoreVC alloc] init];
    _statisticsReportStoreDay.type = @"1";
//    _statisticsReportAgentVC = [[StatisticsReportAgentVC alloc] init];
    _statisticsReportStoreMonth = [[StatisticsReportStoreVC alloc] init];
    _statisticsReportStoreMonth.type = @"2";
        _statisticsReportStoreAll = [[StatisticsReportStoreVC alloc] init];
    _statisticsReportStoreAll.type = @"3";
    // 添加为self的子控制器
//    [self addChildViewController:_statisticsReportCompanyVC];
//    [self addChildViewController:_statisticsReportStoreVC];
//    [self addChildViewController:_statisticsReportAgentVC];
    [self addChildViewController:_statisticsReportStoreDay];
    [self addChildViewController:_statisticsReportStoreMonth];
    [self addChildViewController:_statisticsReportStoreAll];
    
//    _statisticsReportCompanyVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
//    _statisticsReportStoreVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
//    _statisticsReportAgentVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
        
        _statisticsReportStoreDay.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
        _statisticsReportStoreMonth.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
        _statisticsReportStoreAll.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
//    [self.scrollView addSubview:_statisticsReportCompanyVC.view];
//    [self.scrollView addSubview:_statisticsReportStoreVC.view];
//    [self.scrollView addSubview:_statisticsReportAgentVC.view];
        [self.scrollView addSubview:_statisticsReportStoreDay.view];
        [self.scrollView addSubview:_statisticsReportStoreMonth.view];
        [self.scrollView addSubview:_statisticsReportStoreAll.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

-(UIView *)tanchuanView
{
    if (!_tanchuanView) {
        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(46*SIZE, 250*SIZE, 268*SIZE, 180*SIZE)];
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
    title.text = @"说明";
    title.font = [UIFont boldSystemFontOfSize:17*SIZE];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:title];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 50*SIZE, 248*SIZE, 80*SIZE)];
    lab.text = @"此处报表分别统计今日，本月，累计的数据。其中二手房数量统计今日和本月为目前在售的房源，以下架或以成交的未统计，累计为历史所有上架过的房源数量。其他统计雷同";
    lab.numberOfLines =0;
    lab.lineBreakMode = NSLineBreakByCharWrapping;
    lab.font = FONT(12);
//    strat.textAlignment = NSTextAlignmentCenter;
    lab.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:lab];
 
    

 
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0 *SIZE,  140 *SIZE, 268 *SIZE, 40 *SIZE)];
    btn1.backgroundColor = CLBlueBtnColor;
    [btn1 addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    [_tanchuanView addSubview:btn1];

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
