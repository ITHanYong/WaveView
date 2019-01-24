//
//  WaveView.m
//  ElectronicCard
//
//  Created by Mac on 2018/6/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import "WaveView.h"

@interface WaveView ()

@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
       
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 0;
    }
    return self;
}


/**
 绘制波浪

 @param waveNum 波浪个数
 @param offsetK 偏距 k
 @param angularSpeed 角速度 ω
 @param amplitude 振幅
 @param colorHex 波浪颜色
 */
-(void)showWaveNum:(NSInteger)waveNum OffsetK:(CGFloat)offsetK AngularSpeed:(CGFloat)angularSpeed Amplitude:(CGFloat)amplitude WaveColor:(int)colorHex{
    _waveNum = waveNum;
    _offsetK = offsetK;
    _angularSpeed = angularSpeed;
    _amplitude = amplitude;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWaveAnimation)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    UIColor *color = UIColorFromRGBA(colorHex, 1.0);
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (int i = 0; i < _waveNum; i ++) {
        
        WaveModel *waveModel = [[WaveModel alloc] init];
        waveModel.waveSpeed = (i+1)/80.0;
        waveModel.waveLayer = [self customWaveLayerWithColor:color opacity:i /5.0 + 0.5];
        [mArray addObject:waveModel];
    }
    self.waveModels = [mArray copy];
}

- (CAShapeLayer *)customWaveLayerWithColor:(UIColor *)color opacity:(CGFloat)opacity{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.fillColor = [color CGColor];
    shapeLayer.lineCap = kCALineCapSquare;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.opacity = opacity;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}


- (void)drawWaveAnimation {
    
    for (WaveModel *waveModel  in self.waveModels) {
        
        waveModel.offsetX -= waveModel.waveSpeed;
        [self drawWaveLineWithShapeLaye:waveModel.waveLayer initialPhase:50  offsetX:waveModel.offsetX ];
    }
}

- (void)drawWaveLineWithShapeLaye:(CAShapeLayer *)layer  initialPhase:(CGFloat)initialPhase offsetX:(CGFloat)offsetX {
    
    //路径
    UIBezierPath * linePath = [[UIBezierPath alloc] init];
    
    for (int x = 0; x <= self.frame.size.width; x ++) {
        /*
         公式  y=Asin(ωx+φ)+k
         */
        //CGFloat yValue = self.frame.size.height - _amplitude * sin(_angularSpeed * x + initialPhase + offsetX) - _offsetK - _amplitude;
        CGFloat yValue =  _amplitude * sin(_angularSpeed * x + initialPhase + offsetX) + _amplitude;
        CGPoint point = CGPointMake(x, yValue);
        if (x == 0) {
            
            [linePath moveToPoint:point];
            
        }else {
            
            [linePath addLineToPoint:point];
        }
    }
    
    [linePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [linePath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [linePath closePath];
    
    //创建layer
    layer.path = linePath.CGPath;
    
    //直接添加导视图上
    
//    //绘制动画
//    CABasicAnimation *waveAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    waveAnimation.repeatCount = HUGE_VALF;
//    waveAnimation.fromValue = @(0);
//    waveAnimation.toValue = @(1);
//    waveAnimation.duration = drawAnimaTime;
//    waveAnimation.fillMode = kCAFillModeForwards;
//    [lineLayer addAnimation:waveAnimation forKey:@"waveAnimation"];
}

-(void)setWaveNum:(NSInteger)waveNum{
    _waveNum = waveNum;
}

-(void)setAmplitude:(CGFloat)amplitude{
    _amplitude = amplitude;
}

-(void)setAngularSpeed:(CGFloat)angularSpeed{
    _angularSpeed = angularSpeed;
}

-(void)setOffsetK:(CGFloat)offsetK{
    _offsetK = offsetK;
}

-(void)dealloc{
    
}

@end



#pragma mark - 波浪模型
@implementation WaveModel



@end

