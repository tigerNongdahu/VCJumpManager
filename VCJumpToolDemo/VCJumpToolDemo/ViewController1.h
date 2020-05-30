//
//  ViewController1.h
//  VCJumpToolDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController1 : UIViewController

@property (nonatomic, copy) id param;

@property (nonatomic, copy) void (^returnBlock)(id _Nullable obj);

@end

NS_ASSUME_NONNULL_END
