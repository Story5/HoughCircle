# AVFoundationDemo

## Introduction
* 1.Use AVFoundation to get every frame of the capture video
* 2.Use OpenCV to detect whether there is any circle in the image
* 3.Use CoreGraphics to draw a Ruler and mesuare the height of fish in the same image.

## Necessary framework
Download the necessary [build of `opencv2.framework`](https://github.com/JoeHowse/iOSWithOpenCV/releases/download/1.1.0/opencv2.framework.zip)


## AVFoundation 相关类
AVFoundation 框架基于以下几个类实现图像捕捉 ，通过这些类可以访问来自相机设备的原始数据并控制它的组件。

* AVCaptureDevice 是关于相机硬件的接口。它被用于控制硬件特性，诸如镜头的位置、曝光、闪光灯等。
* AVCaptureDeviceInput 提供来自设备的数据。
* AVCaptureOutput 是一个抽象类，描述 capture session 的结果。以下是三种关于静态图片捕捉的具体子类：
  * AVCaptureStillImageOutput 用于捕捉静态图片
  * AVCaptureMetadataOutput 启用检测人脸和二维码
  * AVCaptureVideoOutput 为实时预览图提供原始帧
* AVCaptureSession 管理输入与输出之间的数据流，以及在出现问题时生成运行时错误。
* AVCaptureVideoPreviewLayer 是 CALayer 的子类，可被用于自动显示相机产生的实时图像。它还有几个工具性质的方法，可将 layer 上的坐标转化到设备上。它看起来像输出，但其实不是。另外，它拥有 session (outputs 被 session 所拥有)。

## 优化显示

用主线程刷新画图
