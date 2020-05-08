//
//  HouseVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseVC.h"
#import "HNChannelView.h"
#import "HouseListVC.h"


@interface HouseVC ()<WMPageControllerDataSource,WMPageControllerDelegate>
{
//    NSMutableArray *_datasource;
//    NSString *_page;
//    NSString *_search;
NSMutableArray *_titlearr;
     
}


@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) UIButton *moreBtn;


@end

@implementation HouseVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionGoto:) name:@"goto" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadType) name:@"reloadType" object:nil];
    
    _titlearr = [UserModel defaultModel].tagSelectArr;
    
  
    
}

- (void)ReloadType{
    
    [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
}



#pragma mark -- Method

- (void)ActionGoto:(NSNotification *)noti{
    
    [self.navigationController.tabBarController setSelectedIndex:1];
}



- (void)ActionMoreBtn:(UIButton *)btn{
    
    HNChannelView *view = [[HNChannelView alloc]initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, SCREEN_Height -STATUS_BAR_HEIGHT)];
    
    view.clickblook = ^(int selctnum) {
        _titlearr = [UserModel defaultModel].tagSelectArr;
        
        self.selectIndex = selctnum;
        [self reloadData];
    };
    
    view.hideblook = ^{
        _titlearr = [UserModel defaultModel].tagSelectArr;
        //        self.selectIndex = 0;
        [self reloadData];
        [self forceLayoutSubviews];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}





- (void)initUI{
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.titleColorSelected = [UIColor colorWithRed:27.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.menuView.backgroundColor   = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    //    self.menuViewContentMargin = 20*SIZE;
    [self reloadData];
    
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"房源";
    
//    _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0,360 *SIZE , 46*SIZE + STATUS_BAR_HEIGHT)];
//    _headerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_headerView];



//    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _moreBtn.backgroundColor = COLOR(255, 255, 255, 0.9);
//    _moreBtn.frame = CGRectMake(320 *SIZE, NAVIGATION_BAR_HEIGHT, 40 *SIZE, 40 *SIZE);
//    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_moreBtn setImage:[UIImage imageNamed:@"add_6"] forState:UIControlStateNormal];
//    [self.view addSubview:_moreBtn];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    if (_titlearr.count == 0) {
        
        return 0;
    }
    else{
        return _titlearr.count;
    }
    
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[HouseListVC class]]) {
        NSLog(@"%@",viewController);
      
    }
    else{
        
        
    }
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if ([viewController isKindOfClass:[HouseListVC class]]) {
        NSLog(@"%@",viewController);
//        if ([((HouseListVC *)viewController).city isEqualToString:_city]) {
//
//
//        }else{
//
//            ((RoomChildVC *) viewController).city = _city;
//
//            [(RoomChildVC *) viewController RequestMethod];
//        }
    }
    else{
        
        
    }
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
//    NSString *tempStr = _titlearr[index];
//    NSDictionary *dic;
//    dic = [UserModel defaultModel].tagDic[tempStr];
    HouseListVC *vc;
    vc = [[HouseListVC alloc]init];
    
//    if ([((NSString *)dic[@"tag"]) containsString:@"新房"]) {
//
//        vc = [[RoomChildVC alloc] initWithType:2];
//    }else if([((NSString *)dic[@"tag"]) containsString:@"推荐"] || [((NSString *)dic[@"tag"]) containsString:@"关注"]) {
//
//        vc = [[RoomChildVC alloc] initWithType:1];
//    }else if([((NSString *)dic[@"tag"]) containsString:@"租房"]){
//
//        vc = [[RoomChildVC alloc] initWithType:3];
//    }else{
//
//        vc = [[RoomChildVC alloc] initWithType:0];
//    }
//    vc.status = dic[@"tag"];
//    vc.typeId = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
//    vc.param = [NSString stringWithFormat:@"%@",dic[@"param"]];
//    vc.city = _city;
//    vc.roomChildVCRoomModelBlock = ^(RoomListModel *model) {
//
//        if ([dic[@"tag"] isEqualToString:@"关注"]) {
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
////                if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
////
////                }else{
////
////                    nextVC.isRecommend = @"NO";
////                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
//                if ([model.sort integerValue] == 0 && [model.cycle integerValue] == 0){
//
//                    nextVC.isRecommend = @"NO";
//                }
//                else{
//
////                    if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
////
////                    }else{
////
////                        nextVC.isRecommend = @"NO";
////                    }
//                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    };
//
//    vc.roomChildVCSecModelBlock = ^(SecdaryAllTableModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//
//    };
//
//    vc.roomChildVCAttentionSecModelBlock = ^(AttentionHouseModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    __weak RoomChildVC *weakvc = vc;
//    vc.roomChildVCSecComModelBlock = ^(SecdaryComModel *model) {
//
//        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//
//        nextVC.type = weakvc.typeId;
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionSecComModelBlock = ^(AttetionComModel *model) {
//
//        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//
//        nextVC.type = weakvc.typeId;
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRecommendBlock = ^(NSDictionary *dataDic) {
//
//        RecommendNewInfoVC *vc = [[RecommendNewInfoVC alloc] initWithUrlStr:dataDic[@"content_url"] titleStr:dataDic[@"title"] imageUrl:dataDic[@"img_url"] briefStr:dataDic[@"desc"] recommendId:dataDic[@"recommend_id"] companyStr:dataDic[@"nick_name"]];
//        [self.navigationController pushViewController:vc animated:YES];
//    };
////    vc.roomChildVCRecommendBlock = ^(RecommendInfoModel *model) {
////
////        RecommendInfoVC *vc = [[RecommendInfoVC alloc] initWithUrlStr:model.content_url titleStr:model.title imageUrl:model.img_url briefStr:model.desc];
////        [self.navigationController pushViewController:vc animated:YES];
////    };
//
//    vc.roomChildVCRentModelBlock = ^(RentingAllTableModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentModelBlock = ^(AtteionRentingHouseModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRentComModelBlock = ^(RentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentComModelBlock = ^(AttetionRentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
    return vc;
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

    return _titlearr[index];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT, 320*SIZE, 0*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {

//    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+40*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-40*SIZE);
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT);
    
}

@end
