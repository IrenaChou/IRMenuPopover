//
//  IRMenuPopoverGlobal.h
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/4/13.
//  Copyright © 2017年 irena. All rights reserved.
//

#ifndef IRMenuPopoverGlobal_h
#define IRMenuPopoverGlobal_h

//箭头显示的位置
typedef enum : NSUInteger {
    IRMenuPopoverArrowDirectionCenter,
    IRMenuPopoverArrowDirectionLeft,
    IRMenuPopoverArrowDirectionRight,
} IRMenuPopoverArrowDirection;

#define ARROW_DIRECTION IRMenuPopoverArrowDirectionRight

//箭头的宽度
#define ARROR_WIDTH 23

//圆角显示  【如不要圆角显示弹出框，请将此处设置为0，否则设置为所需圆角的值】
#define CORNER_RADIUS 10.0

//弹出的menuview的宽
#define MENU_POP_VIEW_WIDTH                 140.0

//弹出的menuview的高
#define MENU_POP_VIEW_HEIGHT                170.0

#define BUNDLE_NAME @"menuPopoverImages.bundle"

#define MENU_ITEM_HEIGHT        44
#define FONT_SIZE               15

#define MENU_TABLE_VIEW_FRAME   CGRectMake(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     CGRectMake(10, MENU_ITEM_HEIGHT - 1, self.frame.size.width - 20, 1)
#define MENU_POINTER_RECT       CGRectMake(frame.origin.x, frame.origin.y, 23, 11)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.1f)

//popSelectView背景颜色
#define POP_SELECT_VIEW_BACKGROUND_COLOR [UIColor blackColor]

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

#define MENU_POINT_VIEW_HEIGHT 11

#endif /* IRMenuPopoverGlobal_h */
