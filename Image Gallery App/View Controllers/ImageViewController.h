//
//  ImageViewController.h
//  Image Gallery App
//
//  Created by user on 21/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageList.h"

@interface ImageViewController : UIViewController

@property UIImageView *imageView;
@property ImageList *imageList;
@property NSUInteger selectedImageIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
