//
//  DropdownButton.h
//  Common
//  点击向下弹出的横向菜单
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKHHorizontalMenu;
@protocol showMenuDelegate <NSObject>

- (void)showDropdownButton:(GKHHorizontalMenu *)downButton MenuView:(UIButton *)selectView selectindex:(NSInteger)index;

- (void)hideMenuView:(UIButton *)selectVIew;

-(void)dropdownButton:(GKHHorizontalMenu *)downButton selectView:(UIButton *)selectView isSelect:(BOOL)isselect;
@end

@interface GKHHorizontalMenu : UIView {
    NSInteger _count;
    NSInteger _lastTap;
    NSString *_lastTapObj;
    UIImage *_image;
    
    BOOL _isButtion;
}

@property (nonatomic, strong) UIImageView *buttonImageView;
@property (nonatomic, assign) id<showMenuDelegate> delegate;
+ (GKHHorizontalMenu *)shareInstanceWithTitle:(NSArray*)titles withframe:(CGRect)frame delgate:(id<showMenuDelegate>)delgate withImage:(UIImage *)image;
/**是否允许旋转*/
@property (assign,nonatomic) BOOL isRotation ;
- (id)initDropdownButtonWithTitles:(NSArray*)titles withframe:(CGRect)frame;
- (void)setitleMenutitle:(NSString *)titleName withIndex:(NSInteger)index;
/**选择哪个*/
-(void)selectIndex:(NSInteger)index;
-(void)touchHidden;
@end
