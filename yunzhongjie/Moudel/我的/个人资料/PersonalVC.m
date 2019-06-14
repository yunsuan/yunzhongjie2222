//
//  PersonalVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PersonalVC.h"

#import "ChangeNameVC.h"
#import "PersonalIntroVC.h"
#import "TitleContentRightBaseCell.h"
#import "DateChooseView.h"
//#import "AddressChooseView3.h"
#import "AdressChooseView.h"

#import "PersonalHeader.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSMutableDictionary *_fixdic;
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UITableView *personTable;

@property (nonatomic, strong) UIButton *exitBtn;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self reloadData];
    
    
}

-(void)reloadData
{
    NSString *name;
    if ([UserModelArchiver unarchive].name) {
        name = [UserModelArchiver unarchive].name;
    }
    else{
        name = @"";
    }
    NSString *sex;
    if ([UserModelArchiver unarchive].sex) {
        if ([[UserModelArchiver unarchive].sex integerValue]==1) {
            sex = @"男";
        }
        else if ([[UserModelArchiver unarchive].sex integerValue]==2)
        {
            sex = @"女";
        }else
        {
            sex = @"";
        }
    }
    else{
        sex = @"";
    }
    NSString *tel;
    if ([UserModelArchiver unarchive].tel) {
        tel = [UserModelArchiver unarchive].tel;
    }
    else{
        tel = @"";
    }
    NSString *birth;
    if ([UserModelArchiver unarchive].birth) {
        birth = [UserModelArchiver unarchive].birth;
    }
    else{
        birth = @"";
    }
    NSString *adress;
    if ([UserModelArchiver unarchive].province) {
        //        adress = [NSString stringWithFormat:@"%@/%@/%@",[UserModelArchiver unarchive].province,[UserModelArchiver unarchive].city,[UserModelArchiver unarchive].district];
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
        
        NSError *err;
        NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
        for (int i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [[UserModelArchiver unarchive].province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (int j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [[UserModelArchiver unarchive].city integerValue]){
                        
                        NSArray *area = city[j][@"district"];
                        
                        for (int k = 0; k < area.count; k++) {
                            
                            if([area[k][@"code"] integerValue] == [[UserModelArchiver unarchive].district integerValue]){
                                //
                                //                                _provinceId = [UserInfoModel defaultModel].province;
                                //                                _cityId = [UserInfoModel defaultModel].city;
                                //                                _areaId = [UserInfoModel defaultModel].district;
                                adress = [NSString stringWithFormat:@"%@-%@-%@",provice[i][@"name"],city[j][@"name"],area[k][@"name"]];
                            }
                        }
                    }
                }
            }
        }
        
    }
    else{
        adress = @"";
    }
    _contentArr = [@[name,sex,tel,birth,adress] mutableCopy];
    [_personTable reloadData];
}

- (void)initDataSource{
    
    _fixdic = [NSMutableDictionary dictionary];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    _titleArr = @[@"姓名",@"性别",@"手机号",@"出生日期",@"所在地"];
//    _contentArr = [NSMutableArray arrayWithArray:@[[UserInfoModel defaultModel].account,[UserInfoModel defaultModel].tel,[UserInfoModel defaultModel].name,[[UserInfoModel defaultModel].sex integerValue] == 1?@"男":[[UserInfoModel defaultModel].sex integerValue] == 2?@"女":@"",[UserInfoModel defaultModel].birth,[UserInfoModel defaultModel].absolute_address,[UserInfoModel defaultModel].slef_desc]];
//    _imagePickerController = [[UIImagePickerController alloc] init];
//    _imagePickerController.delegate = self;
}


#pragma mark -- action

- (void)ActionExitBtn:(UIButton *)btn{
//    NSDictionary *dic = @{@"sex":@"1"};
    [BaseRequest POST:FixPersonInfo_URL parameters:_fixdic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            if (_fixdic[@"sex"]) {
                [UserModel defaultModel].sex = _fixdic[@"sex"] ;
            }
            
            if (_fixdic[@"birth"]) {
                 [UserModel defaultModel].birth = _fixdic[@"birth"] ;
            }
            
            if (_fixdic[@"province"]) {
                [UserModel defaultModel].province = _fixdic[@"province"];
                [UserModel defaultModel].city = _fixdic[@"city"];
                [UserModel defaultModel].district = _fixdic[@"district"];
            }
            
            
            [UserModelArchiver archive];
            
//            [UserModel defaultModel].sex = @"1";
//            [UserModelArchiver archive];
//            [_contentArr replaceObjectAtIndex:1 withObject:@"男"];
            [_personTable reloadData];
        }else{
            
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PersonalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PersonalHeader"];
    if (!header) {
        
        header = [[PersonalHeader alloc] initWithReuseIdentifier:@"PersonalHeader"];
    }
    
//    [header.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        if (error) {
//
//            header.headerImg.image = IMAGE_WITH_NAME(@"def_head");
//        }
//    }];;
    
//    header.personalHeaderBlock = ^{
//
//    };
    
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 51 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleContentRightBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBaseCell"];
    if (!cell) {
        
        cell = [[TitleContentRightBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
//    cell.contentL.text = @"333333";
    cell.contentL.text = _contentArr[indexPath.row];
    if (indexPath.row != 2) {
        
        cell.rightImg.hidden = NO;
    }else{
        
        cell.rightImg.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ChangeNameVC *nextVC = [[ChangeNameVC alloc] initWithName:[UserModel defaultModel].name];
        nextVC.changeNameVCBlock = ^(NSString *str) {
            
            [self->_contentArr replaceObjectAtIndex:0 withObject:str];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row ==1){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_fixdic setValue:@"1" forKey:@"sex"];
//            NSDictionary *dic = @{@"sex":@"1"};
//            [BaseRequest POST:FixPersonInfo_URL parameters:dic success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [UserModel defaultModel].sex = @"1";
//                    [UserModelArchiver archive];
                    [_contentArr replaceObjectAtIndex:1 withObject:@"男"];
//                    [tableView reloadData];
//                }else{
//
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [self showContent:@"网络错误"];
//            }];
        }];
        
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_fixdic setValue:@"2" forKey:@"sex"];
//            NSDictionary *dic = @{@"sex":@"2"};
//            [BaseRequest POST:FixPersonInfo_URL parameters:dic success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [UserModel defaultModel].sex = @"2";
//                    [UserModelArchiver archive];
////                    [self initDataSource];
                    [_contentArr replaceObjectAtIndex:1 withObject:@"女"];
//                    [tableView reloadData];
//                }else{
//
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [self showContent:@"网络错误"];
//            }];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:male];
        [alert addAction:female];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 3){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        view.dateblock = ^(NSDate *date) {
            
//            NSDictionary *dic = @{@"birth":[self->_formatter stringFromDate:date]};
            
            [_fixdic setValue:[self->_formatter stringFromDate:date] forKey:@"birth"];
//            [BaseRequest POST:FixPersonInfo_URL parameters:dic success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [UserModel defaultModel].birth = [self->_formatter stringFromDate:date];
//                    [UserModelArchiver archive];
                    [_contentArr replaceObjectAtIndex:2 withObject:[self->_formatter stringFromDate:date]];
////                    [self initDataSource];
//                    [tableView reloadData];
//                }else{
//
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [self showContent:@"网络错误"];
//            }];
        };
        [self.view addSubview:view];
    }else if (indexPath.row == 4){
        
//        AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.frame withdata:@[]];
        AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
        WS(weakself);
        addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {

//
//            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
//
//            NSError *err;
//            NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:&err];
//            NSString *pro = [cityid substringToIndex:2];
//            pro = [NSString stringWithFormat:@"%@0000",pro];
//            NSString *proName;
//            if ([pro isEqualToString:@"900000"]) {
//                proName = @"海外";
//            }
//            else{
//                for (NSDictionary *dic in proArr) {
//
//                    if([dic[@"code"] isEqualToString:pro]){
//
//                        proName = dic[@"name"];
//                        break;
//                    }
//                }
//            }
//
//            NSDictionary *dic = @{@"province":proviceid,@"city":cityid,@"district":areaid};
            
            [_fixdic setValue:proviceid forKey:@"province"];
            [_fixdic setValue:cityid forKey:@"city"];
            [_fixdic setValue:areaid forKey:@"district"];
            
//            [BaseRequest POST:FixPersonInfo_URL parameters:dic success:^(id resposeObject) {
//
//                //            NSLog(@"%@",resposeObject);
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [UserModel defaultModel].province = cityid;
//                    [UserModel defaultModel].city = cityid;
//                    [UserModel defaultModel].district = areaid;
////                    [self initDataSource];
//                    [UserModelArchiver archive];
                    [_contentArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@-%@-%@",province,city,area]];
//                    [self->_personTable reloadData];
////                    [self.navigationController popViewControllerAnimated:YES];
//                }else{
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [self showContent:@"网络错误"];
//                //            NSLog(@"%@",error);
//            }];
        };
        [self.view addSubview:addressChooseView];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"个人资料";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _personTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.bounces = NO;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, SCREEN_Width, 50 *SIZE + TAB_BAR_MORE);
    _exitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_exitBtn addTarget:self action:@selector(ActionExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_exitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:CLBlueBtnColor];
//    [_exitBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.view addSubview:_exitBtn];
}

@end
