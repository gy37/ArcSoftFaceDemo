//
//  ViewController.m
//

#import "ViewController.h"
#import "ImageCheckController.h"
#import "VideoCheckController.h"
#import <ArcSoftFaceEngine/ArcSoftFaceEngine.h>
#import "PersonsViewController.h"

@interface ViewController()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *buttonE = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonE setFrame:CGRectMake(50, 100, 200, 100)];
    [buttonE setBackgroundColor:[UIColor grayColor]];
    [buttonE setTitle:@"引擎激活" forState:UIControlStateNormal];
    [buttonE addTarget:self action:@selector(engineActive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonE];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(50, 220, 200, 100)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Image模式检测" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(imageCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(50, 340, 200, 100)];
    [button2 setBackgroundColor:[UIColor grayColor]];
    [button2 setTitle:@"Video模式检测" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(videoCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(50, 460, 200, 100)];
    [button3 setBackgroundColor:[UIColor grayColor]];
    [button3 setTitle:@"人脸列表" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(toPersons:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)engineActive:(UIButton*)sender {
    NSString *appid = @"";
    NSString *sdkkey = @"";
    ArcSoftFaceEngine *engine = [[ArcSoftFaceEngine alloc] init];
    MRESULT mr = [engine activeWithAppId:appid SDKKey:sdkkey];
    if (mr == ASF_MOK) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"SDK激活成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
    } else if(mr == MERR_ASF_ALREADY_ACTIVATED){
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"SDK已激活" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
    } else {
        NSString *result = [NSString stringWithFormat:@"SDK激活失败：%ld", mr];
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:result message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
    }
}

-(void)imageCheck:(UIButton*)sender {
    ImageCheckController *imageC = [[ImageCheckController alloc] init];
    [self presentViewController:imageC animated:true completion:nil];
}

-(void)videoCheck:(UIButton*)sender {
    VideoCheckController *videoC = [[VideoCheckController alloc] init];
    [self presentViewController:videoC animated:true completion:nil];
}

- (void)toPersons:(UIButton *)sender {
    PersonsViewController *persons = [[PersonsViewController alloc] init];
    [self presentViewController:persons animated:true completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
