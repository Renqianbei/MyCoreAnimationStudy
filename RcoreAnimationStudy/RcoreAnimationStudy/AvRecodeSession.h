//
//  AvRecodeSession.h
//  RcoreAnimationStudy
//
//  Created by 任前辈 on 15-5-19.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <AVFoundation/AVFoundation.h>

@interface AvRecodeSession : NSObject



//创建录制session
+(AvRecodeSession *)sessionError:(NSError**)error;

/**
 layer  需要展示到的layer
 frame  录制视频显示的frame
 */
-(void)addlayerInViewlayer:(CALayer *)layer frame:(CGRect)frame;

/**
 从layer中移除视图
 */
-(void)recordlayerRemove;


/**
 开始录制
 filePath  录制视频最终存储的位置
 */
-(void)recordInfilepath:(NSString *)filePath;

/**
 停止录制
 */
-(void)stopRecord;

/**
  切换摄像头
 */
-(void)changeAVCaptureDevicePosition:(AVCaptureDevicePosition)cameraPosition;
@end
