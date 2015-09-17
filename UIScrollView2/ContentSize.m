//
//  ContentSize.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/11/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "ContentSize.h"

@interface ContentSize ()

@end

@implementation ContentSize
{
    UIScrollView *scrollView;
    UIImageView *photo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"nha.jpg"];
    
    photo = [[UIImageView alloc] initWithImage:image];
    photo.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width - 16, 300)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize =  CGSizeMake(image.size.width, image.size.height);
    scrollView.bounces = true;
    scrollView.showsHorizontalScrollIndicator = true;
    scrollView.showsVerticalScrollIndicator = true;
    
    [scrollView addSubview:photo];
    [self.view addSubview:scrollView];
}

@end
