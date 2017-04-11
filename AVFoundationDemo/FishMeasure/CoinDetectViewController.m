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

@interface CoinDetectViewController ()<CoinDetectViewDelegate>

@property (nonatomic,strong) CoinDetectView *coinDetectView;

@end

@implementation CoinDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__func__);    
    self.coinDetectView = [[CoinDetectView alloc] initWithFrame:self.view.bounds];
    self.coinDetectView.delegate = self;
    [self.view addSubview:self.coinDetectView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CoinDetectViewDelegate
- (void)coinDetectView:(CoinDetectView *)coinDetectView getFishImage:(UIImage *)image
{
    FishMeasureViewController *fishVC = [[FishMeasureViewController alloc] init];
    fishVC.fishImage = image;
    [self presentViewController:fishVC animated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
