//
//  PagingScrollView.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/12/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "PagingScrollView.h"
#define PHOTO_WITH 375
#define PHOTO_HEIGHT 480
#define NUM_PHOTO 7
@interface PagingScrollView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation PagingScrollView
{
    UIImageView *imageView;
    UIImageView *imageView2;
    UIScrollView *scrollZoomView;
    CGSize size;
    int Index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    size = self.view.bounds.size;
    NSLog(@"%f",size.width);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((size.width - PHOTO_WITH) / 2,
                                                                     40,
                                                                      PHOTO_WITH + 40,
                                                                      PHOTO_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(PHOTO_WITH * NUM_PHOTO + NUM_PHOTO * 40, PHOTO_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    //self.scrollView.minimumZoomScale = 1;
    //self.scrollView.maximumZoomScale = 4;
    for (int i = 1; i <= NUM_PHOTO; i ++) {
        
        NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i];
        UIImage *image = [UIImage imageNamed:fileName];
        imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.userInteractionEnabled = YES;
        imageView.multipleTouchEnabled = YES;
        imageView.frame = CGRectMake((i - 1) * (PHOTO_WITH + 40), 0, PHOTO_WITH, PHOTO_HEIGHT);
        
        [self.scrollView addSubview:imageView];
    }
 
    [self.view addSubview:self.scrollView];
    
    CGFloat statusNavigationHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, size.height - statusNavigationHeight - 40, size.width, 40)];
    
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = NUM_PHOTO;
    
    [self.pageControl addTarget:self
                         action:@selector(onChangePage:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.pageControl];
    
    //[self zoomImageOfPages];
    
}
- (void) onChangePage:(id)sender {
    
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * (PHOTO_WITH + 40), 0);
    
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = self.scrollView.contentOffset.x / PHOTO_WITH;
}
@end
