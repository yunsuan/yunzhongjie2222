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

static CGFloat kToolBarDefaultsHeight = 50.0;

@interface ToolBarView  ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
    id<YBImageBrowserCellDataProtocol> _data;
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
        [self addSubview:self.indexLabel];
        [self addSubview:self.operationButton];
        [self addSubview:self.titleLabel];
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(78 *SIZE, 27 *SIZE);
        _flowLayout.minimumInteritemSpacing = 7 *SIZE;
        //    _flowLayout.sectionInset = UIEdgeInsetsMake(SIZE, 10 *SIZE, 27 *SIZE, 10 *SIZE);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _currentL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 5 *SIZE, 100 *SIZE, 12 *SIZE)];
        _currentL.textColor = CLContentLabColor;
        _currentL.font = [UIFont systemFontOfSize:12 *SIZE];
        [self addSubview:_currentL];
        
        _allL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 5 *SIZE, 100 *SIZE, 12 *SIZE)];
        _allL.textColor = CLContentLabColor;
        _allL.font = [UIFont systemFontOfSize:12 *SIZE];
        _allL.textAlignment = NSTextAlignmentRight;
        [self addSubview:_allL];
        
        _XGColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 *SIZE, SCREEN_Width, 55 *SIZE) collectionViewLayout:_flowLayout];
        _XGColl.backgroundColor = [UIColor clearColor];
        _XGColl.delegate = self;
        _XGColl.dataSource = self;
        [_XGColl registerClass:[AlbumCollCell class] forCellWithReuseIdentifier:@"AlbumCollCell"];
        [self addSubview:_XGColl];
    }
    return self;
}

#pragma mark - public

//- (void)setOperationButtonImage:(UIImage *)image title:(NSString *)title operation:(YBImageBrowserToolBarOperationBlock)operation {
//    [self.operationButton setImage:image forState:UIControlStateNormal];
//    [self.operationButton setTitle:title forState:UIControlStateNormal];
//    _operation = operation;
//    _operationType = YBImageBrowserToolBarOperationTypeCustom;
//}

//- (void)hideOperationButton {
//    [self setOperationButtonImage:nil title:nil operation:nil];
//}

#pragma mark - <YBImageBrowserToolBarProtocol>

- (void)yb_browserUpdateLayoutWithDirection:(YBImageBrowserLayoutDirection)layoutDirection containerSize:(CGSize)containerSize {
    CGFloat height = kToolBarDefaultsHeight, width = containerSize.width, buttonWidth = 53, labelWidth = width / 3.0, hExtra = 0;
    if (containerSize.height > containerSize.width && YBIB_IS_IPHONEX) height += YBIB_HEIGHT_STATUSBAR;
    if (containerSize.height < containerSize.width && YBIB_IS_IPHONEX) hExtra += YBIB_HEIGHT_EXTRABOTTOM;
    
    self.frame = CGRectMake(0, 0, width, height);
    self.gradient.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(0, height - kToolBarDefaultsHeight, width, kToolBarDefaultsHeight);
    self.indexLabel.frame = CGRectMake(15 + hExtra, height - kToolBarDefaultsHeight, labelWidth, kToolBarDefaultsHeight);
    self.operationButton.frame = CGRectMake(width - buttonWidth - hExtra, height - kToolBarDefaultsHeight, buttonWidth, kToolBarDefaultsHeight);
}

- (void)yb_browserPageIndexChanged:(NSUInteger)pageIndex totalPage:(NSUInteger)totalPage data:(id<YBImageBrowserCellDataProtocol>)data {
//    switch (_operationType) {
//        case YBImageBrowserToolBarOperationTypeSave: {
//            if ([data respondsToSelector:@selector(yb_browserSaveToPhotoAlbum)] && [data respondsToSelector:@selector(yb_browserAllowSaveToPhotoAlbum)] && [data yb_browserAllowSaveToPhotoAlbum]) {
//                self.operationButton.hidden = NO;
//                [self.operationButton setImage:[YBIBFileManager getImageWithName:@"ybib_save"] forState:UIControlStateNormal];
//            } else {
//                self.operationButton.hidden = YES;
//            }
//        }
//            break;
//        case YBImageBrowserToolBarOperationTypeMore: {
//            self.operationButton.hidden = NO;
//            [self.operationButton setImage:[YBIBFileManager getImageWithName:@"ybib_more"] forState:UIControlStateNormal];
//        }
//            break;
//        case YBImageBrowserToolBarOperationTypeCustom: {
//            self.operationButton.hidden = !_operation;
//        }
//            break;
//    }
//
    _data = data;
    if (totalPage <= 1) {
        self.indexLabel.hidden = YES;
    } else {
        self.indexLabel.hidden  = NO;
        self.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld", (unsigned long)(pageIndex + 1), (unsigned long)totalPage];
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
