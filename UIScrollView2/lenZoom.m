//
//  lenZoom.m
//  UIScrollView2
//
//  Created by Văn Tiến Tú on 9/22/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "lenZoom.h"

@interface lenZoom () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) CGFloat circleRadius;
@property (nonatomic) CGPoint circleCenter;

@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic, weak) CAShapeLayer *circleLayer;

@property (nonatomic, weak) UIPinchGestureRecognizer *pinch;
@property (nonatomic, weak) UIPanGestureRecognizer   *pan;

@end

@implementation lenZoom

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 100, 100, 50)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"Click" forState:normal];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(didTouchUpInsideSaveButton) forControlEvents:UIControlEventTouchUpInside];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.imageView.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.imageView.layer addSublayer:circleLayer];
    self.circleLayer = circleLayer;
    
    [self updateCirclePathAtLocation:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2) radius:self.view.bounds.size.width * 3];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [self.imageView addGestureRecognizer:pan];
    self.imageView.userInteractionEnabled = YES;
    self.pan = pan;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handPinch:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    
    self.pinch = pinch;
    
    
}
- (void) updateCirclePathAtLocation: (CGPoint) location radius: (CGFloat) radius {
    
    self.circleCenter = location;
    self.circleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:self.circleCenter radius:self.circleRadius startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    
    self.maskLayer.path = [path CGPath];
    self.circleLayer.path = [path CGPath];
    
}
- (void) handlePan: (UIPanGestureRecognizer *) pan {
    
    static CGPoint oldCenter;
    
    CGPoint tranlation = [pan translationInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        oldCenter = self.circleCenter;
    }
    
    CGPoint newCenter = CGPointMake(oldCenter.x + tranlation.x, oldCenter.y + tranlation.y);
    
    [self updateCirclePathAtLocation:newCenter radius:self.circleRadius];
    
}
- (void) handPinch: (UIPinchGestureRecognizer *) pin {
    
    static CGFloat oldRadius;
    
    CGFloat scale = [pin scale];
    
    if (pin.state == UIGestureRecognizerStateBegan) {
        
        oldRadius = self.circleRadius;
    }
    
    CGFloat newRadius = oldRadius * scale;
    
    [self updateCirclePathAtLocation:self.circleCenter radius:newRadius];
}

- (void) didTouchUpInsideSaveButton
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"image.jpg"];
    
    CGFloat scale  = [[self.imageView.window screen] scale];
    CGFloat radius = self.circleRadius * scale;
    CGPoint center = CGPointMake(self.circleCenter.x * scale, self.circleCenter.y * scale);
    
    CGRect frame = CGRectMake(center.x - radius,
                              center.y - radius,
                              radius * 2.0,
                              radius * 2.0);
    
    // temporarily remove the circleLayer
    
    CALayer *circleLayer = self.circleLayer;
    [self.circleLayer removeFromSuperlayer];
    
    // render the clipped image
    
    UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self.imageView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        // if iOS 7, just draw it
        
        [self.imageView drawViewHierarchyInRect:self.imageView.bounds afterScreenUpdates:YES];
    }
    else
    {
        // if pre iOS 7, manually clip it
        
        CGContextAddArc(context, self.circleCenter.x, self.circleCenter.y, self.circleRadius, 0, M_PI * 2.0, YES);
        CGContextClip(context);
        [self.imageView.layer renderInContext:context];
    }
    
    // capture the image and close the context
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // add the circleLayer back
    
    [self.imageView.layer addSublayer:circleLayer];
    
    // crop the image
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], frame);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    // save the image
    
    NSData *data = UIImagePNGRepresentation(croppedImage);
    [data writeToFile:path atomically:YES];
    
    // tell the user we're done
    
    [[[UIAlertView alloc] initWithTitle:nil message:@"Saved" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}



- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ((gestureRecognizer == self.pan && otherGestureRecognizer == self.pinch) ||
         (gestureRecognizer == self.pinch && otherGestureRecognizer == self.pan)) {
        
        return YES;
    }
    return  NO;
}
@end
