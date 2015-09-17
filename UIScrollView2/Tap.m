//
//  Tap.m
//  UIScrollView
//
//  Created by Văn Tiến Tú on 9/13/15.
//  Copyright (c) 2015 Văn Tiến Tú. All rights reserved.
//

#import "Tap.h"

@interface Tap ()<UIGestureRecognizerDelegate>

@end

@implementation Tap
{
    UIImageView *grass;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = self.view.bounds.size;
    
    grass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baico.jpg"]];
    
    grass.frame = CGRectMake(0, 0, size.width, size.height);
    
    grass.userInteractionEnabled = YES;
    grass.multipleTouchEnabled = YES;
    
    [self.view addSubview:grass];
    
    UITapGestureRecognizer *tapGrass = [[UITapGestureRecognizer alloc] initWithTarget:self // Cham vao man hinh
                                                                               action:@selector(onTap:)];
    [grass addGestureRecognizer:tapGrass];
}
- (void) onTap:(UITapGestureRecognizer*) tap {
    
    CGPoint point = [tap locationInView:self.view];
    UIImageView *ant = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ant.png"]];
    
    ant.center = point;
    [grass addSubview:ant];
}

@end
