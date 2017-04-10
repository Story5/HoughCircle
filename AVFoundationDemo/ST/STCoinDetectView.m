
//  STCoinDetectView.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "STCoinDetectView.h"
#import "UIImage+Rotate_Flip.h"
#import <AVFoundation/AVFoundation.h>
#import "AVCamPreviewView.h"
#import "DetectCircleTool.h"
#import "STView.h"


@interface STCoinDetectView ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureDevice *device;
//@property (nonatomic,strong) AVCaptureInput *input;
@property (nonatomic,strong) AVCaptureDeviceInput *input;

// 可以逐帧处理捕获的视频
@property (nonatomic,strong) AVCaptureVideoDataOutput *output;
@property (nonatomic,strong) AVCamPreviewView *previewView;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) STView *stView;

@property (nonatomic,strong) DetectCircleTool *detectCircleTool;

@end

@implementation STCoinDetectView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAVCapture];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setAVCapture];
    
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
// output
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    // Create a UIImage from the sample buffer data
    //    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    //    CIImage *image = [[CIImage alloc] initWithCVImageBuffer:pixelBuffer];
    UIImage *sourceImage = [self imageFromSampleBuffer:sampleBuffer];
    UIImage *image = [sourceImage rotateImageWithRadian:M_PI_2 cropMode:enSvCropExpand];
    
    BOOL detected = [self.detectCircleTool detectCircleInImage:image];
    
    //    if (detected) {
    NSLog(@"center = %@",NSStringFromCGPoint(self.detectCircleTool.center));
    NSLog(@"radius = %d",self.detectCircleTool.radius);
    NSLog(@"image  = %@",self.detectCircleTool.covertImage);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isnan(self.detectCircleTool.center.x) || isnan(self.detectCircleTool.center.y)) {
            self.stView.centerPoint = CGPointMake(0, 0);
            self.stView.radius = 0;
        } else {
            if (detected) {
                self.stView.centerPoint = self.detectCircleTool.center;
                self.stView.radius = self.detectCircleTool.radius;
            } else {
                self.stView.centerPoint = CGPointMake(0, 0);
                self.stView.radius = 0;
            }
        }
        [self.stView updateframe:CGRectMake(self.detectCircleTool.center.x - self.detectCircleTool.radius, self.detectCircleTool.center.y - self.detectCircleTool.radius, self.detectCircleTool.radius*2, self.detectCircleTool.radius*2)];
    });
}

// drop
- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    //    [self stopRunning];
}

#pragma mark - set AVCapture
- (void)setAVCapture
{
    //  **********   步骤 - 1   **********
    [self createSession];
    //  **********   步骤 - 2   **********
    [self configDevice];
    //  **********   步骤 - 3   **********
    [self configInput];
    //  **********   步骤 - 4   **********
    [self configOutput];
    //  **********   步骤 - 5   **********
    [self configPreview];
    //    [self configSTView];
    /*  **********   步骤 - 6   **********
     *
     */
    [self startRunning];
    
    // Assign session to an ivar.
    [self setSession:self.session];
}

// Create the session
- (void)createSession
{
    self.session = [[AVCaptureSession alloc] init];
    // Configure the session to produce lower resolution video frames, if your
    // processing algorithm can cope. We'll specify medium quality for the
    // chosen device.
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
}

// Find a suitable AVCaptureDevice
- (void)configDevice
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    [self.device lockForConfiguration:&error];
    // If you wish to cap the frame rate to a known value, such as 15 fps, set
    // minFrameDuration.
    self.device.activeVideoMinFrameDuration = CMTimeMake(1, 15);
}

// Create a device input with the device and add it to the session
- (void)configInput
{
    NSError *error = nil;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (!self.input) {
        // Handling the error appropriately.
    }
    [self.session addInput:self.input];
}

// Create a VideoDataOutput and add it to the session
- (void)configOutput
{
    self.output = [[AVCaptureVideoDataOutput alloc] init];
    [self.session addOutput:self.output];
    
    // Configure your output.
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [self.output setSampleBufferDelegate:self queue:queue];
    
    // Specify the pixel format
    self.output.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                            forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    // If you wish to cap the frame rate to a known value, such as 15 fps, set
    // minFrameDuration.
    //    self.output.minFrameDuration = CMTimeMake(1, 15);
}

- (void)configPreview
{
    // Set up the preview view.
    self.previewView.session = self.session;
}

// Start the session running to start the flow of data
- (void)startRunning
{
    [self.session startRunning];
}

- (void)stopRunning
{
    [self.session stopRunning];
}

// Create a UIImage from sample buffer data
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
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

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"%s",__func__);
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:@"save image failure" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    [alert addAction:cancel];
    //    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - getter
- (AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (AVCamPreviewView *)previewView
{
    if (_previewView == nil) {
        _previewView = [[AVCamPreviewView alloc] initWithFrame:self.bounds];
        [self addSubview:_previewView];
    }
    return _previewView;
}

- (DetectCircleTool *)detectCircleTool
{
    if (_detectCircleTool == nil) {
        _detectCircleTool = [[DetectCircleTool alloc] init];
    }
    return _detectCircleTool;
}
- (STView *)stView
{
    if (!_stView) {
        _stView = [[STView alloc]init];
        _stView.backgroundColor = [UIColor clearColor];
        [self.previewView addSubview:_stView];
    }
    return _stView;
}

@end
