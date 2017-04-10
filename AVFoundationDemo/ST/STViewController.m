//
//  STViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "STViewController.h"
#import "STCoinDetectView.h"

@interface STViewController ()

@property (nonatomic,strong) STCoinDetectView *coinDetectView;

@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coinDetectView = [[STCoinDetectView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.coinDetectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
