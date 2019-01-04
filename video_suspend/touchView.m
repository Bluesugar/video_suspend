//
//  touchView.m
//  newTabbar
//
//  Created by MAC on 2018/12/21.
//  Copyright © 2018 MAC. All rights reserved.
//
#define kk_WIDTH self.frame.size.width
#define kk_HEIGHT self.frame.size.height

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#import "touchView.h"

@implementation touchView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"FlyElephant---触摸开始");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
    // 获取上一个点
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    
    CGPoint panPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
//    [self changBoundsabovePanPoint:panPoint];
    NSLog(@"FlyElephant----当前位置:%@---之前的位置:%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(prePoint));
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"FlyElephant---触摸结束");
    
    CGRect frame = self.frame;
    
    //记录是否越界
    
    BOOL isOver = NO;

     if (frame.origin.x < 0) {
                
        frame.origin.x = 0;
                
            isOver = YES;
                
    } else if (frame.origin.x+frame.size.width > kScreenWidth) {
                
            frame.origin.x = kScreenWidth - frame.size.width;
                
            isOver = YES;
                }
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        isOver = YES;
    } else if (frame.origin.y+frame.size.height > kScreenHeight){
        frame.origin.y = kScreenHeight - frame.size.height;
        isOver = YES;
    
}
    if (isOver) {
        [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
            }
    
    
    
}
-(void)changetouchlocationPoint:(CGPoint)point{

}

- (void)changBoundsabovePanPoint:(CGPoint)panPoint{
    
    
}
@end
