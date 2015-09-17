//
//  RotateBall.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/15/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "RotateBall.h"

@interface RotateBall ()

@end

@implementation RotateBall
{
    UIImageView *ball;
    CGSize size;
    NSTimer *timer;
    CGFloat angle;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    size = self.view.bounds.size;
    angle = 1;
    CGFloat statusNagigationHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    ball.frame = CGRectMake(0, 0, 300, 300);
    ball.center = CGPointMake(size.width / 2, (size.height - statusNagigationHeight) / 2);
    [self.view addSubview:ball];
    
    ball.userInteractionEnabled = YES;
    ball.multipleTouchEnabled = YES;
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(onRotate:)];
    
    [ball addGestureRecognizer:rotate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(loop)
                                           userInfo:nil
                                            repeats:true];
    NSString *str = @"gfgfd";
    [str characterAtIndex:1];
}
- (void) onRotate:(UIRotationGestureRecognizer *) rotate {
    
    if (rotate.state == UIGestureRecognizerStateBegan ||
        rotate.state == UIGestureRecognizerStateChanged) {
        
        ball.transform = CGAffineTransformRotate(ball.transform, rotate.rotation);
        rotate.rotation = angle;
    }
}
- (void) loop {
    
    angle = 1;
    //ball.transform = CGAffineTransformRotate(ball.transform, rotate.rotation);
    //rotate.rotation = angle;
    ball.transform = CGAffineTransformMakeRotation(angle);
}
@end
