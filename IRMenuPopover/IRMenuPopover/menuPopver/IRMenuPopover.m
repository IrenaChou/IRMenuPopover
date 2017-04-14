//
//  IRMenuPopover.m
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/4/13.
//  Copyright © 2017年 irena. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UIView+LayoutMethods.h"
#import "IRMenuPopover.h"
#import <Masonry.h>

#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define kMargin 10

@interface IRMenuPopover ()

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UIButton *containerButton;
@property (nonatomic, strong) UIImageView *menuPointerView;
@property (nonatomic, weak) id<IRMenuPopoverDelegate> menuDelegate;
@property (nonatomic, strong) UITableView *menuItemsTableView;
@end

@implementation IRMenuPopover

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems showArrow:(BOOL)showArrow scrollEnabled:(BOOL)scrollEnabled isTop:(BOOL)isTop
{
    self = [super initWithFrame:frame];
    
    if (self){
        
        self.menuItems = aMenuItems;
        
        //圆角
        if (CORNER_RADIUS) {
            self.layer.cornerRadius = CORNER_RADIUS;
            self.layer.masksToBounds = YES;
        }
        
        //显示箭头
        // Adding Menu Options Pointer
        if (showArrow) {
            
            [self addSubview:self.menuPointerView];
            
            
            if (isTop) {
                self.menuPointerView.transform = CGAffineTransformMakeRotation(M_PI);
            }
            
            [self.menuPointerView mas_makeConstraints:^(MASConstraintMaker *make) {
                switch (ARROW_DIRECTION) {
                    case IRMenuPopoverArrowDirectionCenter:
                        make.centerX.equalTo(self);
                        break;
                    case IRMenuPopoverArrowDirectionLeft:
                        make.left.equalTo(self).mas_offset(kMargin);
                        break;
                    case IRMenuPopoverArrowDirectionRight:
                        make.right.equalTo(self).mas_offset(-kMargin);
                        break;
                    default:
                        make.centerX.equalTo(self);
                        break;
                }
                make.width.mas_equalTo(ARROR_WIDTH);
                make.height.mas_equalTo(MENU_POINT_VIEW_HEIGHT);
                if (isTop) {
                    make.top.equalTo(self.mas_bottom).offset(-MENU_POINT_VIEW_HEIGHT);
                }else{
                    make.top.equalTo(self);
                }

            }];
        }
        
        self.menuItemsTableView.scrollEnabled = scrollEnabled;
        
        [self addSubview:self.menuItemsTableView];
        
        [self.menuItemsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (showArrow) {
                if (isTop) {
                    make.bottom.equalTo(self.menuPointerView.mas_top);
                }else{
                    make.top.equalTo(self.menuPointerView.mas_bottom);
                }
                make.height.equalTo(self).offset(-MENU_POINT_VIEW_HEIGHT);
            }else{
                if (isTop) {
                    make.bottom.equalTo(self);
                }else{
                    make.top.equalTo(self);
                }
                make.height.equalTo(self);
            }
            
            make.width.equalTo(self);
            make.left.equalTo(self);
        }];
        
        [self.containerButton addSubview:self];
        
        [self addSubview:self.menuItemsTableView];
        
        [self.containerButton addSubview:self];

    }
    
    return self;
}

#pragma mark  UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        
        //        [cell.textLabel setTextColor:[UIColor blackColor]];
        if (POP_SELECT_VIEW_BACKGROUND_COLOR == [UIColor blackColor]) {
            [cell.textLabel setTextColor:[UIColor whiteColor]];
        }else{
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }

        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    if( [tableView numberOfRowsInSection:indexPath.section] > ONE && !(indexPath.row == numberOfRows - 1) )
    {
        [self addSeparatorImageToCell:cell];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
}


#pragma mark - Actions

- (void)dismissMenuPopover
{
    [self.menuPopoverDelegate hideMenuPopverWithMenuPopover:self];
    
    [self hide];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self.containerButton];
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.containerButton.alpha = ONE;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                     }];
}

#pragma mark - Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    
    [separatorImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/define_line_black",BUNDLE_NAME]]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark - Orientation Methods

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
    
    if( landscape )
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
    else
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
}

#pragma mark - getter/setter
-(UIButton *)containerButton{
    if (!_containerButton) {
        _containerButton = [[UIButton alloc] init];
        
        _containerButton.alpha = ZERO;
        
        [_containerButton setBackgroundColor:[UIColor clearColor]];
        
        _containerButton.frame = [UIScreen mainScreen].bounds;
        
        [_containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        
        [_containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    }
    return _containerButton;
}

-(UIImageView *)menuPointerView{
    if (!_menuPointerView) {
        _menuPointerView = [[UIImageView alloc] init];
        
        self.menuPointerView.frame = CGRectMake(0,0, ARROR_WIDTH, MENU_POINT_VIEW_HEIGHT);
        
        _menuPointerView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/options_pointer",BUNDLE_NAME]];
        
        _menuPointerView.contentMode = UIViewContentModeScaleAspectFill;
        
        _menuPointerView.tag = MENU_POINTER_TAG;
    }
    return _menuPointerView;
}

-(UITableView *)menuItemsTableView{
    if (!_menuItemsTableView) {
        
        // Adding menu Items table
       _menuItemsTableView = [[UITableView alloc] init];
        
        _menuItemsTableView.dataSource = self;
        _menuItemsTableView.delegate = self;
        _menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _menuItemsTableView.backgroundColor = [UIColor clearColor];
        
        _menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        _menuItemsTableView.backgroundColor = POP_SELECT_VIEW_BACKGROUND_COLOR;
        
        if (CORNER_RADIUS) {
            _menuItemsTableView.layer.cornerRadius = CORNER_RADIUS;
            _menuItemsTableView.layer.masksToBounds = YES;
        }
    }
    return _menuItemsTableView;
}

-(void)dealloc{
    
    self.menuItems = nil;
    self.menuDelegate = nil;
    self.menuPopoverDelegate = nil;
    
    if (self.containerButton) {
        [self.containerButton removeFromSuperview];
        self.containerButton = nil;
    }
}
/**
 自动对框框进行布局，targetFrame为目标控件的frame
 框框自身的size由IRMenuPopoverGlobal.h文件配制
 框框在目标控件上显示的位置自动生成
 
 @param targetFrame 目标控件的位置
 @param aMenuItems 显示的列表项
 @param showArrow 是否显示箭头
 @param scrollEnabled 内部的列表项是否可以滚动
 
 @return 选择框
 */
- (id)initWithTargetFrame:(CGRect)targetFrame menuItems:(NSArray *)aMenuItems showArrow:(BOOL)showArrow scrollEnabled:(BOOL)scrollEnabled{
    CGFloat selfX,selfY;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    BOOL isTop = YES;
    IRMenuPopoverArrowDirection arrowDirection = IRMenuPopoverArrowDirectionCenter;
    
    if (targetFrame.origin.x <= screenSize.width * 0.5) {
        //左面显示
        selfX = targetFrame.origin.x;
        arrowDirection = IRMenuPopoverArrowDirectionLeft;
    }else{
        //右面显示
        selfX = CGRectGetMaxX(targetFrame) - MENU_POP_VIEW_WIDTH;
        arrowDirection = IRMenuPopoverArrowDirectionRight;
    }
    if (targetFrame.origin.y >= screenSize.height * 0.5) {
        //上
        isTop = YES;
        selfY = targetFrame.origin.y - MENU_POP_VIEW_HEIGHT;
    }else{
        //下
        isTop = NO;
        selfY = CGRectGetMaxY(targetFrame);
    }

    CGRect selfFrame = CGRectMake(selfX, selfY, MENU_POP_VIEW_WIDTH, MENU_POP_VIEW_HEIGHT);

    if (self = [super initWithFrame:selfFrame]) {
        self.menuItems = aMenuItems;

        //圆角
        if (CORNER_RADIUS) {
            self.layer.cornerRadius = CORNER_RADIUS;
            self.layer.masksToBounds = YES;
        }

        //显示箭头
        // Adding Menu Options Pointer
        if (showArrow) {

            [self addSubview:self.menuPointerView];


            if (isTop) {
                self.menuPointerView.transform = CGAffineTransformMakeRotation(M_PI);
            }

            [self.menuPointerView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (arrowDirection == IRMenuPopoverArrowDirectionLeft) {
                    make.left.equalTo(self).mas_offset(kMargin);
                }else if (arrowDirection == IRMenuPopoverArrowDirectionRight) {
                    make.right.equalTo(self).mas_offset(-kMargin);
                }else{
                    make.centerX.equalTo(self);
                }

                make.width.mas_equalTo(ARROR_WIDTH);
                make.height.mas_equalTo(MENU_POINT_VIEW_HEIGHT);
                if (isTop) {
                    make.top.equalTo(self.mas_bottom).offset(-MENU_POINT_VIEW_HEIGHT);
                }else{
                    make.top.equalTo(self);
                }

            }];
        }

        self.menuItemsTableView.scrollEnabled = scrollEnabled;

        [self addSubview:self.menuItemsTableView];

        [self.menuItemsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (showArrow) {
                if (isTop) {
                    make.bottom.equalTo(self.menuPointerView.mas_top);
                }else{
                    make.top.equalTo(self.menuPointerView.mas_bottom);
                }
                make.height.equalTo(self).offset(-MENU_POINT_VIEW_HEIGHT);
            }else{
                if (isTop) {
                    make.bottom.equalTo(self);
                }else{
                    make.top.equalTo(self);
                }
                make.height.equalTo(self);
            }

            make.width.equalTo(self);
            make.left.equalTo(self);
        }];

        [self.containerButton addSubview:self];

        [self addSubview:self.menuItemsTableView];

        [self.containerButton addSubview:self];
    }
    return self;
}
@end
