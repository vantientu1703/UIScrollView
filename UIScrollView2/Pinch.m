//
//  Pinch.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/13/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "Pinch.h"

@interface Pinch ()

@end

@implementation Pinch
{
    UIImageView *imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGSize size = self.view.bounds.size;
    CGFloat statusNavigationHeught = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 80, 300, size.height - statusNavigationHeught - 20)];
    imageView.image = [UIImage imageNamed:@"girl.jpg"];
    //imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.center = CGPointMake(size.width / 2, (size.height - statusNavigationHeught) / 2);
    
    imageView.multipleTouchEnabled = YES;
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onPinch:)];
    [imageView addGestureRecognizer:pinch];
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(onRotate:)];
    [imageView addGestureRecognizer:rotate];
}
- (void) onRotate: (UIRotationGestureRecognizer *) rotate {
    
    if (rotate.state == UIGestureRecognizerStateBegan || rotate.state == UIGestureRecognizerStateChanged) {
        
        imageView.transform = CGAffineTransformRotate(imageView.transform, rotate.rotation);
        rotate.rotation = 0;
    }
}
- (void) onPinch: (UIPinchGestureRecognizer*) gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        
        [self adjustAnchorPointForGestureRecognzie:gesture];
        imageView.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
}
- (void) adjustAnchorPointForGestureRecognzie: (UIGestureRecognizer*) gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperView = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperView;
    }
}

@end
