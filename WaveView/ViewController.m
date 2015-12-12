//
//  ViewController.m
//  WaveView
//
//  Created by 张雪东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ViewController.h"
#import "ZXDWaveView.h"

@interface ViewController (){

    CGFloat progress;
}

@property (nonatomic,strong) ZXDWaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    ZXDWaveView *waveView = [[ZXDWaveView alloc] initWithFrame:CGRectMake(screenSize.width / 2 - 100, 100, 200, 200)];
    self.waveView = waveView;
    [waveView start];
    [self.view addSubview:waveView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(add) userInfo:nil repeats:YES];
}


-(void)add{

    progress += 1;
    self.waveView.progress = progress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
