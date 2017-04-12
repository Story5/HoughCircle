//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/6/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "FishMeasureViewController.h"

#import "CaptureImageView.h"
#import "RulerView.h"

@interface FishMeasureViewController ()

@property (nonatomic,strong) CaptureImageView *imageView;
@property (nonatomic,strong) RulerView *rulerView;
@property (nonatomic,strong) UIButton *closeButton;

@end

@implementation FishMeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    self.view.backgroundColor = [UIColor greenColor];
    
    self.imageView.coinDetectModel = self.coinDetectModel;
    [self.imageView setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.imageView.coinDetectModel = self.coinDetectModel;
    [self.imageView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event
- (void)clickedCloseButton:(UIButton *)aSender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - setter
- (void)setCoinDetectModel:(CoinDetectModel *)coinDetectModel
{
    _coinDetectModel = coinDetectModel;
    self.rulerView.coinPixelRadius = _coinDetectModel.circleRadius;
    NSLog(@"center = %@",NSStringFromCGPoint(_coinDetectModel.circleCenter));
    NSLog(@"radius = %d",_coinDetectModel.circleRadius);
    
    self.imageView.coinDetectModel = _coinDetectModel;
    [self.imageView setNeedsDisplay];
}

- (CaptureImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[CaptureImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_imageView];
        [self.view sendSubviewToBack:_imageView];
    }
    return _imageView;
}

- (RulerView *)rulerView
{
    if (_rulerView == nil) {
        _rulerView = [[RulerView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_rulerView];
        [self.view bringSubviewToFront:_rulerView];
        [self.view bringSubviewToFront:self.closeButton];
    }
    return _rulerView;
}

- (UIButton *)closeButton
{
    if (_closeButton == nil) {
        NSUInteger width = 20;
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(20, 40, width, width);
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeButton];
    }
    return _closeButton;
}

@end
