//
//  ViewController.m
//  VCJumpToolDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 TigerNong. All rights reserved.
//

#import "ViewController.h"
#import "IDOJumpManager.h"
#import "CustomNaviViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 100, 30)];
    [button setTitle:@"Present Jump" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clilkJump) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clilkJump{
    
    IDOJumpParameterModel *paramModel = [[IDOJumpParameterModel alloc] init];
    paramModel.param = @"Present Jump";
    
    paramModel.returnBlock = ^(id  _Nullable obj) {
        NSLog(@" ViewController1 return value:%@",obj);
    };
    
    
    [[IDOJumpManager shareInstance] currentVC:self jumpPresentToVC:@"ViewController1" naviClass:@"CustomNaviViewController" parameter:paramModel];
    
}




@end
