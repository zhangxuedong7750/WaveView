//
//  ZXDWaveView.m
//  WaveView
//
//  Created by 张雪东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import "ZXDWaveView.h"

@interface ZXDWaveView(){

    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;
    CGFloat waveSpeed;
    CGFloat waveAmplitude;  // 波纹振幅
}

@property (nonatomic, strong) UIColor *waveColor;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) UILabel *progressLabel;
@end

@implementation ZXDWaveView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initData];
        [self initView];
    }
    return self;
}

-(void)initData{

    waveAmplitude = 6;
    offsetX = 0;
    waveSpeed = 4;
}

-(void)initView{

    self.backgroundColor = [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:1];
    
//    waterWaveHeight = self.bounds.size.height / 2;
    waterWaveWidth = self.bounds.size.width;

    _waveColor = [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:1];
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.fillColor = _waveColor.CGColor;
    [self.layer addSublayer:_waveLayer];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor whiteColor].CGColor;

    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:waterWaveWidth / 2 startAngle:0 endAngle:360 clockwise:YES];
    maskLayer.path = circlePath.CGPath;
    
    self.layer.mask = maskLayer;
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    progressLabel.font = [UIFont systemFontOfSize:40];
    progressLabel.textColor = [UIColor blackColor];
    progressLabel.backgroundColor = [UIColor clearColor];
    progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel = progressLabel;
    [self addSubview:progressLabel];
}

-(void)start{
    
    
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getWaveLayerPath)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
   
}

-(void)stop{

    [_waveDisplaylink invalidate];
}

-(void)getWaveLayerPath{

    waterWaveHeight = MAX(0, (1 - self.progress / 100)) * self.bounds.size.height;
    self.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",100 * MIN(1,  self.progress / 100)];
    offsetX += waveSpeed;
    
    [self setCurrentWaveLayerPath];
}

-(void)setCurrentWaveLayerPath{

    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = waterWaveHeight;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude* sin((2 * M_PI / waterWaveWidth) * (x - offsetX)) + waterWaveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _waveLayer.path = path;
    CGPathRelease(path);
}

@end
