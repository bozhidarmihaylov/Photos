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
#import "PSPhotosResponse.h"
#import "PSPhotoThumbnailURLMaker.h"

#import <ObjectiveSugar/ObjectiveSugar.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString * const ThumbnailCellIdentifier = @"PSThumbnailCell";

@interface PSPhotoGridViewController ()

@property (strong, nonatomic) PSPhotosManager *photosManager;

@property (strong, nonatomic) PSPhotoThumbnailURLMaker *urlMaker;

@property (strong, nonatomic) PSPageCursor *currentPageCursor;
@property (strong, nonatomic) NSMutableArray *photos;

@property (assign, nonatomic) BOOL loadingNextPage;

@property (assign, nonatomic) CGSize itemSize;

@end

@implementation PSPhotoGridViewController

#pragma mark - Initialization

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass([PSPhotoGridViewController class])
                           bundle:nil];
}

#pragma mark - Accessors / Mutators

- (PSPhoto *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return self.photos[indexPath.row];
}

- (NSNumber *)interItemOffset {
    return _interItemOffset ?: (self.interItemOffset = @(5.0f));
}

- (NSNumber *)numberOfColumns {
    return _numberOfColumns ?: (self.numberOfColumns = @(3));
}

- (PSPhotosManager *)photosManager {
    return _photosManager ?: (self.photosManager = [PSPhotosManager sharedManager]);
}

- (PSPageCursor *)currentPageCursor {
    return _currentPageCursor ?: (self.currentPageCursor = [PSPageCursor cursorWithPage:@(0)
                                                                                perPage:@(20)]);
}

- (NSMutableArray *)photos {
    return _photos ?: (self.photos = [NSMutableArray new]);
}

- (PSPhotoThumbnailURLMaker *)urlMaker {
    return _urlMaker ?: (self.urlMaker = [PSPhotoThumbnailURLMaker new]);
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCells];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupCollectionViewLayout];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadNextPage];
}

- (void)loadNextPage {
    if (!self.loadingNextPage) {
        self.loadingNextPage = YES;
        
        __weak typeof(self) weakSelf = self;
        
        PSPageCursor *nextCursor = [self.currentPageCursor nextCursor];
        
        [self.photosManager photosWithSearchText:self.searchString
                                      pageCursor:nextCursor
                                      completion:^(PSPhotosResponse *response, NSError *error) {
                                          weakSelf.loadingNextPage = NO;
                                          
                                          if (!error) {
                                              weakSelf.currentPageCursor = nextCursor;
                                              
                                              __block NSInteger offset = weakSelf.photos.count;
                                              
                                              [weakSelf.photos addObjectsFromArray:response.results];
                                              
                                              NSArray *indexPaths = [response.results map:^id(id object) {
                                                  return [NSIndexPath indexPathForItem:offset++
                                                                             inSection:0];
                                              }];
                                              
                                              [weakSelf.collectionView insertItemsAtIndexPaths:indexPaths];
                                          }
                                      }];
    }
}

- (CGFloat)scale {
    return [UIScreen mainScreen].scale;
}

- (void)setupCollectionViewLayout {
    UICollectionView *collectionView = self.collectionView;
    
    UIEdgeInsets contentInset = collectionView.contentInset;
    
    CGFloat horizontalInset = contentInset.left + contentInset.right;
    CGFloat interItemOffset = self.interItemOffset.floatValue;
    CGFloat numberOfColumns = self.numberOfColumns.integerValue;
    
    CGFloat itemLength = (CGRectGetWidth(collectionView.frame) - horizontalInset + interItemOffset) / numberOfColumns - interItemOffset;
    
    CGFloat scale = self.scale;
    
    itemLength = truncf(itemLength * scale) / scale;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = interItemOffset;
    layout.minimumInteritemSpacing = interItemOffset;
    self.itemSize = layout.itemSize = CGSizeMake(itemLength, itemLength);
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PSThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThumbnailCellIdentifier
                                                                      forIndexPath:indexPath];
    
    PSPhoto *photo = [self photoAtIndexPath:indexPath];
    
    NSURL *photoURL = [self.urlMaker URLForThumbnailOfPhoto:photo
                                          scalledToFillSize:self.itemSize];
    
    [cell.imageView setImageWithURL:photoURL];
        
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + scrollView.bounds.size.height >= scrollView.contentSize.height - 50.0f) {
        [self loadNextPage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(PSThumbnailCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.imageView cancelImageDownloadTask];
}

@end

