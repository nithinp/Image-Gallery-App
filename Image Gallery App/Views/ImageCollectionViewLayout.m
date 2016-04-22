//
//  ImageCollectionViewLayout.m
//  Image Gallery App
//
//  Created by user on 18/09/15.
//  Copyright (c) 2015 Nithin.P. All rights reserved.
//

#import "ImageCollectionViewLayout.h"

static NSString * const imageCell = @"PhotoCell";

@interface ImageCollectionViewLayout ()




@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation ImageCollectionViewLayout


#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}


// Setup layout.

- (void)setup {
    self.numberOfColumns = 3;
    self.itemInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.cellSize = CGSizeMake((screenWidth-20)/3, (screenWidth-20)/3);
    self.interCellSpacingY = 5.0f;
    
}



- (void)prepareLayout {
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForGalleryCellAtIndexPath:indexPath];
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    newLayoutInfo[imageCell] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}



- (CGRect)frameForGalleryCellAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.cellSize.width);
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    CGFloat originX = floorf(self.itemInsets.left + (self.cellSize.width + spacingX) * column);
    CGFloat originY = floor(self.itemInsets.top +
                            (self.cellSize.height + self.interCellSpacingY) * row);
    return CGRectMake(originX, originY, self.cellSize.width, self.cellSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutInfo[imageCell][indexPath];
}

- (CGSize)collectionViewContentSize {
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    CGFloat height = self.itemInsets.top +
    rowCount * self.cellSize.height + (rowCount - 1) * self.interCellSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}




@end
