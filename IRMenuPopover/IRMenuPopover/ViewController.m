//
//  ViewController.m
//  IRMenuPopover
//
//  Created by qiaoqiao on 2017/4/13.
//  Copyright © 2017年 irena. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "IRMenuPopover.h"
#import "IRItemModel.h"

@interface ViewController ()<IRMenuPopoverDelegate>
@property (weak, nonatomic) IBOutlet UIButton *topLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightButton;
@property (weak, nonatomic) IBOutlet UIButton *topRightButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftButton;

@property (nonatomic, strong) NSArray* menuSelectOption;

@property (nonatomic, strong) IRMenuPopover *menuPopver;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    IRItemModel *m1 = [IRItemModel itemWithTitleName:@"医生" value:@"1"];
    IRItemModel *m2 = [IRItemModel itemWithTitleName:@"警察" value:@"2"];
    IRItemModel *m3 = [IRItemModel itemWithTitleName:@"农民" value:@"3"];
    IRItemModel *m4 = [IRItemModel itemWithTitleName:@"工人" value:@"4"];
    
    self.menuSelectOption = @[m1,m2,m3,m4];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"<<<<<<<%@",NSStringFromCGRect(self.bottomLeftButton.frame));
    NSLog(@"mainScreen<<<<<<<%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
}
#pragma mark - buttonAction
- (IBAction)topLeftButtonAction:(id)sender {
    
    [self popSelectInputViewWithTargetFrame:self.topLeftButton.frame];
}
- (IBAction)topRightButtonAction:(id)sender {
    
    [self popSelectInputViewWithTargetFrame:self.topRightButton.frame];
    
}
- (IBAction)bottomLeftButtonAction:(id)sender {
    
    NSLog(@"bottomLeftButtonAction<<<<<<<%@",NSStringFromCGRect(self.bottomLeftButton.frame));
    
    [self popSelectInputViewWithTargetFrame:self.bottomLeftButton.frame];
    
}
- (IBAction)bottomRightButtonActoin:(id)sender {
    
    [self popSelectInputViewWithTargetFrame:self.bottomRightButton.frame];
    
}


-(void)popSelectInputViewWithTargetFrame:(CGRect)targetFrame{
    self.menuPopver = [[IRMenuPopover alloc] initWithTargetFrame:targetFrame menuItems:self.menuSelectOption showArrow:YES scrollEnabled:YES];
    
    self.menuPopver.menuPopoverDelegate = self;
    
    [self.menuPopver showInView:[UIApplication sharedApplication].keyWindow];

}


#pragma mark - delegate

- (void)menuPopover:(IRMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex{
    NSLog(@">>>>>>>>>>>didselect >>>>>>>>>%@",self.menuSelectOption[selectedIndex]);
    IRItemModel *item = self.menuSelectOption[selectedIndex];
    NSLog(@"%@=====%@",item.titleName,item.value);
}

- (void)hideMenuPopverWithMenuPopover:(IRMenuPopover *)menuPopover{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
