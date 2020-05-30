//
//  IDOJumpManager.m
//  IDOUIKitDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import "IDOJumpManager.h"
#import <objc/runtime.h>

/**
 系统默认的present范式
 */
#define kDefaultSystemModalPresentationStyle -1


@implementation IDOJumpParameterModel


@end


@interface IDOJumpManager ()

@property (nonatomic, strong) UIViewController *currentVC;

@end


@implementation IDOJumpManager


+ (IDOJumpManager *)shareInstance{
    static IDOJumpManager *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[IDOJumpManager alloc] init];
    });
    
    return _manager;
}

- (void)currentVC:(UIViewController *)currentVC
         jumpToVC:(NSString *)vc
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
           isPush:(BOOL)push{
    
    [self currentVC:currentVC
           jumpToVC:vc
             isPush:push
          naviClass:nil
modalPresentationStyle:modalPresentationStyle
          parameter:nil];
    
}

- (void)currentVC:(UIViewController *)currentVC jumpPushToVC:(NSString *)vc{
    
    [self currentVC:currentVC
           jumpToVC:vc
modalPresentationStyle:kDefaultSystemModalPresentationStyle
             isPush:YES];
    
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc{
    
    [self currentVC:currentVC
           jumpToVC:vc
modalPresentationStyle:kDefaultSystemModalPresentationStyle
             isPush:NO];
    
}

- (void)currentVC:(UIViewController *)currentVC
     jumpPushToVC:(NSString *)vc
        parameter:(IDOJumpParameterModel *)paramModel{
    
    [self currentVC:currentVC
           jumpToVC:vc
             isPush:YES
          naviClass:nil
modalPresentationStyle:kDefaultSystemModalPresentationStyle
          parameter:paramModel];
    
}

- (void)currentVC:(UIViewController *)currentVC jumpPresentToVC:(NSString *)vc parameter:(IDOJumpParameterModel *)paramModel{
    [self currentVC:currentVC jumpPresentToVC:vc modalPresentationStyle:kDefaultSystemModalPresentationStyle parameter:paramModel];
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel *)paramModel{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:nil modalPresentationStyle:modalPresentationStyle parameter:paramModel];
}

- (void)currentVC:(UIViewController *)currentVC
jumpPresentToSystemNaviVC:(NSString *)vc{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:NSStringFromClass([UINavigationController class]) modalPresentationStyle:kDefaultSystemModalPresentationStyle parameter:nil];
}

- (void)currentVC:(UIViewController *)currentVC
jumpPresentSystemNaviToVC:(NSString *)vc
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:NSStringFromClass([UINavigationController class]) modalPresentationStyle:kDefaultSystemModalPresentationStyle parameter:paramModel];
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:naviClass modalPresentationStyle:kDefaultSystemModalPresentationStyle parameter:paramModel];
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:naviClass modalPresentationStyle:kDefaultSystemModalPresentationStyle parameter:nil];
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:naviClass modalPresentationStyle:modalPresentationStyle parameter:nil];
}

- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel{
    
    [self currentVC:currentVC jumpToVC:vc isPush:NO naviClass:naviClass modalPresentationStyle:modalPresentationStyle parameter:paramModel];
}


- (void)currentVC:(UIViewController *)currentVC
         jumpToVC:(NSString *)vc
           isPush:(BOOL)push
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel  * _Nullable )paramModel{
    
    //去掉空格
    vc = [vc stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSAssert(vc.length > 0, @"vc 不能为空值");

    //字符串转类
    Class cls = NSClassFromString(vc);
    id obj = [[cls alloc] init];
    
    //断言判断是否是控制器
    NSAssert([obj isKindOfClass: [UIViewController class]], @"当前输入的vc不是继承 UIViewController 的控制器");

    if ([obj isKindOfClass: [UIViewController class]]) {
        UIViewController *baseVC = (UIViewController *)obj;
        //如果存在有参数，则进行设置数据
        if (paramModel) {
            [self setUpVC:obj parameter:paramModel];
        }
        
        baseVC.hidesBottomBarWhenPushed = YES;
        
        if (push) {
            [currentVC.navigationController pushViewController:baseVC animated:YES];
        }else{
            
            if (naviClass != nil) {
                Class navClass = NSClassFromString(naviClass);
                id navObj = [[navClass alloc] init];
                 NSAssert([navObj isKindOfClass: [UINavigationController class]], @"当前输入的naviClass不是继承 UINavigationController 的控制器");
                if ([navObj isKindOfClass: [UINavigationController class]]) {
                    baseVC = [[navClass alloc] initWithRootViewController:baseVC];
                }
            }
            
            if (modalPresentationStyle != kDefaultSystemModalPresentationStyle) {
                baseVC.modalPresentationStyle = modalPresentationStyle;
            }
            
            [currentVC presentViewController:baseVC animated:YES completion:nil];
        }
    }
}


- (void)setUpVC:(UIViewController *)vc parameter:(IDOJumpParameterModel  * _Nullable )paramModel{
    self.currentVC = vc;
    [self queryVCParam:vc originVC:vc parameter:paramModel];
}


- (void)queryVCParam:(UIViewController *)vc originVC:(UIViewController *)originVC parameter:(IDOJumpParameterModel  * _Nullable )paramModel{
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([vc class], &count);
    
    BOOL isHaveParam = NO;
    
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
        if ([name isEqualToString:@"param"]) {
            [originVC setValue:paramModel.param forKey:@"param"];
            isHaveParam = YES;
        }

        if ([name isEqualToString:@"returnBlock"]) {
            [originVC setValue:paramModel.returnBlock forKey:@"returnBlock"];
            isHaveParam = YES;
        }
    }
    
    if (isHaveParam == NO) {
        //如果没有找打，则继续去父类控制器查找
        id currentVC = self.currentVC.superclass;
        self.currentVC = currentVC;
        //如果到了 UIViewController 还是没有，则
        if (![NSStringFromClass([self.currentVC class]) isEqualToString:@"UIViewController"]) {
             [self queryVCParam:self.currentVC originVC:originVC parameter:paramModel];
        }
    }
}


@end
