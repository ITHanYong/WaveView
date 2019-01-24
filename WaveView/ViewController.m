//
//  ViewController.m
//  WaveView
//
//  Created by Mac on 2019/1/24.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()
@property (nonatomic, strong) WaveView *waveView;//波浪
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //波浪 - 底部
    _waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 98, self.view.frame.size.width, 98)];
    [_waveView showWaveNum:3 OffsetK:10 AngularSpeed:1.5*M_PI/self.view.frame.size.width Amplitude:20 WaveColor:0x6273FF];
    [self.view addSubview:_waveView];
}


@end
