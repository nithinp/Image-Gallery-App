//
//  ImageCollectionViewController.h
//  Image Gallery App
//
//  Created by user on 17/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewController.h"

@interface ImageCollectionViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate> {
    UICollectionView *_collectionView;
}
@property (weak, nonatomic) IBOutlet UILabel *noImageLabel;

@end
