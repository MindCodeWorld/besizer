//
//  CycleProgressView.h
//  CycleProgressBar
//
//  Created by 星耀 on 2017/10/25.
//  Copyright © 2017年 jiaxiansheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleProgressView : UIView
/**  绘制线的颜色  */
@property (nonatomic,strong)UIColor * _Nullable lineColor;
/**  绘制线的宽度  */
@property (nonatomic,assign)CGFloat lineWidth;
/**  绘制线的终止位置  */
@property (nonatomic,assign)CGFloat strokeEnd;
/**  贝塞尔曲线     */
@property (nonatomic,strong)UIBezierPath * beizerPath;




/**
 * @brief 绘制圆或者椭圆.
 * @para  isgradient 颜色渐变
 * return 圆.
 */
- (instancetype _Nonnull )initWithFrame:(CGRect)frame isNeedGradient:(BOOL)isgradient;



/**
 * @brief 更新绘制的圆.
 *
 */
- (void)updateCycle;
@end
