//
//  ImageCollectionViewController.m
//  Image Gallery App
//
//  Created by user on 17/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//


#import "ImageCollectionViewController.h"
#import "ImageCollectionViewLayout.h"
#import "ImageCollectionViewCell.h"
#import "ImageList.h"

@interface ImageCollectionViewController ()

@property (nonatomic, weak) IBOutlet ImageCollectionViewLayout *imageCollectionLayout;
@property NSIndexPath *selectedIndexPath;
@property ImageList *imageList;
@property UIActionSheet *addButtonActionSheet;

@end

@implementation ImageCollectionViewController


static NSString * const reuseIdentifier = @"imageGalleryCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = [[ImageList alloc]init];

}



-(void)takePhotoByCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)selectImageFromGallery {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    NSData *pngData = UIImagePNGRepresentation(chosenImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"/AddedImages/image"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    filePath = [filePath stringByAppendingPathExtension:[dateFormatter stringFromDate:[NSDate date]]];
    filePath = [filePath stringByAppendingPathExtension:@"png"];
    [pngData writeToFile:filePath atomically:YES];
    [imagePicker dismissViewControllerAnimated:YES completion:NULL];
    self.imageList.imageList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.imageList.imageDirectoryPath error:NULL];
    [self.collectionView reloadData];
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker{
    [imagePicker dismissViewControllerAnimated:YES completion:NULL];
    
}




# pragma mark - Action sheet functions.
 
-(IBAction)addView:(id)sender {
    self.addButtonActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Add option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Capture image via camera",
                            @"Select image from gallery",
                            nil];
    self.addButtonActionSheet.tag = 1;
    [self.addButtonActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (self.addButtonActionSheet.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self takePhotoByCamera];
                    break;
                case 1:
                    [self selectImageFromGallery];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.imageList.imageList.count == 0){
        [self.noImageLabel setHidden:NO];
    }
    else{
        {
            [self.noImageLabel setHidden:YES];
        }
    }
    return self.imageList.imageList.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageGalleryCell" forIndexPath:indexPath];
    NSString *imagePath;
    imagePath = [self.imageList.imageDirectoryPath stringByAppendingPathComponent:self.imageList.imageList[indexPath.section]];
    cell.imageView.image =[UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier: @"ShowFullscreenView" sender:self];
    
}


# pragma mark - Segue for showing fullscreen view.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowFullscreenView"]) {
        ImageViewController *showFullScreenImage = [segue destinationViewController];
        showFullScreenImage.imageList = self.imageList;
        showFullScreenImage.selectedImageIndex = self.selectedIndexPath.section;
    }
    
}




@end
