//
//  UpListView.m
//  PocketJoyUser
//  下拉列表
//  Created by xynet on 16/2/2.
//  Copyright © 2016年 GKH. All rights reserved.
//

#import "UpListView.h"
// 屏幕宽高
#define screen_Height [UIScreen mainScreen].bounds.size.height
#define screen_Width  [UIScreen mainScreen].bounds.size.width
//#import "PJGkhPokeyJoyHeader.h"
@interface UpListView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *showView;
@property (strong,nonatomic) NSArray *dataArry;
@property (strong,nonatomic) NSDictionary *dict;

@end
@implementation UpListView
+ (instancetype)sharedInstanceInview:(UIView *)Inview{
    static UpListView *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
        UITableView *tableVIew=[[UITableView alloc]init];
        tableVIew.delegate=sharedInstance;
        tableVIew.dataSource=sharedInstance;
        tableVIew.tableFooterView=[[UIView alloc]init];
        tableVIew.backgroundColor=[UIColor colorWithHexColorString:@"f5f5f5"];
        sharedInstance.backgroundColor=[UIColor colorWithHexColorString:@"f5f5f5"];
//        tableVIew.separatorColor=[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
        tableVIew.separatorStyle=UITableViewCellSeparatorStyleNone;
        sharedInstance.tableView=tableVIew;
        sharedInstance.tag=100;
        [sharedInstance addSubview:tableVIew];
        [Inview addSubview:sharedInstance];
    });
     sharedInstance.showView=Inview;
    return sharedInstance;
}
- (void)showMassage:(NSArray *)titleArry frame:(CGRect)frame selectindex:(void(^)(NSInteger index))selectindex{
       self.dataArry=titleArry;
    
        BOOL islook=NO;
        for (UIView *view in self.showView.subviews) {
            if (view.tag!=100) {
                [self addSubview:self.tableView];
                 [self.tableView reloadData];
//                self.tableView.delegate=self;
//                self.tableView.dataSource=self;
                [self.showView addSubview:self];
                islook=YES;
                break;
            }
        }
     self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    self.tableView.frame=self.bounds;
    self.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        //判断当前高度是否大于屏幕，如果大于保持滑动
        float hight=frame.origin.y*titleArry.count;
        float screnhight=screen_Height-frame.origin.y-64-20;
        if (hight>=screnhight) {
            hight=screnhight;
        }
        [self setHeight:hight];
        [self.tableView setHeight:hight];
        self.selectindex = selectindex;
    }];
}
-(void)dissMiss{
    [UIView animateWithDuration:1.0 animations:^{
//        [self.showView removeFromSuperview];
//        self.frame=CGRectMake(self.frame.origin.x, frame.origin.y, self.width, 0);
        [self setHeight:0];
        self.tableView.frame=self.bounds;
        self.hidden=YES;
//        [self.showView removeFromSuperview];
    }];
}
#pragma mark--tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArry.count!=0) {
       return self.dataArry.count;
    }else{
        if (self.delgate &&[self.delgate respondsToSelector:@selector(numberOfRowsUPlistView:)]) {
              return [self.delgate numberOfRowsUPlistView:self];
        }else{
            return 0;
        }
      
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *lable;
    if (!cell) {
        cell=[[UITableViewCell alloc]init];
        lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        lable.font=[UIFont systemFontOfSize:14];
        lable.textColor=BrunetteblackColor;
        lable.textAlignment=NSTextAlignmentCenter;
//        [cell.contentView addSubview:lable];
        cell.contentView.backgroundColor=[UIColor colorWithHexColorString:@"f5f5f5"];
        [self addlineView:cell.contentView];
//        [cell addSingleBorder:UIViewBorderDirectBottom color:[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0] width:1];
//        [cell.contentView addSingleBorder:UIViewBorderDirectBottom color:PjBackGroundColor width:1];
    }
    if(self.dataArry.count!=0){
//        cell.textLabel.text=self.dataArry[indexPath.row];
//        if (indexPath.row == 0) {
//            lable.text = @"全部";
//        }else{
            cell.textLabel.text=self.dataArry[indexPath.row];
//        }
        
    }else{
        if(self.delgate &&[self.delgate respondsToSelector:@selector(UPlistView:TitleForindex:)]){
            cell.textLabel.text=[self.delgate UPlistView:self TitleForindex:indexPath.row];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectindex) {
        self.selectindex(indexPath.row);
    }
    [self dissMiss];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)addlineView:(UIView *)lineView{
    UIView *line=[[UIView alloc] init];
    
    //设置颜色
    line.backgroundColor=[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
    line.frame=CGRectMake(0, lineView.bounds.size.height, self.frame.size.width, 1);
    //添加
    [lineView addSubview:line];

}
@end
