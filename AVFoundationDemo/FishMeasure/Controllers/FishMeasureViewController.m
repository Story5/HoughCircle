//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/6/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "FishMeasureViewController.h"

@interface FishMeasureViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation FishMeasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__func__);
    self.view.backgroundColor = [UIColor greenColor];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
 
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

#pragma mark - event
- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - setter
- (void)setCoinDetectModel:(CoinDetectModel *)coinDetectModel
{
    _coinDetectModel = coinDetectModel;
    self.imageView.image = _coinDetectModel.captureImage;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

@end
