//
//  ZXDWaveView.h
//  WaveView
//
//  Created by 张雪东 on 15/12/11.
//  Copyright © 2015年 ZXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDWaveView : UIView

@property (nonatomic,assign) CGFloat progress;


-(void)start;
-(void)stop;
@end
