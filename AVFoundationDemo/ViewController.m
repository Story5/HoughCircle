//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/6/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureDevice *device;
@property (nonatomic,strong) AVCaptureInput *input;
@property (nonatomic,strong) AVCaptureOutput *output;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 



@end
