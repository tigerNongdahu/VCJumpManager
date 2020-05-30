//
//  IDOJumpManager.h
//  IDOUIKitDemo
//
//  Created by TigerNong on 2020/5/30.
//  Copyright © 2020 农大浒. All rights reserved.
//


/**
 
 这个是一个模块内，控制器之间的跳转
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOJumpParameterModel : NSObject

/**
 参数数据，param不能直接设置为模型对象,必须是NS开头的类型才可以，比如可以把模型放入到NSArray或者NSDictionary里面
 
 param 这个不能修改，因为里面要使用到这个的字符串
 
 */
@property (nonatomic, copy) id param;

/**
 参数回调
 
 returnBlock 这个不能修改，因为里面要使用到这个的字符串
 */
@property (nonatomic, copy) void (^returnBlock)(id _Nullable obj);

@end


@interface IDOJumpManager : NSObject

+ (IDOJumpManager *)shareInstance;


/**
 不带参数的跳转,push跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 */
- (void)currentVC:(UIViewController *)currentVC jumpPushToVC:(NSString *)vc;


/**
 带参数的跳转,push跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
     jumpPushToVC:(NSString *)vc
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;

/**
 不带参数的跳转,present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 */
- (void)currentVC:(UIViewController *)currentVC jumpPresentToVC:(NSString *)vc;

/**
 不带参数的跳转，带有系统的导航控制器,present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 */
- (void)currentVC:(UIViewController *)currentVC jumpPresentToSystemNaviVC:(NSString *)vc;

/**
 带参数的跳转,present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;

/**
 带参数的跳转,带有系统的导航控制器，present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentSystemNaviToVC:(NSString *)vc
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;


/**
 不带参数的跳转,带有继承UINavigationController的导航控制器，present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param naviClass 导航控制器的字符串
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass;

/**
 带参数的跳转,带有继承UINavigationController的导航控制器，present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param naviClass 导航控制器的字符串
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;


/**
 不带参数的跳转,带有继承UINavigationController的导航控制器，present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param naviClass 导航控制器的字符串
 @param modalPresentationStyle 显示的方式
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle;

/**
 带参数的跳转,带有继承UINavigationController的导航控制器，present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param naviClass 导航控制器的字符串
 @param modalPresentationStyle 显示的方式
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;

/**
 带参数的跳转,present跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param modalPresentationStyle 显示的方式
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 */
- (void)currentVC:(UIViewController *)currentVC
  jumpPresentToVC:(NSString *)vc 
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;

/**
 不带参数的跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param push 是否push
 */
- (void)currentVC:(UIViewController *)currentVC
         jumpToVC:(NSString *)vc
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
           isPush:(BOOL)push;

/**
 带参数的跳转
 
 @param currentVC 当前控制器
 @param vc 目标控制器
 @param push 是否push，这个是存在有导航栏的情况下才会有效
 @param naviClass 导航控制器的字符串，这个主要是使用在present的，带有导航栏的present
 @param paramModel 参数模型，如果有传值，则在vc中至少要定义IDOJumpParameterModel 中的一个属性，一模一样的属性
 
 */
- (void)currentVC:(UIViewController *)currentVC
         jumpToVC:(NSString *)vc
           isPush:(BOOL)push
        naviClass:(NSString * _Nullable)naviClass
modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
        parameter:(IDOJumpParameterModel  * _Nullable)paramModel;

@end

NS_ASSUME_NONNULL_END
