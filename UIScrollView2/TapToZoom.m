//
//  TapToZoom.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/11/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "TapToZoom.h"
#define size_zoom 1.5
@interface TapToZoom () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *photo;
@property (weak, nonatomic) UILabel *scaleLabel;
@end

@implementation TapToZoom

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.2;
    scrollView.maximumZoomScale = 4;
    scrollView.zoomScale = 1;
    scrollView.clipsToBounds = YES;
    
    UIImageView *photo = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    photo.image = [UIImage imageNamed:@"hotgirl.jpg"];
    photo.contentMode = UIViewContentModeScaleAspectFill;
    
    photo.userInteractionEnabled = YES;
    photo.multipleTouchEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    
    [photo addGestureRecognizer:singleTap];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onDoubleTap:)];
    
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [photo addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap]; // Kiem tra xem co phai doubleTap k ?? Lenh nay rat quan trong
    
    [scrollView addSubview:photo];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.photo = photo;
    
    UILabel *scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    scaleLabel.textAlignment = NSTextAlignmentCenter;
    scaleLabel.text = [NSString stringWithFormat:@"%2.2f",scrollView.zoomScale];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:scaleLabel];
    [self.navigationItem setRightBarButtonItem:barButton];
    self.scaleLabel = scaleLabel;
    
}
- (void) onTap: (UITapGestureRecognizer*) tap {
    
    CGPoint tapPoint = [tap locationInView:self.photo];
    
    float newScale = self.scrollView.zoomScale * size_zoom;
    
    [self zoomRectForScale:newScale
                withCenter:tapPoint];
}
- (void) onDoubleTap: (UITapGestureRecognizer*) tap {
    
    CGPoint tapPoint = [tap locationInView:self.photo];
    
    float newScale = self.scrollView.zoomScale / size_zoom;
    
    [self zoomRectForScale:newScale
                withCenter:tapPoint];
}
- (void) zoomRectForScale: (float) scale
               withCenter: (CGPoint) center {
    
    CGRect zoomRect;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    zoomRect.size.width = scrollViewSize.width / scale;
    zoomRect.size.height = scrollViewSize.height / scale;
    // Chinh toa do goc cho diem phong to;
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2);
    
    [self.scrollView zoomToRect:zoomRect animated:YES];
    self.scaleLabel.text = [NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale];
}
- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.photo;
}
@end
