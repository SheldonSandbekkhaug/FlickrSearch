#import "FLSDataSource.h"

#import "FLSFlickrClient.h"
#import "FLSPhotoCollectionViewCell.h"

NSString *const FLSCellIdentifier = @"FLSCellIdentifier";

@interface FLSDataSource () <FLSFlickrClientDelegate>

/** Client for downloading Flickr search results. */
@property(nonatomic) FLSFlickrClient *client;

/** The photos to be shown in the collection view. */
@property(nonatomic) NSMutableArray<FLSPhoto *> *photos;

/** The string to search Flickr for. */
@property(nonatomic) NSString *query;

/** YES if the app is loading another page. NO otherwise. */
@property(nonatomic) BOOL isLoading;

/** The page of results that was most recently requested to be loaded. */
@property(nonatomic) int lastLoadedPage;

@end

@implementation FLSDataSource

- (void)showPicturesWithQuery:(NSString *)query {
  if (!_client) {
    _client = [[FLSFlickrClient alloc] initWithDelegate:self];
  }

  _photos = [NSMutableArray array];
  _query = query;

  [_collectionView reloadData];
  _isLoading = YES;
  [_client fetchWithQuery:_query];
  _lastLoadedPage = 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  FLSPhotoCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:FLSCellIdentifier
                                                forIndexPath:indexPath];

  if (indexPath.item < _photos.count) {
    cell.photo = _photos[indexPath.item];
  }

  if (indexPath.item == _photos.count - 1) {
    // The last item in the collection view triggers a new page to be loaded
    if (_query.length && !_isLoading) {
      _isLoading = YES;
      _lastLoadedPage++;
      [_client fetchWithQuery:_query page:_lastLoadedPage];
    }
  }

  // TODO: Add image cache
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _photos.count;
}

- (void)didReceiveSearchResults:(NSMutableArray<FLSPhoto *> *)results {
  dispatch_async(dispatch_get_main_queue(), ^{
    self->_isLoading = NO;
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    for (int i = (int)self->_photos.count; i < self->_photos.count + results.count; ++i) {
      NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
      [indexPaths addObject:path];
    }

    [self->_photos addObjectsFromArray:results];
    [self->_collectionView insertItemsAtIndexPaths:indexPaths];
  });
}

@end
