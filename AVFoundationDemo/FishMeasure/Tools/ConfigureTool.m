//
//  ConfigureTool.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/12/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "ConfigureTool.h"

static ConfigureTool *instance = nil;

@implementation ConfigureTool

+ (instancetype)shareInstance
{
    if (instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[ConfigureTool alloc] init];
        });
    }
    return instance;
}

- (UIFont *)tipDetectFont
{
    _tipDetectFont = [UIFont systemFontOfSize:18];
    return _tipDetectFont;
}

- (UIFont *)guideFont
{
    _guideFont = [UIFont systemFontOfSize:20];
    return _guideFont;
}

@end
