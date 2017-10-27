//
//  ViewController.m
//  CycleProgressBar
//
//  Created by 星耀 on 2017/10/25.
//  Copyright © 2017年 jiaxiansheng. All rights reserved.
//

#import "ViewController.h"
#import "CycleProgressView.h"
@interface ViewController ()
@property (nonatomic,strong)CycleProgressView * cycleView;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}
- (void)initUI {
    CGFloat KWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat KHeight = [[UIScreen mainScreen] bounds].size.height;
    CycleProgressView * view = [[CycleProgressView alloc] initWithFrame:CGRectMake(KWidth/2-50, KHeight/2-50, 200, 100) isNeedGradient:NO];
    self.cycleView = view;
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [view addSubview:self.helloLabel];
}
- (IBAction)oneAction:(UIButton *)sender {
    self.cycleView.strokeEnd = 0.5;
    [self.cycleView updateCycle];
}

- (IBAction)twoAction:(UIButton *)sender {

    [self.cycleView updateCycle];
}

- (IBAction)sliderAction:(UISlider *)sender {
    self.cycleView.strokeEnd = sender.value;
//    [self.cycleView updateCycle];
}

- (IBAction)threeAction:(UIButton *)sender {
    CAKeyframeAnimation * animate = [CAKeyframeAnimation animation];
    animate.keyPath = @"position";
    
    animate.path = [[self.cycleView.beizerPath bezierPathByReversingPath] CGPath];
    animate.duration = 3;
    animate.repeatCount = MAXFLOAT;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.helloLabel.layer addAnimation:animate forKey:nil];
    
}
-(void)startAninationWithPro:(CGFloat)pro
{
    //增加动画
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:pro];
    pathAnimation.autoreverses=NO;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
//    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
@end
