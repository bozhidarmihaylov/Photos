//
//  PSPhotoGridViewController.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotoGridViewController.h"
#import "PSThumbnailCell.h"
#import "PSPhotosManager.h"

static NSString * const ThumbnailCellIdentifier = @"PSThumbnailCell";

@interface PSPhotoGridViewController ()

@property (strong, nonatomic) PSPhotosManager *photosManager;

@end

@implementation PSPhotoGridViewController

#pragma mark - Initialization

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([PSPhotoGridViewController class])
                           bundle:nil];
}

#pragma mark - Accessors / Mutators

- (NSNumber *)interItemOffset {
    return _interItemOffset ?: (self.interItemOffset = @(5.0f));
}

- (NSNumber *)numberOfColumns {
    return _numberOfColumns ?: (self.numberOfColumns = @(3));
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UICollectionView *collectionView = self.collectionView;
    
    UIEdgeInsets contentInset = collectionView.contentInset;
    
    CGFloat horizontalInset = contentInset.left + contentInset.right;
    CGFloat interItemOffset = self.interItemOffset.floatValue;
    CGFloat numberOfColumns = self.numberOfColumns.integerValue;
    
    CGFloat itemLength = (CGRectGetWidth(collectionView.frame) - horizontalInset + interItemOffset) / numberOfColumns - interItemOffset;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = interItemOffset;
    layout.minimumInteritemSpacing = interItemOffset;
    layout.itemSize = CGSizeMake(itemLength, itemLength);    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerCells {
    UINib *nib = [UINib nibWithNibName:ThumbnailCellIdentifier
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:ThumbnailCellIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThumbnailCellIdentifier
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0f
                                           green:arc4random() % 256 / 255.0f
                                            blue:arc4random() % 256 / 255.0f
                                           alpha:1.0f];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

