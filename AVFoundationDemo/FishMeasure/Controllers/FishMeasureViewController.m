//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/6/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "FishMeasureViewController.h"

#import "RulerView.h"

@interface FishMeasureViewController ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) RulerView *rulerView;

@end

@implementation FishMeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    self.view.backgroundColor = [UIColor greenColor];
    
    [self createUI];
    
    self.imageView.image = self.coinDetectModel.captureImage;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.imageView.image = self.coinDetectModel.captureImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init ui
- (void)createUI
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    
    self.rulerView = [[RulerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.rulerView];
}

#pragma mark - setter
- (void)setCoinDetectModel:(CoinDetectModel *)coinDetectModel
{
    _coinDetectModel = coinDetectModel;
    self.imageView.image = _coinDetectModel.captureImage;
}

@end
