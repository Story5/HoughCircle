//
//  CoinDetectViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CoinDetectViewController.h"
#import "CoinDetectView.h"
#import "FishMeasureViewController.h"
#import "DetectCircleTool.h"

#import "ParamSlider.h"

@interface CoinDetectViewController ()<CoinDetectViewDelegate,ParamSliderDataSource,ParamSliderDelegate>

@property (nonatomic,strong) CoinDetectView *coinDetectView;
@property (nonatomic,strong) ParamSlider *slider;

@end

@implementation CoinDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__func__);    
    [self createUI];
//    [self test];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.coinDetectView startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.coinDetectView stopRunning];
}

#pragma mark - CoinDetectViewDelegate
- (void)coinDetectView:(CoinDetectView *)coinDetectView captureFishWithModel:(CoinDetectModel *)model
{
    FishMeasureViewController *fishVC = [[FishMeasureViewController alloc] init];
    fishVC.coinDetectModel = model;
    [self presentViewController:fishVC animated:true completion:nil];
}

#pragma mark - ParamSlider
- (NSInteger)countOfSlidersInParamSlider:(ParamSlider *)paramSlider
{
    return 7;
}

- (NSArray<NSNumber *> *)minimumValuesForParamSlider:(ParamSlider *)paramSlider
{
    return @[@1, // size;
             @0, // dp;
             @0, // minDist;
             @1, // param1;
             @0, // param2;
             @0, // minRadius;
             @0];// maxRadius;
}

- (NSArray<NSNumber *> *)maximumValuesForParamSlider:(ParamSlider *)paramSlider
{
    return @[@10,
             @2,
             @10,
             @1000,
             @1000,
             @100,
             @200];
}

- (NSArray<NSNumber *> *)enterValueForParamSlider:(ParamSlider *)paramSlider
{
    return @[@9,
             @1,
             @8,
             @200,
             @100,
             @0,
             @100];
}

- (void)value:(float)value indexOfSlider:(NSInteger)index
{
    NSAssert(value >= 0, @"index = %ld",index);
    
    switch (index) {
        case 0:
            self.coinDetectView.dp = value;
            break;
        case 1:
            self.coinDetectView.minDist = value;
            break;
        case 2:
            self.coinDetectView.param1 = value;
            break;
        case 3:
            self.coinDetectView.param2 = value;
            break;
        case 4:
            self.coinDetectView.minRadius = value;
            break;
        case 5:
            self.coinDetectView.maxRadius = value;
            break;
        default:
            break;
    }
}

#pragma mark - create UI
- (void)createUI
{
    [self createDetectView];
    [self createSlider];
}

- (void)createDetectView
{
    self.coinDetectView = [[CoinDetectView alloc] initWithFrame:self.view.bounds];
    self.coinDetectView.delegate = self;
    [self.view addSubview:self.coinDetectView];
}

- (void)createSlider
{
    self.slider = [[ParamSlider alloc] initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width - 20, self.view.bounds.size.height - 130)];
    self.slider.dataSource = self;
    self.slider.delegate = self;
    [self.view addSubview:self.slider];
    [self.slider showSlider];
}

#pragma mark - test
- (void)test
{
    UIImage *coinImage = [UIImage imageNamed:@"coin"];
    DetectCircleTool *tool = [[DetectCircleTool alloc] init];
    BOOL detected = [tool detectCircleInImage:coinImage];
    NSLog(@"detected = %d",detected);
}

@end
