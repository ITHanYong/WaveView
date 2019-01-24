//
//  WaveView.h
//  ElectronicCard
//
//  Created by Mac on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView
/*
 波的数量
 */
@property (nonatomic, assign) NSInteger waveNum;
/*
 
 公式  y=Asin(ωx+φ)+k
 A : 振幅      amplitude
 ω : 角速度    angularSpeed
 φ : 初相      initialPhase
 k : 偏距      offsetK
 
 */


/*
 偏距 k
 */
@property (nonatomic, assign) CGFloat offsetK;

/*
 角速度 ω
 */
@property (nonatomic, assign) CGFloat angularSpeed;

/*
 振幅
 */
@property (nonatomic, assign) CGFloat amplitude;


/*
 波浪模型数组
 */
@property (nonatomic, strong) NSArray *waveModels;


/*
 定时显示
 */
@property (nonatomic, strong) CADisplayLink *displayLink;

-(void)showWaveNum:(NSInteger)waveNum OffsetK:(CGFloat)offsetK AngularSpeed:(CGFloat)angularSpeed Amplitude:(CGFloat)amplitude WaveColor:(int)colorHex;

@end



#pragma mark - 波浪模型
@interface WaveModel : NSObject

/*
 x偏移
 */
@property (nonatomic, assign) CGFloat offsetX;

/*
 速度
 */
@property (nonatomic, assign) CGFloat waveSpeed;

/*
 layer
 */
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@end
