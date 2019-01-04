//
//  ViewController.m
//  video_suspend
//
//  Created by MAC on 2019/1/4.
//  Copyright © 2019 MAC. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"
#import "touchView.h"

@interface ViewController ()
{
    touchView *touch ;
    UIView *testView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    testView = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [testView addGestureRecognizer:pan];
    
    touch = [[touchView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    touch.backgroundColor = [UIColor greenColor];
    [self.view addSubview:touch];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (CGRectIntersectsRect(self.view.bounds, touch.frame)) {
        NSLog(@"true");
    }else{
        NSLog(@"false");
    }
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"FlyElephant---视图拖动开始");
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [recognizer locationInView:self.view];
        
        if (location.y < 0 || location.y > self.view.bounds.size.height) {
            return;
        }
        CGPoint translation = [recognizer translationInView:self.view];
        
        NSLog(@"当前视图在View的位置:%@----平移位置:%@",NSStringFromCGPoint(location),NSStringFromCGPoint(translation));
        
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointZero inView:self.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"FlyElephant---视图拖动结束");
        
        
        CGPoint stopPoint = CGPointMake(0, SCREEN_HEIGHT / 2.0);
        if (recognizer.view.center.x < SCREEN_WIDTH / 2.0) {
            if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                //左上
                if (recognizer.view.center.x  >= recognizer.view.center.y) {
                    stopPoint = CGPointMake(recognizer.view.center.x, testView.frame.size.width/2.0);
                }else{
                    stopPoint = CGPointMake(testView.frame.size.width/2.0, recognizer.view.center.y);
                }
            }else{
                //左下
                if (recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                    stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - testView.frame.size.width/2.0);
                }else{
                    stopPoint = CGPointMake(testView.frame.size.width/2.0, recognizer.view.center.y);
                    //                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.spButton.width/2.0);
                }
            }
        }else{
            if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                //右上
                if (SCREEN_WIDTH - recognizer.view.center.x  >= recognizer.view.center.y) {
                    stopPoint = CGPointMake(recognizer.view.center.x, testView.frame.size.width/2.0);
                }else{
                    stopPoint = CGPointMake(SCREEN_WIDTH - testView.frame.size.width/2.0, recognizer.view.center.y);
                }
            }else{
                //右下
                if (SCREEN_WIDTH - recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                    stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - testView.frame.size.width/2.0);
                }else{
                    stopPoint = CGPointMake(SCREEN_WIDTH - testView.frame.size.width/2.0,recognizer.view.center.y);
                }
            }
        }
        
        
        //如果按钮超出屏幕边缘
        if (stopPoint.y + testView.frame.size.width+40>= SCREEN_HEIGHT) {
            stopPoint = CGPointMake(stopPoint.x, SCREEN_HEIGHT - testView.frame.size.width/2.0-49);
            NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
        }
        if (stopPoint.x - testView.frame.size.width/2.0 <= 0) {
            stopPoint = CGPointMake(testView.frame.size.width/2.0, stopPoint.y);
        }
        if (stopPoint.x + testView.frame.size.width/2.0 >= SCREEN_WIDTH) {
            stopPoint = CGPointMake(SCREEN_WIDTH - testView.frame.size.width/2.0, stopPoint.y);
        }
        if (stopPoint.y - testView.frame.size.width/2.0 <= 0) {
            stopPoint = CGPointMake(stopPoint.x, testView.frame.size.width/2.0);
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            recognizer.view.center = stopPoint;
        }];
    }
    
    
    
}
@end
