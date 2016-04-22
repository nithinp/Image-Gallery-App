//
//  ImageList.m
//  Image Gallery App
//
//  Created by user on 21/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import "ImageList.h"

@implementation ImageList

-(id)init{
    if (self = [super init]) {
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        self.imageDirectoryPath = [documentsDirectory stringByAppendingPathComponent:@"/AddedImages"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:self.imageDirectoryPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:self.imageDirectoryPath withIntermediateDirectories:NO attributes:nil error:&error];
            //NSLog(@"Accessing document folder");
            
            
        }
        
        self.imageList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.imageDirectoryPath error:NULL];
        

    }
    return self;
}

@end
