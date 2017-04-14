//
//  IRMenuPopover.h
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/4/13.
//  Copyright © 2017年 irena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRMenuPopoverGlobal.h"

@class IRMenuPopover;



@protocol IRMenuPopoverDelegate

- (void)menuPopover:(IRMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

//@optional
- (void)hideMenuPopverWithMenuPopover:(IRMenuPopover *)menuPopover;

@end

@interface IRMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<IRMenuPopoverDelegate> menuPopoverDelegate;


/**
 自动对框框进行布局，targetFrame为目标控件的frame
 框框自身的size由IRMenuPopoverGlobal.h文件配制
 框框在目标控件上显示的位置自动生成
 箭头的位置根据所显示的框框的位置自行以适配
 
 @param targetFrame 目标控件的位置
 @param aMenuItems 显示的列表项
 @param showArrow 是否显示箭头
 @param scrollEnabled 内部的列表项是否可以滚动
 
 @return 选择框
 */
- (id)initWithTargetFrame:(CGRect)targetFrame menuItems:(NSArray *)aMenuItems showArrow:(BOOL)showArrow scrollEnabled:(BOOL)scrollEnabled;

/**
 通过外部对框框的布局配合isTop进行生成框框
 
 @param frame 框框要显示的位置
 @param aMenuItems 显示的列表项
 @param showArrow 是否显示箭头
 @param scrollEnabled 内部的列表项是否可以滚动
 @param isTop 是否在控件上面显示【需要与外部框框的布局配合使用】
 
 @return 选择框
 */
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems showArrow:(BOOL)showArrow scrollEnabled:(BOOL)scrollEnabled isTop:(BOOL)isTop;


- (void)showInView:(UIView *)view;

- (void)dismissMenuPopover;

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
