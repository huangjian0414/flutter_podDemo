//
//  AppDelegate.h
//  flutter_podDemo
//
//  Created by Jayehuang on 2021/5/18.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

@interface AppDelegate : FlutterAppDelegate <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///一般只有一个flutter入口，可以用一个全局的engine 提前渲染
@property(nonatomic,strong)FlutterEngine *flutterEngine;

///如果是复杂关系，原生->flutter->原生->flutter  用group  如本例子
@property(nonatomic,strong)FlutterEngineGroup *engineGroup;
@end

