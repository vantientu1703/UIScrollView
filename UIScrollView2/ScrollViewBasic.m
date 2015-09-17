//
//  ScrollViewBasic.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/11/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "ScrollViewBasic.h"

@interface ScrollViewBasic () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) UILabel *scaleZoom;
@end

@implementation ScrollViewBasic
{
    UIImageView *photo;
    UISlider *slider;
    UIToolbar *toolBar;
    UILabel *labelValueScale;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    toolBar = [UIToolbar new];
    [toolBar sizeToFit];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(8, 0, self.view.bounds.size.width - 16, 40)];
    slider.minimumValue = 0.2;
    slider.maximumValue = 4;
    slider.value = slider.minimumValue;
    [slider addTarget:self
               action:@selector(onChange:)
     forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:slider];
    toolBar.items = @[barButton];
    toolBar.frame = CGRectMake(0, self.view.bounds.size.height - toolBar.bounds.size.height,
                               toolBar.bounds.size.width,
                               toolBar.bounds.size.height);
    [self.view addSubview:toolBar];
    
    CGRect rectScroll = CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height - toolBar.bounds.size.height);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:rectScroll];
    photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thiennhien.jpg"]];
    
    [self.scrollView addSubview:photo];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = slider.minimumValue;
    self.scrollView.maximumZoomScale = slider.maximumValue;
    
    self.scrollView.zoomScale = slider.value;

    [self.view addSubview:self.scrollView];
    
    //self.scaleZoom.text = labelValueScale;
    UIBarButtonItem *barButtton = [[UIBarButtonItem alloc] initWithCustomView:labelValueScale];
    
    [self.navigationItem setRightBarButtonItem:barButtton];
}

- (void) onChange: (UISlider*) sender {
    [self.scrollView setZoomScale:sender.value
                         animated:true];
}
- (UIView*) viewForZoomingInScrollView: (UIScrollView*) scrollView {
    return photo;
}
- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    
    labelValueScale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    labelValueScale.textAlignment = NSTextAlignmentCenter;
    labelValueScale.text = [NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale];
    UIBarButtonItem *barButtton = [[UIBarButtonItem alloc] initWithCustomView:labelValueScale];
    
    [self.navigationItem setRightBarButtonItem:barButtton];
    slider.value = self.scrollView.zoomScale;
}
@end
