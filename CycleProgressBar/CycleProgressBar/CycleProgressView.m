//
//  CycleProgressView.m
//  CycleProgressBar
//
//  Created by 星耀 on 2017/10/25.
//  Copyright © 2017年 jiaxiansheng. All rights reserved.
//

#import "CycleProgressView.h"


@interface CycleProgressView ()

@property (nonatomic,strong)CAShapeLayer * shapeLayer;
/** 颜色渐变layer*/
@property (nonatomic,strong)CAGradientLayer * gradient;


@end

@implementation CycleProgressView


- (instancetype)initWithFrame:(CGRect)frame isNeedGradient:(BOOL)isgradient{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化数据
        [self initData];
        //创建底部容器
        CALayer * layer = [CALayer layer];
        [self.layer addSublayer:layer];
        if (isgradient) {
            //添加渐变色
            [layer addSublayer:self.gradient];
            layer.mask = self.shapeLayer;
        }else {
            //添加绘制的圆
            [layer addSublayer:self.shapeLayer];
        }
    }
    return self;
}
#pragma mark - lazy load
- (CAGradientLayer *)gradient {
    if (!_gradient) {
        self.gradient = [CAGradientLayer layer];
        CGRect frame = self.frame;
        frame = CGRectMake(-_lineWidth, -_lineWidth, frame.size.width+_lineWidth*2, frame.size.height+_lineWidth*2);
        
        _gradient.frame = frame;
        //渐变色的分割线
        _gradient.colors = @[(id)[[UIColor greenColor]CGColor],(id)[[UIColor yellowColor]CGColor]];
        _gradient.locations = @[@0.2,@1];
        _gradient.startPoint = CGPointMake(0, 0);
        _gradient.endPoint = CGPointMake(1, 1);
    }
    return _gradient;
}
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        
        UIBezierPath * bezier = [self drawBezierPath:4];
        self.beizerPath = bezier;
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        //绘制的图形路径
        shapeLayer.path = [bezier CGPath];
        //填充色
        shapeLayer.fillColor = nil;
        //绘制线的颜色
        shapeLayer.strokeColor = [self.lineColor CGColor];
        //绘制线的宽度
        shapeLayer.lineWidth = self.lineWidth;
        //绘制线的起始点
        shapeLayer.strokeStart = 0;
        //绘制线的终点
        shapeLayer.strokeEnd = self.strokeEnd;

        self.shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}
#pragma mark - setter
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    
    _shapeLayer.lineWidth = _lineWidth;
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _shapeLayer.strokeColor = [_lineColor CGColor];
}
- (void)setStrokeEnd:(CGFloat)strokeEnd {
    _strokeEnd = strokeEnd;
    _shapeLayer.strokeEnd = _strokeEnd;
}
#pragma mark - inside method
/** 初始化数据 */
- (void)initData {
    self.lineColor = [UIColor redColor];
    self.lineWidth = 5;
    self.strokeEnd = 0;
}
/**
 * @brief 贝塞尔曲线绘制.
 * @para  clockwise  YES 为顺时针
 * @para  0  绘制圆
 * @para  1  绘制内切圆或者椭圆
 * @para  2  绘制矩形
 * @para  3  绘制倒边角
 */
- (UIBezierPath *)drawBezierPath:(NSInteger)pathType{
    UIBezierPath * bezier = nil;
    switch (pathType) {
        case 0:
        {//绘制圆
            CGRect frame = self.frame;
            //圆心
            CGPoint arcCenter = CGPointMake(frame.size.width/2, frame.size.height/2);
            //半径
            CGFloat radius = frame.size.width >frame.size.height? frame.size.height/2 : frame.size.width/2;
            bezier = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:-M_PI/2 endAngle:M_PI*2-M_PI/2 clockwise:YES];

        }
            break;
        case 1:
        {//绘制内切圆或者椭圆
            bezier = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        }
            break;
        case 2:
        {//绘制矩形
            bezier = [UIBezierPath bezierPathWithRect:self.bounds];
        }
            break;
        case 3:
        {//绘制倒边角
            CGSize  size = CGSizeMake(5, 5);
            bezier = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:size];
        }
            break;
        case 4:
        {//绘制各个点图形
            bezier = [UIBezierPath bezierPath];
            bezier.lineJoinStyle=  kCGLineJoinRound;
            bezier.miterLimit = 5;
            [bezier moveToPoint:CGPointMake(0, 0)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
            [bezier addLineToPoint:CGPointMake(0, self.frame.size.height)];
            [bezier closePath];
        }
            break;
        default:
            break;
    }
    
    return bezier;
}

#pragma mark - outside method
- (void)updateCycle {
    _shapeLayer.lineWidth = _lineWidth;
    _shapeLayer.strokeColor = [_lineColor CGColor];
    _shapeLayer.strokeEnd = _strokeEnd;
    
}
@end
