//
//  ViewController.m
//  flutter_podDemo
//
//  Created by Jayehuang on 2021/5/18.
//

#import "ViewController.h"
#import "FlutterCustomController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property(nonatomic,strong)UILabel *fromFlutterTextLabel;

@property(nonatomic,strong)FlutterEngine *firstEngine;
@property(nonatomic,strong)FlutterEngine *secondEngine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    
    FlutterEngineGroup *group = ((AppDelegate *)UIApplication.sharedApplication.delegate).engineGroup;
    self.firstEngine = [group makeEngineWithEntrypoint:nil libraryURI:nil];
    [self.firstEngine run];
    self.secondEngine = [group makeEngineWithEntrypoint:@"otherMain" libraryURI:nil];
    [self.secondEngine run];
    
}
-(void)pushHomePage{
//    FlutterCustomController *flutterViewController = [[FlutterCustomController alloc]initWithProject:nil initialRoute:@"/homePage" nibName:nil bundle:nil];
//    [self.navigationController pushViewController:flutterViewController animated:YES];
    FlutterCustomController *vc = [[FlutterCustomController alloc]initWithEngine:self.secondEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)defaultPush{
//    FlutterCustomController *flutterViewController = [[FlutterCustomController alloc] init];
//    [self.navigationController pushViewController:flutterViewController animated:YES];
    
//    FlutterEngine *flutterEngine = ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
//    FlutterCustomController *flutterViewController = [[FlutterCustomController alloc]initWithEngine:flutterEngine nibName:nil bundle:nil];
//    [self.navigationController pushViewController:flutterViewController animated:YES];
    
    FlutterCustomController *vc = [[FlutterCustomController alloc]initWithEngine:self.firstEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
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
