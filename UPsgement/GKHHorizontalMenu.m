//
//  DropdownButton.m
//  Common
//
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import "GKHHorizontalMenu.h"
// 屏幕宽高
#define screen_Height [UIScreen mainScreen].bounds.size.height
#define screen_Width  [UIScreen mainScreen].bounds.size.width
#define BUTTON_HEIGHT 40.0
#define kImagename @""
@interface GKHHorizontalMenu ()
//@property (nonatomic,strong) UIImage *sanjiaoImage;
@end
@implementation GKHHorizontalMenu
+ (GKHHorizontalMenu *)shareInstanceWithTitle:(NSArray*)titles withframe:(CGRect)frame delgate:(id<showMenuDelegate>)delgate withImage:(UIImage *)image{
    GKHHorizontalMenu *dropdown=[[GKHHorizontalMenu alloc]initDropdownButtonWithTitles:titles withframe:frame withImage:image];
    dropdown.delegate=delgate;
//    dropdown.sanjiaoImage=image;
//    dropdown.buttonImageView.image=image;
    return dropdown;
}
- (id)initDropdownButtonWithTitles:(NSArray*)titles withframe:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isButtion = NO;
        _count = titles.count;
//        _
        self.isRotation=YES;
        [self addButtonToView:titles];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenu:) name:@"hideMenu" object:_lastTapObj];
    }
    return self;
}
- (id)initDropdownButtonWithTitles:(NSArray*)titles withframe:(CGRect)frame withImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        _isButtion = NO;
        self.isRotation=YES;
        _count = titles.count;
        _image=image;
        //        _
        [self addButtonToView:titles];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenu:) name:@"hideMenu" object:_lastTapObj];
    }
    return self;
}
- (void)addButtonToView:(NSArray *)titles {
    for (int i = 0; i < _count; i++) {
        UIButton *button = [self makeButton:[titles objectAtIndex:i] andIndex:i];
//        button.backgroundColor=[UIColor clearColor];
        [self addSubview:button];
        if (i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x, 10, 1, 20)];
            lineView.backgroundColor = [UIColor colorWithRed:(217.0 / 255.0) green:(217.0 / 255.0) blue:(217.0 / 255.0) alpha:1.0f];
            [self addSubview:lineView];
        }
    }
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:(217.0 / 255.0) green:(217.0 / 255.0) blue:(217.0 / 255.0) alpha:1.0f];
    [self addSubview:bottomLine];
}
-(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
- (UIButton *)makeButton:(NSString *) title andIndex:(int)index{
    float width = [self returnTitlesWidth];
    float offsetX = width * index;
//    _image = [self reSizeImage:self.sanjiaoImage toSize:CGSizeMake(15, 9)];
  //     float padding = (width - (_image.size.width + [title sizeWithAttributes:dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10]])) / 2;
//    [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,blackColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal]
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, 0, width, self.frame.size.height)];
    button.tag = 10000 + index;
    [button setImage:_image forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12.0f*screen_Width/320]];
    float padding = (width - (_image.size.width + [title sizeWithFont:button.titleLabel.font].width)) / 2;
//        float padding = 8;
    //文字和图片的总共宽度
    float buttontitleandImagewidth=[title sizeWithFont:button.titleLabel.font].width+_image.size.width+padding;

    //将图片移到字体的右边
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-buttontitleandImagewidth/2, 0, 0)];

    [button setImageEdgeInsets:UIEdgeInsetsMake(0, [title sizeWithFont:button.titleLabel.font].width + padding, 0, 0)];

    [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor colorWithRed:77/250.0 green:77/250.0 blue:77/250.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)setitleMenutitle:(NSString *)titleName withIndex:(NSInteger)index;{
    
    UIButton *button=(UIButton *)[self viewWithTag:index+10000];
     [button setTitle:titleName forState:UIControlStateNormal];
     [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    //将图片移到字体的右边
    float width = [self returnTitlesWidth];
    float padding = (width - (_image.size.width + [titleName sizeWithFont:button.titleLabel.font].width)) / 2;
    //        float padding = 8;
    //文字和图片的总共宽度
    float buttontitleandImagewidth=[titleName sizeWithFont:button.titleLabel.font].width+_image.size.width+padding;
    
    //将图片移到字体的右边
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-buttontitleandImagewidth/2, 0, 0)];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, [titleName sizeWithFont:button.titleLabel.font].width + padding, 0, 0)];
    
    [button setTitle:titleName forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor colorWithRed:77/250.0 green:77/250.0 blue:77/250.0 alpha:1.0] forState:UIControlStateNormal];
}
- (float)returnTitlesWidth {
    float width = self.frame.size.width / _count;
    return width;
}

- (void)showMenuAction:(id)sender {
    NSInteger i = [sender tag];
    [self openMenuBtnAnimation:i];
}
-(void)selectIndex:(NSInteger)index{
    [self openMenuBtnAnimation:index+10000];
}
- (void)openMenuBtnAnimation:(NSInteger)index{
    UIButton *button=(UIButton *)[self viewWithTag:index];
    if (_lastTap != index) {
        if (_lastTap > 0) {
            [self changeButtionTag:_lastTap Rotation:0];
        }
        _lastTap = index;
        [self changeButtionTag:index Rotation:M_PI];
        if(self.delegate &&[self.delegate respondsToSelector:@selector(showDropdownButton:MenuView:selectindex:)]){
//            [self.delegate showMenuView:button selectindex:index-10000];
            [self.delegate showDropdownButton:self MenuView:button selectindex:index-10000];
        }
    } else {
//        if(self.isRotation){
            _isButtion = YES;
            [self changeButtionTag:_lastTap Rotation:0];
            _lastTap = 0;
//        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(hideMenuView:)]) {
            [self.delegate hideMenuView:button];
        }
    }
}
-(void)touchHidden{
//    if(self.isRotation){
        _isButtion = YES;
        [self changeButtionTag:_lastTap Rotation:0];
        _lastTap = 0;
//    }

}
//- (void)hideMenu:(NSNotification *)notification {
//    _lastTapObj = [notification object];
//    if (_isButtion != YES) {
//        [self changeButtionTag:([_lastTapObj intValue] + 10000) Rotation:0];
//        _isButtion = NO;
//    }
//    _lastTap = 0;
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideMenu" object:nil];
////    [[NSNotificationCenter defaultCenter] removeObserver:_lastTapObj name:nil object:self];
////    [notification removeObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#>];
//}

- (void)changeButtionTag:(NSInteger)index Rotation:(CGFloat)angle {
    [UIView animateWithDuration:0.1f animations:^{
        UIButton *btn = (UIButton *)[self viewWithTag:index];
        if (angle == 0) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(dropdownButton:selectView:isSelect:)]) {
                [self.delegate dropdownButton:self selectView:btn isSelect:YES];
            }
//            [btn setBackgroundColor:[UIColor clearColor]];
//            [btn setTitleColor:rgb(101, 101, 101) forState:UIControlStateNormal];
        } else {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(dropdownButton:selectView:isSelect:)]) {
                [self.delegate dropdownButton:self selectView:btn isSelect:NO];
            }

//             [btn setTitleColor:rgb(39, 185, 254) forState:UIControlStateNormal];
//            [btn setBackgroundColor:[UIColor colorWithRed:(221.0/255.0) green:(221.0/255.0) blue:(221.0/255.0) alpha:1.0f]];
        }
        if (self.isRotation) {
                btn.imageView.transform = CGAffineTransformMakeRotation(angle);
        }

    }];
}

@end
