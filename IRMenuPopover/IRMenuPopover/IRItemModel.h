//
//  IRItemModel.h
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/6/5.
//  Copyright © 2017年 irena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRItemModel : NSObject
@property (nonatomic, copy) NSString* titleName;
@property (nonatomic, copy) NSString* value;

+(instancetype)itemWithTitleName:(NSString*)titleName value:(NSString*)value;
@end
