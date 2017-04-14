# IRMenuPopover
一个轻量级的menuPop
可以通完 **IRMenuPopoverGlobal.h** 文件进行弹出框的圆角及其它的基本信息的设置，可以通过storyboard或masonry使用

# 注意事项
* 此项目依赖于Masonry，使用cocoapods
请在引用此项目文件前导入 pod ‘Masonry’
项目文件主要包括： **menuPopoverImages.bundle、UIView+LayoutMethods.h、UIView+LayoutMethods.m、IRMenuPopover.h、IRMenuPopover.m、IRMenuPopoverGlobal.h**

# 使用
需实现 **IRMenuPopoverDelegate** 的两个代理方法

## 使用方法1
```NSArray * menuSelectOption = @[@"医生",@"警察",@"农民",@"工人"];

IRMenuPopover *menuPopver = [[IRMenuPopover alloc] initWithTargetFrame:targetFrame menuItems:menuSelectOption showArrow:YES scrollEnabled:YES];

menuPopver.menuPopoverDelegate = self;

[self.menuPopver show];
```

#API介绍
## 自动适配弹出框显示的位置
**initWithTargetFrame:menuItems:showArrow:scrollEnabled:**

**自动对框框进行布局，targetFrame为目标控件的frame
 框框自身的size由IRMenuPopoverGlobal.h文件配制
 框框在目标控件上显示的位置自动生成
 箭头的位置根据所显示的框框的位置自行以适配**

```/**
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
```

## 弹出框的位置通过isTop级对弹出框的布局决定
**initWithFrame:menuItems:showArrow:scrollEnabled:isTop:**
```/**
 通过外部对框框的布局配合isTop进行生成框框

 @param frame 框框要显示的位置
 @param aMenuItems 显示的列表项
 @param showArrow 是否显示箭头
 @param scrollEnabled 内部的列表项是否可以滚动
 @param isTop 是否在控件上面显示【需要与外部框框的布局配合使用】

 @return 选择框
 */
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems showArrow:(BOOL)showArrow scrollEnabled:(BOOL)scrollEnabled isTop:(BOOL)isTop;
```

###使用
```#pragma mark - 特别提示，isTop是与menuPopver的上布局配合使用
#pragma mark - 特别提示，此处的menuPopver是弹出的框框

    IRMenuPopover* menuPopver = [[IRMenuPopover alloc] initWithFrame:CGRectMake(self.menuPopoverX, menuPopoverY, MENU_POP_VIEW_WIDTH, MENU_POP_VIEW_HEIGHT) menuItems:self.menuItems showArrow:YES scrollEnabled:YES isTop:NO];

    self.menuPopver.menuPopoverDelegate = self;

    [self.menuPopver showInView:[UIApplication sharedApplication].keyWindow];

#pragma mark - 特别提示，此处的布局是弹出框框的位置布局
    /**
     *  当isTop=YES的时候
     */
    [self.menuPopver mas_makeConstraints:^(MASConstraintMaker *make) {
        //下  *** 当isTop == NO 的时候，此处必须为这句布局
        make.top.equalTo(self.mas_bottom);

        //上  *** 当isTop == YES的时候，此处必须为这句布局，否则会出现布局乱混
//        make.bottom.equalTo(self.mas_top);

        //左  ** 当框框在左面显示的时候
//        make.left.equalTo(self.mas_left);

        //右  ** 当框框在右面显示的时候
        make.right.equalTo(self.mas_right);

        make.height.mas_equalTo(MENU_POP_VIEW_HEIGHT);
        make.width.mas_equalTo(MENU_POP_VIEW_WIDTH);
    }];
```
