//
//  RHViewController.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/7/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "RHViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "RHCoinDetectView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface RHViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCapturePhotoCaptureDelegate>

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;
//输出图片
@property (nonatomic ,strong) AVCaptureVideoDataOutput *videoOutput;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

// btn
@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIButton *stopBtn;
@property (nonatomic,strong) UIButton *catchBtn;
@property (nonatomic,strong) UIImageView *catchImgView;
@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,strong) RHCoinDetectView *coinDetectView;

@end

@implementation RHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self cameraDistrict];
    [self creatUI];
    [self configureBasic];
}


- (void)creatUI{
    [self.view addSubview:self.coinDetectView];
}

- (void)cameraDistrict
{
    //    AVCaptureDevicePositionBack  后置摄像头
    //    AVCaptureDevicePositionFront 前置摄像头
    self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.videoOutput]) {
        [self.session addOutput:self.videoOutput];
    }
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [self.videoOutput setSampleBufferDelegate:self queue:queue];
    // 指定像素格式
    _videoOutput.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
     [self setSession:_session];
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0,64 , SCREEN_WIDTH, SCREEN_HEIGHT * 0.5);
    self.previewLayer.borderWidth = 2;
    self.previewLayer.borderColor = [UIColor redColor].CGColor;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
   
       
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

- (void)configureBasic{
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.stopBtn];
    [self.view addSubview:self.catchBtn];
    [self.view addSubview:self.catchImgView];
}


#pragma mark - event
//设备取景开始
- (void)startCatch{
    [self.coinDetectView startRunning];
//    [self.session startRunning];
}
//设备停止取景
- (void)stopCatch{
    [self.coinDetectView stopRunning];
//    [self.session stopRunning];
}

//捕获当前帧
- (void)catchCurrentImage{
//    self.catchImgView.image = (UIImage *)[self.arr lastObject];
   self.catchImgView.image = [self.coinDetectView takePhoto];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - delegate
//实现代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    // Create a UIImage from the sample buffer data
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    [self.arr addObject:image];
  
    
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace)
    {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
    
    // Get the base address of the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    // Get the data size for contiguous planes of the pixel buffer.
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    
    // Create a Quartz direct-access data provider that uses data we supply
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize,
                                                              NULL);
    // Create a bitmap image from data supplied by our data provider
    CGImageRef cgImage =
    CGImageCreate(width,
                  height,
                  8,
                  32,
                  bytesPerRow,
                  colorSpace,
                  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
                  provider,
                  NULL,
                  true,
                  kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    // Create and return an image object representing the specified Quartz image
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return image;
}
#pragma mark - getter
- (UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *0.5 + 10, SCREEN_HEIGHT * 0.5 + 74, 50, 30)];
        [_startBtn setBackgroundColor:[UIColor cyanColor]];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startCatch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

- (UIButton *)stopBtn{
    if (!_stopBtn) {
        _stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *0.5 + 80, SCREEN_HEIGHT * 0.5 + 74, 50, 30)];
        [_stopBtn setBackgroundColor:[UIColor cyanColor]];
        [_stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_stopBtn addTarget:self action:@selector(stopCatch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}
- (UIButton *)catchBtn{
    if (!_catchBtn) {
        _catchBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *0.5 + 10, SCREEN_HEIGHT * 0.5 + 174, 50, 30)];
        [_catchBtn setBackgroundColor:[UIColor cyanColor]];
        [_catchBtn setTitle:@"捕获" forState:UIControlStateNormal];
        [_catchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_catchBtn addTarget:self action:@selector(catchCurrentImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _catchBtn;
}

- (UIImageView *)catchImgView{
    if (!_catchImgView) {
        _catchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT * 0.5 + 74, 150, 150)];
        _catchImgView.backgroundColor = [UIColor yellowColor];
    }
    return _catchImgView;
}

- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (RHCoinDetectView *)coinDetectView{
    if (!_coinDetectView) {
        _coinDetectView = [[RHCoinDetectView alloc] initWithFrame:CGRectMake(0,64 , SCREEN_WIDTH, SCREEN_HEIGHT * 0.5)];
    }
    return _coinDetectView;
}

@end
