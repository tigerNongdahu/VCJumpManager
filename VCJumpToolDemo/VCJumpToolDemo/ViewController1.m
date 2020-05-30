//
//  ViewController1.m
//  VCJumpToolDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 TigerNong. All rights reserved.
//

#import "ViewController1.h"
#import "IDOJumpManager.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 100, 30)];
    [button setTitle:@"push Jump" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clilkJump) forControlEvents:UIControlEventTouchUpInside];
    
    self.title = self.param;
    
}

- (void)clilkJump{
    
    IDOJumpParameterModel *paramModel = [[IDOJumpParameterModel alloc] init];
    paramModel.param = @"push Jump";
    
    paramModel.returnBlock = ^(id  _Nullable obj) {
        NSLog(@" ViewController2 return value:%@",obj);
    };
    
    [[IDOJumpManager shareInstance] currentVC:self jumpPushToVC:@"ViewController2" parameter:paramModel];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if (self.returnBlock) {
        self.returnBlock(@"ViewController1 back");
    }
}


@end
