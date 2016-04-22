//
//  ImageCollectionViewLayout.h
//  Image Gallery App
//
//  Created by user on 18/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewLayout : UICollectionViewLayout


@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize cellSize;
@property (nonatomic) CGFloat interCellSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
