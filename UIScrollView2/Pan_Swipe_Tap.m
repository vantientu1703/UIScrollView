//
//  Pan_Swipe_Tap.m
//  UIScrollView2
//
//  Created by Văn Tiến Tú on 9/19/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "Pan_Swipe_Tap.h"
#import <AVFoundation/AVFoundation.h>

@interface Pan_Swipe_Tap ()<UIGestureRecognizerDelegate>

@end

@implementation Pan_Swipe_Tap
{
    UITapGestureRecognizer *tap;
    UIPanGestureRecognizer *pan;
    UISwipeGestureRecognizer *swipe;
    NSTimer *timer;
    
    UILabel *label;
    UIImageView *circle;
    UIImageView *rocket;
    NSDate *whenCircleBecomeBlue;
    CGSize sizeMainView;
    
    AVAudioPlayer *audioPlayer;
    BOOL valueWarning;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.userInteractionEnabled = YES;
    self.view.multipleTouchEnabled = YES;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    label = [UILabel new];
    label.numberOfLines = 3;
    label.text = @"Nếu circle black bắt sự kiện swipe thì nó sẽ chuyển sang một quả cầu màu xanh";
    //[label setFont:[UIFont systemFontOfSize:18]];
    label.textAlignment = NSTextAlignmentCenter;
    
    sizeMainView = self.view.bounds.size;
    CGSize sizeFont = [label .text sizeWithAttributes:@{NSFontAttributeName: label.font}];
    
    label.frame = CGRectMake(8, 80, sizeMainView.width - 16, sizeFont.height * 6);
    
    [self.view addSubview:label];
    
    circle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_black.png"]];
    
    circle.center = CGPointMake(sizeMainView.width / 2, sizeMainView.height / 2);
    
    [self.view addSubview:circle];
    
    circle.multipleTouchEnabled = YES;
    circle.userInteractionEnabled = YES;
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(onPan:)];
    pan.delegate = self;
    [circle addGestureRecognizer:pan];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(onSwipe:)];
    swipe.delegate = self;
    swipe.direction = UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionLeft |
                      UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionUp;
    
    [circle addGestureRecognizer:swipe];
    
    
    rocket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rocket.png"]];
    
    //rocket.image = [UIImage imageNamed:@"rocket.png"];
    rocket.center = CGPointMake(sizeMainView.width, 0);
    rocket.transform = CGAffineTransformMakeRotation(-M_PI);
    CGFloat angleRotateRocketToEarth;
    CGFloat tanAngleRotateRocketToEarth;
    
    tanAngleRotateRocketToEarth = (rocket.center.x - circle.center.x) / (circle.center.y - rocket.center.y);
    angleRotateRocketToEarth = atan(tanAngleRotateRocketToEarth);
    
    rocket.transform = CGAffineTransformMakeRotation(-M_PI + angleRotateRocketToEarth);
    [self.view addSubview:rocket];
    
    rocket.hidden = YES;
    //[pan requireGestureRecognizerToFail:swipe];
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
//                                             target:self
//                                           selector:@selector(loop)
//                                           userInfo:nil
//                                            repeats:true];
}

// Always catching event Pan and Swipe together
// but event Pan before Swipe

//- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return true;
//}

// Envent Pan được nhận dạng và lấn lướt event Swipe
//- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    return false;
//}


// Lượt chậm thì bắt event Pan lướt nhanh bắt event Swipe
// Sự kiện swipe bắt rất khó
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
        
        
        return true;
    } else {
        return false;
    }
}

//- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    if ( [gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]] &&
//         [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
//        
//        return false;
//    } else {
//        return true;
//    }
//}

//- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
//    if ( [gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]] &&
//         [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
//        
//        return true;
//    } else {
//        return false;
//    }
//}
- (void) loop {
    
    if (whenCircleBecomeBlue != nil) {
        
        NSTimeInterval timeInterval = [whenCircleBecomeBlue timeIntervalSinceNow];
        if (-timeInterval > 0.2) {
            
            whenCircleBecomeBlue = nil;
            circle.image = [UIImage imageNamed:@"circle_black.png"];
        }
    }
}
- (void) onPan: (UIPanGestureRecognizer *) panCircle {
    
    if (panCircle.state == UIGestureRecognizerStateBegan || panCircle.state == UIGestureRecognizerStateChanged) {
        
        circle.center = [pan locationInView:self.view];
    }
}
- (void) onSwipe: (UISwipeGestureRecognizer *) swipeCircle {
    
    if (swipeCircle.state == UIGestureRecognizerStateRecognized) {
        
        whenCircleBecomeBlue = [NSDate date];
        circle.image = [UIImage imageNamed:@"earth.png"];
        
        [self playSong:@"rocketFire"];
        [self performSelector:@selector(timeDelayRocket) withObject:nil afterDelay:2.7];
        
        NSLog(@"value: %d",valueWarning);
    }
}
- (void) timeDelayRocket {
    
    rocket.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         rocket.center = CGPointMake(circle.center.x + 50,
                                                     circle.center.y - 50);
                         circle.image = [UIImage imageNamed:@"earth.png"];
                         rocket.alpha = 0.4;
                     } completion:^(BOOL finished) {
                         
                         rocket.alpha = 0;
                         circle.animationImages = @[[UIImage imageNamed:@"boom_5.png"],
                                                    [UIImage imageNamed:@"boom_4.png"]];
                         
                         circle.animationDuration = 0.5;
                         circle.animationRepeatCount = 0;
                         [circle startAnimating];
                         
                         [self changeBackgroung];
                         //[self changeColorTextInLabel];
                         //timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                           //                                       target:self
                             //                                   selector:@selector(changeColorTextInLabel)
                               //                                 userInfo:nil
                                 //                                repeats:true];
                         [self changeColorTextInLabel];
                     }];
}
- (void) changeColorTextInLabel {
    label.text = @"WARNING : TRÁI ĐẤT ĐÃ BỊ PHÁ HUỶ";
    
    CGSize sizeFont = [label.text sizeWithAttributes: @{NSFontAttributeName: label.font}];
    
    [label setFont:[UIFont systemFontOfSize:sizeFont.height + 9]];
    NSLog(@"sizeHeight: %f",sizeFont.height);
    
    if (sizeFont.height > 28) {
        
        [label setFont:[UIFont systemFontOfSize:20]];
    }
}
- (void) changeBackgroung {
    self.view.backgroundColor = [UIColor redColor];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         self.view.backgroundColor = [UIColor yellowColor];
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                              
                                              self.view.backgroundColor = [UIColor darkGrayColor];
                                          } completion:^(BOOL finished) {
                                              [self changeBackgroung];
                                          }];
                     }];
}
-  (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [audioPlayer stop];
    [timer invalidate];
}
- (void) playSong: (NSString *) nameFile {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:nameFile
                                                         ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
}
@end
