//
//  ThrowBall.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/15/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "ThrowBall.h"

@interface ThrowBall ()

@end

@implementation ThrowBall
{
    UIImageView *ball;
    NSTimer *timer;
    CGVector vellocity;
    CGFloat ballRadius;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //ballRadius = 32;
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"football1.png"]];
    ballRadius = ball.bounds.size.width / 2;
    CGFloat statusNavigation = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    ball.center = CGPointMake( self.view.bounds.size.width / 2, (self.view.bounds.size.height - statusNavigation) / 2);
    ball.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(throwBall:)];
    [ball addGestureRecognizer: pan];
    
    
    vellocity = CGVectorMake(0, 0);
    [self.view addSubview:ball];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(loop)
                                           userInfo:nil
                                            repeats:true];
}

- (void) throwBall: (UIPanGestureRecognizer *) pan {
    
    if (pan.state == UIGestureRecognizerStateBegan ||
        pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint acceleration = [pan velocityInView:self.view];
        CGSize size = self.view.bounds.size;
        
        vellocity = CGVectorMake(vellocity.dx + acceleration.x * 5 / size.width * 2,
                                 vellocity.dy + acceleration.y * 5 / size.height * 2);
        
        [pan setTranslation:CGPointZero inView:self.view];
    }
}
- (void) loop {
    
    CGPoint newBall = CGPointMake(ball.center.x + vellocity.dx, ball.center.y + vellocity.dy);
    CGSize size = self.view.bounds.size;
    
    if (newBall.x < ballRadius) {
        
        newBall.x = ballRadius;
        vellocity.dx = -vellocity.dx;
    }
    
    if (newBall.x > size.width - ballRadius) {
        
        newBall.x = size.width - ballRadius;
        vellocity.dx = - vellocity.dx;
    }
    
    if (newBall.y < ballRadius) {
        
        newBall.y = ballRadius;
        vellocity.dy = -vellocity.dy;
    }
    
    if (newBall.y > size.height - ballRadius) {
        
        newBall.y = size.height - ballRadius;
        vellocity.dy = - vellocity.dy;
        
    }
    ball.center = newBall;
    vellocity = CGVectorMake(vellocity.dx * 0.9, vellocity.dy * 0.9);
}
@end
