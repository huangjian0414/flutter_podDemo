//
//  FlutterCustomController.m
//  flutter_podDemo
//
//  Created by Jayehuang on 2021/5/18.
//

#import "FlutterCustomController.h"
#import "ViewController.h"

@interface FlutterCustomController ()

@end

@implementation FlutterCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FlutterMethodChannel *testChannel = [FlutterMethodChannel methodChannelWithName:@"hj.flutter.dev/homePageTouch" binaryMessenger:self.binaryMessenger];
    __weak __typeof(self)weakSelf = self;
    [testChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        
        NSLog(@"方法%@", call.method);
        //参数
        NSLog(@"参数%@", call.arguments[@"param"]);
        
        if ([@"homePageTouch" isEqualToString:call.method]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:call.arguments[@"param"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            result([[NSBundle mainBundle] bundleIdentifier]);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    FlutterMethodChannel* testChannel1 = [FlutterMethodChannel methodChannelWithName:@"hj.flutter.dev/pushToNative" binaryMessenger:self.binaryMessenger];
    [testChannel1 setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        
        NSLog(@"方法%@", call.method);
        //参数
        NSLog(@"参数%@", call.arguments[@"param"]);
        
        if ([@"pushToNative" isEqualToString:call.method]) {
            ViewController *vc = [[ViewController alloc]init];
            vc.fromFlutterText = [NSString stringWithFormat:@"flutter传了参数：你按了%ld下",[call.arguments[@"param"] integerValue]];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

-(void)dealloc{
    NSLog(@"dealloc %@",self);
}

@end
