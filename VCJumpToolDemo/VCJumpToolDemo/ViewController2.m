//
//  ViewController2.m
//  VCJumpToolDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 TigerNong. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.title = self.param;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if (self.returnBlock) {
        self.returnBlock(@"ViewController2 back");
    }
}


@end
