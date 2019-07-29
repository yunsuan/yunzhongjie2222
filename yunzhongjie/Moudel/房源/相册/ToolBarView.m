//
//  ToolBarView.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ToolBarView.h"
#import "YBIBUtilities.h"
#import "YBIBCopywriter.h"
#import "YBImageBrowserTipView.h"
#import "AlbumCollCell.h"
#import "YBIBFileManager.h"

static CGFloat kToolBarDefaultsHeight = 50.0;

@interface ToolBarView  ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
    id<YBImageBrowserCellDataProtocol> _data;
//    NSInteger _total;
    NSMutableArray *_numCount;
   
 
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIButton *operationButton;
@property (nonatomic, strong) CAGradientLayer *gradient;
//@property (nonatomic, strong) UILabel *currentL;
//
//@property (nonatomic, strong) UILabel *allL;
//
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//
//@property (nonatomic, strong) UICollectionView *XGColl;

@end

@implementation ToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer addSublayer:self.gradient];
//        [self addSubview:self.indexLabel];
        [self addSubview:self.operationButton];
        [self addSubview:self.titleLabel];
    
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(78 *SIZE, 27 *SIZE);
        _flowLayout.minimumInteritemSpacing = 7 *SIZE;
        //    _flowLayout.sectionInset = UIEdgeInsetsMake(SIZE, 10 *SIZE, 27 *SIZE, 10 *SIZE);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _currentL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, SCREEN_Height-100*SIZE, 100 *SIZE, 12 *SIZE)];
        _currentL.textColor = CLContentLabColor;
        _currentL.font = [UIFont systemFontOfSize:12 *SIZE];
        _currentL.text = @"效果图1/12";
        [self addSubview:_currentL];
        
        _allL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE,SCREEN_Height-100*SIZE, 100 *SIZE, 12 *SIZE)];
        _allL.textColor = CLContentLabColor;
        _allL.font = [UIFont systemFontOfSize:12 *SIZE];
        _allL.textAlignment = NSTextAlignmentRight;
        _allL.text = @"全部1/12";
        [self addSubview:_allL];
//        [self SetData:_imgArr];
        _XGColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_Height-90*SIZE, SCREEN_Width, 55 *SIZE) collectionViewLayout:_flowLayout];
        _XGColl.backgroundColor = [UIColor clearColor];
        _XGColl.delegate = self;
        _XGColl.dataSource = self;
        [_XGColl registerClass:[AlbumCollCell class] forCellWithReuseIdentifier:@"AlbumCollCell"];
        [self addSubview:_XGColl];
        [self bringSubviewToFront:_XGColl];
    }
    return self;
}

#pragma mark - public

- (void)SetData:(NSArray *)data{
//
//    for ( int i = 0; i < data.count; i++) {
//
//        if ([data[i] isKindOfClass:[NSDictionary class]]) {
//
//            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
//
//            //            [_imgArr addObject:tempDic];
//
//
//            for (int j = 0; j < [tempDic[@"data"] count]; j++) {
//
////                _total = _total + 1;
//                //                [_allArr addObject:tempDic[@"data"][j]];
//            }
//        }
//    }
//
//    [_XGColl reloadData];
//    [_XGColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
//    //    [_scrollView setContentOffset:CGPointMake(_num *SCREEN_Width, 0)];
}

-(void)setImage:(NSArray *)Img
{
    _imgArr = [Img mutableCopy];;
    _numCount = [NSMutableArray array];
    int j = 1;
    for (int i= 0; i<_imgArr.count; i++) {
        if (i==0) {
            
        }else if(i<_imgArr.count-1)
        {
            if ([_imgArr[i][@"type_name"] isEqual:_imgArr[i-1][@"type_name"]]) {
                j++;
            }else{
                NSDictionary *dic = @{
                      @"name":_imgArr[i-1][@"type_name"],
                       @"num":[NSNumber numberWithInt:j]
                                      };
                [_numCount addObject:dic];
                j=1;
                
            }
        }
        else
        {
            if ([_imgArr[i][@"type_name"] isEqual:_imgArr[i-1][@"type_name"]]) {
                j++;
                NSDictionary *dic = @{
                                      @"name":_imgArr[i-1][@"type_name"],
                                      @"num":[NSNumber numberWithInt:j]
                                      };
                [_numCount addObject:dic];
            }else{
                j=1;
                NSDictionary *dic = @{
                                      @"name":_imgArr[i-1][@"type_name"],
                                      @"num":[NSNumber numberWithInt:j]
                                      };
                [_numCount addObject:dic];
                
                
            }
        }
    }
    
       [_XGColl reloadData];
        [_XGColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _numCount.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 78 *SIZE, 27 *SIZE)];
    }
    cell.contentL.text = _numCount[indexPath.row][@"name"];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"111");
    
    

}




#pragma mark - <YBImageBrowserToolBarProtocol>

-(void)yb_browserUpdateLayoutWithDirection:(YBImageBrowserLayoutDirection)layoutDirection containerSize:(CGSize)containerSize {
    CGFloat height = kToolBarDefaultsHeight, width = containerSize.width, buttonWidth = 53, labelWidth = width / 3.0, hExtra = 0;
    if (containerSize.height > containerSize.width && YBIB_IS_IPHONEX) height += YBIB_HEIGHT_STATUSBAR;
    if (containerSize.height < containerSize.width && YBIB_IS_IPHONEX) hExtra += YBIB_HEIGHT_EXTRABOTTOM;
    
    self.frame = CGRectMake(0, 0, width, height);
    self.gradient.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(0, height - kToolBarDefaultsHeight, width, kToolBarDefaultsHeight);
//    self.indexLabel.frame = CGRectMake(15 + hExtra, height - kToolBarDefaultsHeight, labelWidth, kToolBarDefaultsHeight);
    self.operationButton.frame = CGRectMake(width - buttonWidth - hExtra, height - kToolBarDefaultsHeight, buttonWidth, kToolBarDefaultsHeight);
}

- (void)yb_browserPageIndexChanged:(NSUInteger)pageIndex totalPage:(NSUInteger)totalPage data:(id<YBImageBrowserCellDataProtocol>)data {

    if ([data respondsToSelector:@selector(yb_browserSaveToPhotoAlbum)] && [data respondsToSelector:@selector(yb_browserAllowSaveToPhotoAlbum)] && [data yb_browserAllowSaveToPhotoAlbum]) {
        self.operationButton.hidden = NO;
        [self.operationButton setImage:[YBIBFileManager getImageWithName:@"ybib_save"] forState:UIControlStateNormal];
    }
    _data = data;

    _allL.text = [NSString stringWithFormat:@"全部%lu/%lu",pageIndex+1,(unsigned long)totalPage];
    
    NSInteger num = pageIndex+1;
    for (int i= 0; i<_numCount.count; i++) {
//        num = num-[_numCount[i][@"num"] integerValue];
        if ([_numCount[i][@"num"] integerValue]-num>=0) {
            _currentL.text = [NSString stringWithFormat:@"%@%ld/%@",_numCount[i][@"name"],num ,_numCount[i][@"num"]];
        [_XGColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
            return;
        }
        else
        {
            num = num -[_numCount[i][@"num"] integerValue];
        }
       
    }
    
}

//#pragma mark - event
//
- (void)clickOperationButton:(UIButton *)button {

        if ([_data respondsToSelector:@selector(yb_browserSaveToPhotoAlbum)]) {
                [_data yb_browserSaveToPhotoAlbum];
            } else {
                [[UIApplication sharedApplication].keyWindow yb_showForkTipView:[YBIBCopywriter shareCopywriter].unableToSave];
            }
    
}

#pragma mark - getter

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont boldSystemFontOfSize:16];
        _indexLabel.textAlignment = NSTextAlignmentLeft;
        _indexLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _indexLabel;
}

- (UIButton *)operationButton {
    if (!_operationButton) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _operationButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_operationButton addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationButton;
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        _gradient.startPoint = CGPointMake(0.5, 0);
        _gradient.endPoint = CGPointMake(0.5, 1);
        _gradient.colors = @[(id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0.3].CGColor, (id)[UIColor colorWithRed:0  green:0  blue:0 alpha:0].CGColor];
    }
    return _gradient;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"楼盘相册";
    }
    return _titleLabel;
}

@end
