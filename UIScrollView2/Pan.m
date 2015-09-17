//
//  Pan.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/13/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "Pan.h"

@interface Pan () <UIGestureRecognizerDelegate>

@end

@implementation Pan
{
    UIImageView *circle_touch;
    UIImageView *circle_target;
    UILabel *label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusNavigationHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    CGSize size = self.view.bounds.size;
    
    circle_target = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    circle_target.image = [UIImage imageNamed:@"circle_target.jpg"];
    circle_target.center = CGPointMake(size.width / 2, (size.height - statusNavigationHeight) / 2);
    
    [self.view addSubview:circle_target];
    
    circle_touch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    circle_touch.image = [UIImage imageNamed:@"circle_touch.png"];
    circle_touch.userInteractionEnabled = YES;
    circle_touch.multipleTouchEnabled =YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self // Giu anh can di chuyen
                                                                          action:@selector(onPan:)];
    [circle_touch addGestureRecognizer:pan];
    
    [self.view addSubview: circle_touch];

}
- (void) onPan: (UIPanGestureRecognizer*) pan {
    
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged ) {
        
        circle_touch.center = [pan locationInView:self.view];
        [self check: circle_touch.center];
    }
}
- (void) check: (CGPoint) circle {
    
    CGFloat distanceDounleCircle = powf(circle.x - circle_target.center.x, 2) + powf(circle.y - circle_target.center.y, 2);
    
    if (distanceDounleCircle < 20) {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        label.text = @"Đúng chỗ ngứa rồi đấy";
        label.backgroundColor =[UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        //return true;
    } else {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        label.text = @"";
        label.backgroundColor =[UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        //return false;
    }
}
@end
