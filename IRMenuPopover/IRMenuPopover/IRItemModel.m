//
//  IRItemModel.m
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/6/5.
//  Copyright © 2017年 irena. All rights reserved.
//

#import "IRItemModel.h"

@implementation IRItemModel
+(instancetype)itemWithTitleName:(NSString*)titleName value:(NSString*)value{
    IRItemModel *item = [[IRItemModel alloc]init];
    item.titleName = titleName;
    item.value = value;
    return item;
}
@end
