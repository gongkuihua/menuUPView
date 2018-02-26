//
//  UpListView.h
//  PocketJoyUser
//
//  Created by xynet on 16/2/2.
//  Copyright © 2016年 GKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UpListView;

@protocol UPlsitdelgate <NSObject>
@required
-(NSInteger) numberOfRowsUPlistView:(UpListView *)listView;
-(NSString *)UPlistView:(UIView *)listView TitleForindex:(NSInteger)index;
@optional
-(void)UPlistView:(UIView *)listView didselect:(NSInteger)index;
@end


@interface UpListView : UIView
@property (strong,nonatomic) void(^selectindex)(NSInteger selectindex);
@property (weak,nonatomic) id <UPlsitdelgate> delgate;
+ (instancetype)sharedInstanceInview:(UIView *)Inview;
- (void)showMassage:(NSArray *)titleArry frame:(CGRect)frame selectindex:(void(^)(NSInteger index))selectindex;

-(void)dissMiss;
@end
