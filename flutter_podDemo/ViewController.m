//
//  ViewController.m
//  flutter_podDemo
//
//  Created by Jayehuang on 2021/5/18.
//

#import "ViewController.h"
#import "FlutterCustomController.h"

@interface ViewController ()
@property(nonatomic,strong)UILabel *fromFlutterTextLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
}
-(void)pushHomePage{
    FlutterCustomController *flutterViewController = [[FlutterCustomController alloc]initWithProject:nil initialRoute:@"/homePage" nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterViewController animated:YES];
    
    FlutterMethodChannel* testChannel = [FlutterMethodChannel methodChannelWithName:@"hj.flutter.dev/homePageTouch" binaryMessenger:flutterViewController.binaryMessenger
                                         ];
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
}
-(void)defaultPush{
    FlutterCustomController *flutterViewController = [[FlutterCustomController alloc] init];
    [self.navigationController pushViewController:flutterViewController animated:YES];
    
    FlutterMethodChannel* testChannel = [FlutterMethodChannel methodChannelWithName:@"hj.flutter.dev/pushToNative" binaryMessenger:flutterViewController.binaryMessenger
                                         ];
    __weak __typeof(self)weakSelf = self;
    [testChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        
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
-(void)btnAction{
    if (self.fromFlutterText) {
        /// 跳转指定路由界面
        [self pushHomePage];
        return;
    }
    /// 默认跳转
    [self defaultPush];
}
-(void)setUpUI{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 50);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"去flutter界面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = [UIColor orangeColor];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = @"这是原生界面";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
    textLabel.frame = CGRectMake(100, 200, 200, 50);
    
    UILabel *fromFlutterLabel = [[UILabel alloc]init];
    fromFlutterLabel.textColor = [UIColor orangeColor];
    fromFlutterLabel.font = [UIFont systemFontOfSize:16];
    fromFlutterLabel.numberOfLines = 0;
    fromFlutterLabel.text = @"";
    if (self.fromFlutterText&&![self.fromFlutterText isEqualToString:@""]) {
        fromFlutterLabel.text = self.fromFlutterText;
    }
    fromFlutterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:fromFlutterLabel];
    fromFlutterLabel.frame = CGRectMake(100, 300, 200, 80);
    self.fromFlutterTextLabel = fromFlutterLabel;
}

-(void)dealloc{
    NSLog(@"dealloc %@",self);
}
@end
