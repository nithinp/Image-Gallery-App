//
//  ImageViewController.m
//  Image Gallery App
//
//  Created by user on 21/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController


-(id) init {
    if(self = [super init]){
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.frame = [[UIApplication sharedApplication] keyWindow].frame;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.scrollView addGestureRecognizer:tap];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    for (int i = 0; i < self.imageList.imageList.count; i++) {
        CGFloat xCordImageView = i * [[UIApplication sharedApplication]keyWindow].frame.size.width;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(xCordImageView, 0,
                                             [[UIApplication sharedApplication]keyWindow].frame.size.width,
                                             [[UIApplication sharedApplication]keyWindow].frame.size.height)];
        NSString *imagePath = [self.imageList.imageDirectoryPath stringByAppendingPathComponent:[self.imageList.imageList objectAtIndex:i]];
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
        if(i == self.selectedImageIndex){
            CGFloat xCord = i * [[UIApplication sharedApplication]keyWindow].frame.size.width + (([[UIApplication sharedApplication]keyWindow].frame.size.width)/2)-2.5;
            CGFloat yCord = (([[UIApplication sharedApplication]keyWindow].frame.size.height)/2)-2.5;
            CGRect imageFrame = CGRectMake( xCord,yCord,5 , 5);
            [imageView setFrame:imageFrame];
            imageView.alpha = 0;
            self.imageView = imageView;
        }
        
    }
    self.scrollView.contentSize = CGSizeMake([[UIApplication sharedApplication]keyWindow].frame.size.width *
                                             self.imageList.imageList.count,
                                             [[UIApplication sharedApplication]keyWindow].frame.size.height);
    [self.scrollView scrollRectToVisible:CGRectMake(self.selectedImageIndex * [[UIApplication sharedApplication]keyWindow].frame.size.width, 0, [[UIApplication sharedApplication]keyWindow].frame.size.width, [[UIApplication sharedApplication]keyWindow].frame.size.height) animated:YES];
}


// Code for animating image view.

-(void) animateView {
    CGFloat xCord = self.selectedImageIndex * [[UIApplication sharedApplication]keyWindow].frame.size.width;
    CGFloat yCord = 0;
    CGRect imageFrame = CGRectMake( xCord,yCord,[[UIApplication sharedApplication]keyWindow].frame.size.width , [[UIApplication sharedApplication]keyWindow].frame.size.height);
    [self.imageView setFrame:imageFrame];
    self.imageView.alpha = 1;
}




-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self animateView];
    } completion:nil];
}


// Handler for left swipe.

-(void)handleSwipeLeft:(id)sender {
    NSUInteger imageIndex = (self.selectedImageIndex+1)%self.imageList.imageList.count;
    NSString *imagePath = [self.imageList.imageDirectoryPath stringByAppendingPathComponent:[self.imageList.imageList objectAtIndex:imageIndex]];
    self.selectedImageIndex = imageIndex;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    
}

// Handler for right swipe

-(void)handleSwipeRight:(id)sender {
    NSUInteger imageIndex = (self.selectedImageIndex-1)%self.imageList.imageList.count;
    NSString *imagePath = [self.imageList.imageDirectoryPath stringByAppendingPathComponent:[self.imageList.imageList objectAtIndex:imageIndex]];
    self.selectedImageIndex = imageIndex;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    
}


-(void)handleTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
