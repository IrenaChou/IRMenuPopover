//
//  IRMenuPopoverTests.m
//  IRMenuPopoverTests
//
//  Created by qiaoqiao on 2017/4/13.
//  Copyright © 2017年 irena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+rex.h"
@interface IRMenuPopoverTests : XCTestCase

@end

@implementation IRMenuPopoverTests

- (void)setUp {
    [super setUp];
    if ([NSObject verifyingMoneyWithMoneyText:@"0222232.222210"]) {
        NSLog(@">>>>>>>合法");
    }else{
        NSLog(@">>>>>>>不不不合法");
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
