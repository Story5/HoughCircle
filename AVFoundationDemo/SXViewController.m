//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/6/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "SXViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SXViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureDevice *device;
//@property (nonatomic,strong) AVCaptureInput *input;
@property (nonatomic,strong) AVCaptureDeviceInput *input;
//@property (nonatomic,strong) AVCaptureOutput *output;
@property (nonatomic,strong) AVCaptureVideoDataOutput *output;

@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set AVCapture
- (void)setAVCapture
{
    NSError *error = nil;
    
    // Create the session
    self.session = [[AVCaptureSession alloc] init];
    
    // Configure the session to produce lower resolution video frames, if your
    // processing algorithm can cope. We'll specify medium quality for the
    // chosen device.
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    
    // Find a suitable AVCaptureDevice
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Create a device input with the device and add it to the session.
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (!self.input) {
        // Handling the error appropriately.
    }
    [self.session addInput:self.input];
    
    // Create a VideoDataOutput and add it to the session
    self.output = [[AVCaptureVideoDataOutput alloc] init];
    [self.session addOutput:self.output];
    
    // Configure your output.
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [self.output setSampleBufferDelegate:self queue:queue];
    
    // Specify the pixel format
    self.output.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    
    // If you wish to cap the frame rate to a known value, such as 15 fps, set
    // minFrameDuration.
    self.output.minFrameDuration = CMTimeMake(1, 15);
    
    // Start the session running to start the flow of data
    [self.session startRunning];
    
    // Assign session to an ivar.
    [self setSession:self.session];
    
}



@end
